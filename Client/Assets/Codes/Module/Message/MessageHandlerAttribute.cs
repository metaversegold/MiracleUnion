namespace ET
{
    public class MessageHandlerAttribute: BaseAttribute
    {
    }
    
    public class CmdTextHandlerAttribute: BaseAttribute
    {
        public TCPGameServerCmds Cmd { get; set; }

        public CmdTextHandlerAttribute() { }

        public CmdTextHandlerAttribute(TCPGameServerCmds cmd)
        {
            this.Cmd = cmd;
        }
    }
    
    public class CmdByteHandlerAttribute: BaseAttribute
    {
        public TCPGameServerCmds Cmd { get; set; }

        public CmdByteHandlerAttribute() { }

        public CmdByteHandlerAttribute(TCPGameServerCmds cmd)
        {
            this.Cmd = cmd;
        }
    }
}