using System;

namespace ET
{
	public static class EntityFactory
	{
		public static Entity CreateWithParent(Type type, Entity parent, bool fromPool = true)
		{
			Entity component = Entity.CreateWithParent(parent, type, fromPool);
			component.Id = IdGenerater.Instance.GenerateId();
			
			Game.EventSystem.Awake(component);
			return component;
		}

		public static T CreateWithParent<T>(Entity parent, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithParent(parent, type, fromPool);
			component.Id = IdGenerater.Instance.GenerateId();
			
			Game.EventSystem.Awake(component);
			return component;
		}

		public static T CreateWithParent<T, A>(Entity parent, A a, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithParent(parent, type, fromPool);
			component.Id = IdGenerater.Instance.GenerateId();
			
			Game.EventSystem.Awake(component, a);
			return component;
		}

		public static T CreateWithParent<T, A, B>(Entity parent, A a, B b, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithParent(parent, type, fromPool);
			component.Id = IdGenerater.Instance.GenerateId();
			
			Game.EventSystem.Awake(component, a, b);
			return component;
		}

		public static T CreateWithParent<T, A, B, C>(Entity parent, A a, B b, C c, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithParent(parent, type, fromPool);
			component.Id = IdGenerater.Instance.GenerateId();
			
			Game.EventSystem.Awake(component, a, b, c);
			return component;
		}

        public static T CreateWithParent<T, A, B, C, D>(Entity parent, A a, B b, C c, D d, bool fromPool = true) where T : Entity
        {
            Type type = typeof(T);
			
            T component = (T)Entity.CreateWithParent(parent, type, fromPool);
            component.Id = IdGenerater.Instance.GenerateId();
            
            Game.EventSystem.Awake(component, a, b, c, d);
            return component;
        }
        
        
        public static Entity Create(Entity domain, Type type, bool fromPool = true)
        {
	        Entity component = Entity.CreateWithDomain(domain, type, fromPool);
	        component.Id = IdGenerater.Instance.GenerateId();
	        
	        Game.EventSystem.Awake(component);
	        return component;
        }


        public static T Create<T>(Entity domain, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithDomain(domain, type, fromPool);
			component.Id = IdGenerater.Instance.GenerateId();
			
			Game.EventSystem.Awake(component);
			return component;
		}

		public static T Create<T, A>(Entity domain, A a, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithDomain(domain, type, fromPool);
			component.Id = IdGenerater.Instance.GenerateId();
			
			Game.EventSystem.Awake(component, a);
			return component;
		}

		public static T Create<T, A, B>(Entity domain, A a, B b, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithDomain(domain, type, fromPool);
			component.Id = IdGenerater.Instance.GenerateId();

			Game.EventSystem.Awake(component, a, b);
			return component;
		}

		public static T Create<T, A, B, C>(Entity domain, A a, B b, C c, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithDomain(domain, type, fromPool);
			component.Id = IdGenerater.Instance.GenerateId();

			Game.EventSystem.Awake(component, a, b, c);
			return component;
		}

		public static T CreateWithId<T>(Entity domain, long id, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithDomain(domain, type, fromPool);
			component.Id = id;
			
			Game.EventSystem.Awake(component);
			return component;
		}

		public static T CreateWithId<T, A>(Entity domain, long id, A a, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithDomain(domain, type, fromPool);
			component.Id = id;
			
			Game.EventSystem.Awake(component, a);
			return component;
		}

		public static T CreateWithId<T, A, B>(Entity domain, long id, A a, B b, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithDomain(domain, type, fromPool);
			component.Id = id;

			Game.EventSystem.Awake(component, a, b);
			return component;
		}

		public static T CreateWithId<T, A, B, C>(Entity domain, long id, A a, B b, C c, bool fromPool = true) where T : Entity
		{
			Type type = typeof (T);
			
			T component = (T)Entity.CreateWithDomain(domain, type, fromPool);
			component.Id = id;

			Game.EventSystem.Awake(component, a, b, c);
			return component;
		}

	}
}
