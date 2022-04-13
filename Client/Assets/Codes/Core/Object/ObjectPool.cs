using System;
using System.Collections.Generic;
#if !NOT_UNITY
using UnityEngine;
#endif
namespace ET
{
    
    public class ComponentQueue: IDisposable
    {
        public long Id;
        
#if !NOT_UNITY
        public static GameObject Game { get; } = GameObject.Find("Global");
		
        public GameObject ViewGO { get; set; }
#endif
		
        public string TypeName { get; }
		
        private readonly Queue<Entity> queue = new Queue<Entity>();

        public ComponentQueue(string typeName)
        {
            Id = IdGenerater.Instance.GenerateId();
            TypeName = typeName;
#if !NOT_UNITY
            ViewGO = new GameObject();
            ViewGO.name = GetType().Name;
            ViewGO.layer = LayerNames.GetLayerInt(LayerNames.HIDDEN);
            ViewGO.transform.SetParent(Game.transform, false);
            var componentView = ViewGO.AddComponent(typeof(ComponentView)) as ComponentView;

            if (componentView)
            {
                componentView.Component = this;
            }
#endif
        }

        public void Enqueue(Entity entity)
        {
            queue.Enqueue(entity);
        }

        public Entity Dequeue()
        {
            return queue.Dequeue();
        }

        public Entity Peek()
        {
            return queue.Peek();
        }

        public Queue<Entity> Queue
        {
            get
            {
                return queue;
            }
        }

        public int Count
        {
            get
            {
                return queue.Count;
            }
        }

        public void Dispose()
        {
            while (queue.Count > 0)
            {
                Entity component = queue.Dequeue();
                component.Dispose();
            }
        }
    }
    
    public class ObjectPool: IDisposable
    {
        
#if !NOT_UNITY
        public static GameObject Game { get; } = GameObject.Find("Global");
		
        public GameObject ViewGO { get; set; }
#endif
        
        private readonly Dictionary<Type, ComponentQueue> pool = new Dictionary<Type, ComponentQueue>();
        
        public static ObjectPool Instance = new ObjectPool();
        
        private ObjectPool()
        {
#if !NOT_UNITY
            ViewGO = new GameObject();
            ViewGO.name = GetType().Name;
            ViewGO.layer = LayerNames.GetLayerInt(LayerNames.HIDDEN);
            ViewGO.transform.SetParent(Game.transform, false);
            var componentView = ViewGO.AddComponent(typeof(ComponentView)) as ComponentView;

            if (componentView)
            {
                componentView.Component = this;
            }
#endif
        }

        public Entity Fetch(Type type)
        {
            Entity obj;
            if (!pool.TryGetValue(type, out ComponentQueue queue))
            {
                obj = (Entity)Activator.CreateInstance(type);
            }
            else if (queue.Count == 0)
            {
                obj = (Entity)Activator.CreateInstance(type);
            }
            else
            {
                obj = queue.Dequeue();
            }
	        
            obj.IsFromPool = true;
            return obj;
        }

        public void Recycle(Entity obj)
        {
            Type type = obj.GetType();
            ComponentQueue queue;
            if (!pool.TryGetValue(type, out queue))
            {
                queue = new ComponentQueue(type.Name);
	            
#if !NOT_UNITY
                if (queue.ViewGO != null)
                {
                    queue.ViewGO.transform.SetParent(ViewGO.transform);
                    queue.ViewGO.name = $"{type.Name}s";
                }
#endif
                pool.Add(type, queue);
            }
            
#if !NOT_UNITY
            if (obj.ViewGO != null)
            {
                obj.ViewGO.transform.SetParent(queue.ViewGO.transform);
            }
#endif
            obj.Id = 0;
            
            queue.Enqueue(obj);
        }

        public void Dispose()
        {
            foreach (var kv in pool)
            {
                kv.Value.Dispose();
            }
            pool.Clear();
            
#if !NOT_UNITY
            if (ViewGO != null)
            {
                UnityEngine.Object.Destroy(ViewGO);
            }
#endif
        }
    }
}