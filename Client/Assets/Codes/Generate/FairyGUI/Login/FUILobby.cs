/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

using FairyGUI;
using System.Threading.Tasks;

namespace ET
{
    [ObjectSystem]
    public class FUILobbyAwakeSystem : AwakeSystem<FUILobby, GObject>
    {
        public override void Awake(FUILobby self, GObject go)
        {
            self.Awake(go);
        }
    }
        
    public sealed class FUILobby : FUI
    {	
        public const string UIPackageName = "Login";
        public const string UIResName = "Lobby";
        
        /// <summary>
        /// {uiResName}的组件类型(GComponent、GButton、GProcessBar等)，它们都是GObject的子类。
        /// </summary>
        public GComponent self;
            
    public GImage bg;
    public FUITitleButton enterButton;
    public const string URL = "ui://2w4fpdl4hbe5e";

    private static GObject CreateGObject()
    {
        return UIPackage.CreateObject(UIPackageName, UIResName);
    }
    
    private static void CreateGObjectAsync(UIPackage.CreateObjectCallback result)
    {
        UIPackage.CreateObjectAsync(UIPackageName, UIResName, result);
    }
        
    public static FUILobby CreateInstance(Entity domain)
    {			
        return EntityFactory.Create<FUILobby, GObject>(domain, CreateGObject());
    }
        
    public static Task<FUILobby> CreateInstanceAsync(Entity domain)
    {
        TaskCompletionSource<FUILobby> tcs = new TaskCompletionSource<FUILobby>();

        CreateGObjectAsync((go) =>
        {
            tcs.SetResult(EntityFactory.Create<FUILobby, GObject>(domain, go));
        });

        return tcs.Task;
    }
        
    public static FUILobby Create(Entity domain, GObject go)
    {
        return EntityFactory.Create<FUILobby, GObject>(domain, go);
    }
        
    /// <summary>
    /// 通过此方法获取的FUI，在Dispose时不会释放GObject，需要自行管理（一般在配合FGUI的Pool机制时使用）。
    /// </summary>
    public static FUILobby GetFormPool(Entity domain, GObject go)
    {
        var fui = go.Get<FUILobby>();

        if(fui == null)
        {
            fui = Create(domain, go);
        }

        fui.isFromFGUIPool = true;

        return fui;
    }
        
    public void Awake(GObject go)
    {
        if(go == null)
        {
            return;
        }
        
        GObject = go;	
        
        if (string.IsNullOrWhiteSpace(Name))
        {
            Name = Id.ToString();
        }
        
        self = (GComponent)go;
        
        self.Add(this);
        
        var com = go.asCom;
            
        if(com != null)
        {	
            
    		bg = (GImage)com.GetChild("bg");
    		enterButton = FUITitleButton.Create(domain, com.GetChild("enterButton"));
    	}
}
       public override void Dispose()
       {
            if(IsDisposed)
            {
                return;
            }
            
            base.Dispose();
            
            self.Remove();
            self = null;
            
			bg = null;
			enterButton.Dispose();
			enterButton = null;
		}
}
}