using System;
using System.Text;

namespace ET
{
    public abstract class CmdByteHandler
    {
        protected abstract ETTask Run(Session session, byte[] message);

        public void Handle(Session session, byte[] msg)
        {
            if (session.IsDisposed)
            {
                Log.Error($"session disconnect {msg}");
                return;
            }

            this.Run(session, msg).Coroutine();
        }
    }
}