/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

using FairyGUI;
using System.Threading.Tasks;

namespace ET
{
    [ObjectSystem]
    public class FUILoginAwakeSystem : AwakeSystem<FUILogin, GObject>
    {
        public override void Awake(FUILogin self, GObject go)
        {
            self.Awake(go);
        }
    }
        
    public sealed class FUILogin : FUI
    {	
        public const string UIPackageName = "Login";
        public const string UIResName = "Login";
        
        /// <summary>
        /// {uiResName}的组件类型(GComponent、GButton、GProcessBar等)，它们都是GObject的子类。
        /// </summary>
        public GComponent self;
            
    public GImage bg;
    public GImage contentBG;
    public GImage accountBg;
    public GTextInput accountInput;
    public GImage passwordBg;
    public GTextInput passwordInput;
    public FUITitleButton loginButton;
    public GGroup content;
    public const string URL = "ui://2w4fpdl4ofor0";

    private static GObject CreateGObject()
    {
        return UIPackage.CreateObject(UIPackageName, UIResName);
    }
    
    private static void CreateGObjectAsync(UIPackage.CreateObjectCallback result)
    {
        UIPackage.CreateObjectAsync(UIPackageName, UIResName, result);
    }
        
    public static FUILogin CreateInstance(Entity domain)
    {			
        return EntityFactory.Create<FUILogin, GObject>(domain, CreateGObject());
    }
        
    public static Task<FUILogin> CreateInstanceAsync(Entity domain)
    {
        TaskCompletionSource<FUILogin> tcs = new TaskCompletionSource<FUILogin>();

        CreateGObjectAsync((go) =>
        {
            tcs.SetResult(EntityFactory.Create<FUILogin, GObject>(domain, go));
        });

        return tcs.Task;
    }
        
    public static FUILogin Create(Entity domain, GObject go)
    {
        return EntityFactory.Create<FUILogin, GObject>(domain, go);
    }
        
    /// <summary>
    /// 通过此方法获取的FUI，在Dispose时不会释放GObject，需要自行管理（一般在配合FGUI的Pool机制时使用）。
    /// </summary>
    public static FUILogin GetFormPool(Entity domain, GObject go)
    {
        var fui = go.Get<FUILogin>();

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
    		contentBG = (GImage)com.GetChild("contentBG");
    		accountBg = (GImage)com.GetChild("accountBg");
    		accountInput = (GTextInput)com.GetChild("accountInput");
    		passwordBg = (GImage)com.GetChild("passwordBg");
    		passwordInput = (GTextInput)com.GetChild("passwordInput");
    		loginButton = FUITitleButton.Create(domain, com.GetChild("loginButton"));
    		content = (GGroup)com.GetChild("content");
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
			contentBG = null;
			accountBg = null;
			accountInput = null;
			passwordBg = null;
			passwordInput = null;
			loginButton.Dispose();
			loginButton = null;
			content = null;
		}
}
}