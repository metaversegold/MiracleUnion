using System;
using System.Text;

namespace ET
{
    public abstract class CmdTextHandler
    {
        protected abstract ETTask Run(Session session, string message);

        public void Handle(Session session, string msg)
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