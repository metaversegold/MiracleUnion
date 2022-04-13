/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

using FairyGUI;
using System.Threading.Tasks;

namespace ET
{
    [ObjectSystem]
    public class FUILoadingAwakeSystem : AwakeSystem<FUILoading, GObject>
    {
        public override void Awake(FUILoading self, GObject go)
        {
            self.Awake(go);
        }
    }
        
    public sealed class FUILoading : FUI
    {	
        public const string UIPackageName = "Common";
        public const string UIResName = "Loading";
        
        /// <summary>
        /// {uiResName}的组件类型(GComponent、GButton、GProcessBar等)，它们都是GObject的子类。
        /// </summary>
        public GComponent self;
            
    public GImage bg;
    public GTextField loadingText;
    public FUILoadingProgressBar loadingBar;
    public const string URL = "ui://1n4czledsfv94";

    private static GObject CreateGObject()
    {
        return UIPackage.CreateObject(UIPackageName, UIResName);
    }
    
    private static void CreateGObjectAsync(UIPackage.CreateObjectCallback result)
    {
        UIPackage.CreateObjectAsync(UIPackageName, UIResName, result);
    }
        
    public static FUILoading CreateInstance(Entity domain)
    {			
        return EntityFactory.Create<FUILoading, GObject>(domain, CreateGObject());
    }
        
    public static Task<FUILoading> CreateInstanceAsync(Entity domain)
    {
        TaskCompletionSource<FUILoading> tcs = new TaskCompletionSource<FUILoading>();

        CreateGObjectAsync((go) =>
        {
            tcs.SetResult(EntityFactory.Create<FUILoading, GObject>(domain, go));
        });

        return tcs.Task;
    }
        
    public static FUILoading Create(Entity domain, GObject go)
    {
        return EntityFactory.Create<FUILoading, GObject>(domain, go);
    }
        
    /// <summary>
    /// 通过此方法获取的FUI，在Dispose时不会释放GObject，需要自行管理（一般在配合FGUI的Pool机制时使用）。
    /// </summary>
    public static FUILoading GetFormPool(Entity domain, GObject go)
    {
        var fui = go.Get<FUILoading>();

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
    		loadingText = (GTextField)com.GetChild("loadingText");
    		loadingBar = FUILoadingProgressBar.Create(domain, com.GetChild("loadingBar"));
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
			loadingText = null;
			loadingBar.Dispose();
			loadingBar = null;
		}
}
}