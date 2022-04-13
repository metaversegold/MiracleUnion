using System;
using FairyGUI;
using UnityEngine;

namespace ET
{
	
	[ObjectSystem]
	public class FUIComponentAwakeSystem : AwakeSystem<FUIComponent>
	{
		public override void Awake(FUIComponent self)
		{
			self.Root = EntityFactory.CreateWithParent<FUI, GObject>(self, GRoot.inst);
		}
	}
	
	[ObjectSystem]
	public class FUIComponentUpdateSystem : UpdateSystem<FUIComponent>
	{
		public override void Update(FUIComponent self)
		{
			self.Update();
		}
	}

	/// <summary>
	/// 管理所有顶层UI, 顶层UI都是GRoot的孩子
	/// </summary>
	public class FUIComponent: Entity, IAwake, IUpdate
	{
		public FUI Root;

		public float EditScaleFactor = 1;

		[HideInInspector]
		private float scaleFactor = 1;

		public void Update()
		{
			if (Application.isEditor)
			{
				float ret = (float)Math.Round(EditScaleFactor,2);
				if (!Mathf.Approximately(scaleFactor,ret))
					SetScaleFactor(EditScaleFactor);
			}
		}
		
		public override void Dispose()
		{
			if (IsDisposed)
			{
				return;
			}

			base.Dispose();

            Root?.Dispose();
            Root = null;
		}

		public void Add(FUI ui, bool asChildGObject)
		{
			Root?.Add(ui, asChildGObject);
			SetScale(ui);
		}
		
		public void Remove(string name)
		{
			Root?.Remove(name);
		}
		
		public FUI Get(string name)
		{
			return Root?.Get(name);
        }

        public FUI[] GetAll()
        {
            return Root?.GetAll();
        }

        public void Clear()
        {
            var childrens = GetAll();

            if(childrens != null)
            {
                foreach (var fui in childrens)
                {
                    Remove(fui.Name);
                }
            }
        }

        /// <summary>
        /// 设置全局缩放
        /// </summary>
        /// <param name="scale"></param>
        public void SetScaleFactor(float scale)
        {
	        float ret = (float)Math.Round(scale,2);
	        if (!Mathf.Approximately(scaleFactor,ret))
	        {
		        scaleFactor = ret;
		        ApplyContentScaleFactor();
	        }
        }

        /// <summary>
        /// 应用全局缩放到所有当前打开的界面
        /// </summary>
        private void ApplyContentScaleFactor()
        {
	        foreach (var value in Root.Children.Values)
	        {
		        FUI child = (FUI) value;
		        SetScale(child);
	        }
        }

        /// <summary>
        /// 设置ui下的子ui缩放
        /// </summary>
        /// <param name="fui"></param>
        private void SetScale(FUI fui)
        {
	        GComponent com = fui.GObject.asCom;
	        GObject[] objects = com.GetChildren();
	        for (int i = 0; i < objects.Length; i++)
	        {
		        GObject obj = objects[i];
		        if(!obj.relations.CheckDefaultRelationIsHasWWHH())
					obj.SetScale(scaleFactor, scaleFactor);
	        }
        }
	}
}