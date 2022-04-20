using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;

namespace ET
{
    [ObjectSystem]
    public class MessageDispatcherComponentAwakeSystem: AwakeSystem<MessageDispatcherComponent>
    {
        public override void Awake(MessageDispatcherComponent self)
        {
            MessageDispatcherComponent.Instance = self;
            self.Load();
        }
    }

    [ObjectSystem]
    public class MessageDispatcherComponentLoadSystem: LoadSystem<MessageDispatcherComponent>
    {
        public override void Load(MessageDispatcherComponent self)
        {
            self.Load();
        }
    }

    [ObjectSystem]
    public class MessageDispatcherComponentDestroySystem: DestroySystem<MessageDispatcherComponent>
    {
        public override void Destroy(MessageDispatcherComponent self)
        {
            MessageDispatcherComponent.Instance = null;
            self.Handlers.Clear();
        }
    }

    /// <summary>
    /// 消息分发组件
    /// </summary>
    public static class MessageDispatcherComponentHelper
    {
        public static void Load(this MessageDispatcherComponent self)
        {
            self.Handlers.Clear();

            HashSet<Type> types = Game.EventSystem.GetTypes(typeof (MessageHandlerAttribute));

            foreach (Type type in types)
            {
                IMHandler iMHandler = Activator.CreateInstance(type) as IMHandler;
                if (iMHandler == null)
                {
                    Log.Error($"message handle {type.Name} 需要继承 IMHandler");
                    continue;
                }

                Type messageType = iMHandler.GetMessageType();
                ushort opcode = OpcodeTypeComponent.Instance.GetOpcode(messageType);
                if (opcode == 0)
                {
                    Log.Error($"消息opcode为0: {messageType.Name}");
                    continue;
                }

                self.RegisterHandler(opcode, iMHandler);
            }
            
            self.THandlers.Clear();

            types = Game.EventSystem.GetTypes(typeof (CmdTextHandlerAttribute));

            foreach (Type type in types)
            {
                CmdTextHandler iMHandler = Activator.CreateInstance(type) as CmdTextHandler;
                if (iMHandler == null)
                {
                    Log.Error($"message handle {type.Name} 需要继承 CmdTextHandler");
                    continue;
                }

                var classInfo = type.GetCustomAttribute<CmdTextHandlerAttribute>();
                ushort opcode = (ushort)classInfo.Cmd;
                if (opcode == 0)
                {
                    Log.Error($"消息opcode为0: {type.Name}");
                    continue;
                }

                self.RegisterTHandler(opcode, iMHandler);
            }
            
            self.BHandlers.Clear();

            types = Game.EventSystem.GetTypes(typeof (CmdByteHandlerAttribute));

            foreach (Type type in types)
            {
                CmdByteHandler iMHandler = Activator.CreateInstance(type) as CmdByteHandler;
                if (iMHandler == null)
                {
                    Log.Error($"message handle {type.Name} 需要继承 CmdByteHandler");
                    continue;
                }

                var classInfo = type.GetCustomAttribute<CmdByteHandlerAttribute>();
                ushort opcode = (ushort)classInfo.Cmd;
                if (opcode == 0)
                {
                    Log.Error($"消息opcode为0: {type.Name}");
                    continue;
                }

                self.RegisterBHandler(opcode, iMHandler);
            }
        }

        public static void RegisterHandler(this MessageDispatcherComponent self, ushort opcode, IMHandler handler)
        {
            if (!self.Handlers.ContainsKey(opcode))
            {
                self.Handlers.Add(opcode, new List<IMHandler>());
            }

            self.Handlers[opcode].Add(handler);
        }

        public static void RegisterTHandler(this MessageDispatcherComponent self, ushort opcode, CmdTextHandler handler)
        {
            if (!self.THandlers.ContainsKey(opcode))
            {
                self.THandlers.Add(opcode, new List<CmdTextHandler>());
            }

            self.THandlers[opcode].Add(handler);
        }

        public static void RegisterBHandler(this MessageDispatcherComponent self, ushort opcode, CmdByteHandler handler)
        {
            if (!self.BHandlers.ContainsKey(opcode))
            {
                self.BHandlers.Add(opcode, new List<CmdByteHandler>());
            }

            self.BHandlers[opcode].Add(handler);
        }

        public static void Handle(this MessageDispatcherComponent self, Session session, ushort opcode, object message)
        {
            List<IMHandler> actions;
            if (!self.Handlers.TryGetValue(opcode, out actions))
            {
                Log.Error($"消息没有处理: {opcode} {message}");
                return;
            }

            foreach (IMHandler ev in actions)
            {
                try
                {
                    ev.Handle(session, message);
                }
                catch (Exception e)
                {
                    Log.Error(e);
                }
            }
        }

        public static void CmdHandle(this MessageDispatcherComponent self, Session session, ushort opcode, byte[] messageBytes)
        {
            int offsetLen = 2;
            
            if (self.THandlers.ContainsKey(opcode))
            {
                List<CmdTextHandler> actions;
                if (!self.THandlers.TryGetValue(opcode, out actions))
                {
                    Log.Error($"消息没有处理: {opcode} {BitConverter.ToString(messageBytes)}");
                    return;
                }
                string message = new UTF8Encoding().GetString(messageBytes, 2, (int) messageBytes.Length-offsetLen);
                
                foreach (CmdTextHandler ev in actions)
                {
                    try
                    {
                        ev.Handle(session, message);
                    }
                    catch (Exception e)
                    {
                        Log.Error(e);
                    }
                }
            }
            else
            {
                List<CmdByteHandler> actions;
                if (!self.BHandlers.TryGetValue(opcode, out actions))
                {
                    Log.Error($"消息没有处理: {opcode} {BitConverter.ToString(messageBytes)}");
                    return;
                }

                byte[] message = new byte[messageBytes.Length-offsetLen];
                DataHelper.CopyBytes(message, 0, messageBytes, offsetLen, messageBytes.Length - offsetLen);
                
                foreach (CmdByteHandler ev in actions)
                {
                    try
                    {
                        ev.Handle(session, message);
                    }
                    catch (Exception e)
                    {
                        Log.Error(e);
                    }
                }
            }
        }
    }
}