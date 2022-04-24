using System;
using System.Text;

namespace ET
{
    public abstract class CmdTextHandler
    {
        protected abstract ETTask Run(Session session, string[] fields);

        public void Handle(Session session, string msg)
        {
            if (session.IsDisposed)
            {
                Log.Error($"session disconnect {msg}");
                return;
            }

            string[] fields = msg.Split(':');
            
            this.Run(session, fields).Coroutine();
        }
    }
}