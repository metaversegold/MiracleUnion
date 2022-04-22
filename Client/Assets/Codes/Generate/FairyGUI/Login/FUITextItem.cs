/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

using FairyGUI;
using System.Threading.Tasks;

namespace ET
{
    [ObjectSystem]
    public class FUITextItemAwakeSystem : AwakeSystem<FUITextItem, GObject>
    {
        public override void Awake(FUITextItem self, GObject go)
        {
            self.Awake(go);
        }
    }
        
    public sealed class FUITextItem : FUI
    {	
        public const string UIPackageName = "Login";
        public const string UIResName = "TextItem";
        
        /// <summary>
        /// {uiResName}的组件类型(GComponent、GButton、GProcessBar等)，它们都是GObject的子类。
        /// </summary>
        public GComponent self;
            
    public GTextField CharName;
    public const string URL = "ui://2w4fpdl4jscrg";

    private static GObject CreateGObject()
    {
        return UIPackage.CreateObject(UIPackageName, UIResName);
    }
    
    private static void CreateGObjectAsync(UIPackage.CreateObjectCallback result)
    {
        UIPackage.CreateObjectAsync(UIPackageName, UIResName, result);
    }
        
    public static FUITextItem CreateInstance(Entity domain)
    {			
        return EntityFactory.Create<FUITextItem, GObject>(domain, CreateGObject());
    }
        
    public static Task<FUITextItem> CreateInstanceAsync(Entity domain)
    {
        TaskCompletionSource<FUITextItem> tcs = new TaskCompletionSource<FUITextItem>();

        CreateGObjectAsync((go) =>
        {
            tcs.SetResult(EntityFactory.Create<FUITextItem, GObject>(domain, go));
        });

        return tcs.Task;
    }
        
    public static FUITextItem Create(Entity domain, GObject go)
    {
        return EntityFactory.Create<FUITextItem, GObject>(domain, go);
    }
        
    /// <summary>
    /// 通过此方法获取的FUI，在Dispose时不会释放GObject，需要自行管理（一般在配合FGUI的Pool机制时使用）。
    /// </summary>
    public static FUITextItem GetFormPool(Entity domain, GObject go)
    {
        var fui = go.Get<FUITextItem>();

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
            
    		CharName = (GTextField)com.GetChild("CharName");
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
            
			CharName = null;
		}
}
}