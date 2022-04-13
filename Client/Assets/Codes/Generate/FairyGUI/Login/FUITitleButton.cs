/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

using FairyGUI;
using System.Threading.Tasks;

namespace ET
{
    [ObjectSystem]
    public class FUITitleButtonAwakeSystem : AwakeSystem<FUITitleButton, GObject>
    {
        public override void Awake(FUITitleButton self, GObject go)
        {
            self.Awake(go);
        }
    }
        
    public sealed class FUITitleButton : FUI
    {	
        public const string UIPackageName = "Login";
        public const string UIResName = "TitleButton";
        
        /// <summary>
        /// {uiResName}的组件类型(GComponent、GButton、GProcessBar等)，它们都是GObject的子类。
        /// </summary>
        public GButton self;
            
    public GImage bg;
    public const string URL = "ui://2w4fpdl4hbe5a";

    private static GObject CreateGObject()
    {
        return UIPackage.CreateObject(UIPackageName, UIResName);
    }
    
    private static void CreateGObjectAsync(UIPackage.CreateObjectCallback result)
    {
        UIPackage.CreateObjectAsync(UIPackageName, UIResName, result);
    }
        
    public static FUITitleButton CreateInstance(Entity domain)
    {			
        return EntityFactory.Create<FUITitleButton, GObject>(domain, CreateGObject());
    }
        
    public static Task<FUITitleButton> CreateInstanceAsync(Entity domain)
    {
        TaskCompletionSource<FUITitleButton> tcs = new TaskCompletionSource<FUITitleButton>();

        CreateGObjectAsync((go) =>
        {
            tcs.SetResult(EntityFactory.Create<FUITitleButton, GObject>(domain, go));
        });

        return tcs.Task;
    }
        
    public static FUITitleButton Create(Entity domain, GObject go)
    {
        return EntityFactory.Create<FUITitleButton, GObject>(domain, go);
    }
        
    /// <summary>
    /// 通过此方法获取的FUI，在Dispose时不会释放GObject，需要自行管理（一般在配合FGUI的Pool机制时使用）。
    /// </summary>
    public static FUITitleButton GetFormPool(Entity domain, GObject go)
    {
        var fui = go.Get<FUITitleButton>();

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
        
        self = (GButton)go;
        
        self.Add(this);
        
        var com = go.asCom;
            
        if(com != null)
        {	
            
    		bg = (GImage)com.GetChild("bg");
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
		}
}
}