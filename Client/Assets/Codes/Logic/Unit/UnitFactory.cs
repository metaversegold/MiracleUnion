using Server.Data;
using UnityEngine;

namespace ET
{
    public static class UnitFactory
    {
	    public static Unit Create(Scene currentScene, RoleData unitInfo)
	    {
		    UnitComponent unitComponent = currentScene.GetComponent<UnitComponent>();
		    Unit unit = unitComponent.AddChildWithId<Unit, int>(unitInfo.RoleID, unitInfo.RoleID);
		    unitComponent.Add(unit);
	        
		    RaycastHit hit;
		    var pos = new Vector3(unitInfo.PosX/100f, 200, unitInfo.PosY/100f);
		    Physics.Raycast(pos, Vector3.down, out hit);
		    Log.Debug($"Create unit pos {pos}, RaycastHit {hit.point} ");
		    unit.Position = hit.point;
		    
		    unit.Forward = Vector3.zero;
	        
		    NumericComponent numericComponent = unit.AddComponent<NumericComponent>();
		    // for (int i = 0; i < unitInfo.Ks.Count; ++i)
		    // {
			   //  numericComponent.Set(unitInfo.Ks[i], unitInfo.Vs[i]);
		    // }
	        
		    unit.AddComponent<MoveComponent>();
		    // if (unitInfo.MoveInfo != null)
		    // {
			   //  if (unitInfo.MoveInfo.X.Count > 0)
			   //  {
				  //   using (ListComponent<Vector3> list = ListComponent<Vector3>.Create())
				  //   {
					 //    list.Add(unit.Position);
					 //    for (int i = 0; i < unitInfo.MoveInfo.X.Count; ++i)
					 //    {
						//     list.Add(new Vector3(unitInfo.MoveInfo.X[i], unitInfo.MoveInfo.Y[i], unitInfo.MoveInfo.Z[i]));
					 //    }
		    //
					 //    unit.MoveToAsync(list).Coroutine();
				  //   }
			   //  }
		    // }

		    unit.AddComponent<ObjectWait>();

		    unit.AddComponent<XunLuoPathComponent>();
	        
		    Game.EventSystem.Publish(new EventType.AfterUnitCreate() {Unit = unit});
		    return unit;
	    }

	    public static Unit Create(Scene currentScene, UnitInfo unitInfo)
        {
	        UnitComponent unitComponent = currentScene.GetComponent<UnitComponent>();
	        Unit unit = unitComponent.AddChildWithId<Unit, int>(unitInfo.UnitId, unitInfo.ConfigId);
	        unitComponent.Add(unit);
	        
	        unit.Position = new Vector3(unitInfo.X, unitInfo.Y, unitInfo.Z);
	        unit.Forward = new Vector3(unitInfo.ForwardX, unitInfo.ForwardY, unitInfo.ForwardZ);
	        
	        NumericComponent numericComponent = unit.AddComponent<NumericComponent>();
	        for (int i = 0; i < unitInfo.Ks.Count; ++i)
	        {
		        numericComponent.Set(unitInfo.Ks[i], unitInfo.Vs[i]);
	        }
	        
	        unit.AddComponent<MoveComponent>();
	        if (unitInfo.MoveInfo != null)
	        {
		        if (unitInfo.MoveInfo.X.Count > 0)
		        {
			        using (ListComponent<Vector3> list = ListComponent<Vector3>.Create())
			        {
				        list.Add(unit.Position);
				        for (int i = 0; i < unitInfo.MoveInfo.X.Count; ++i)
				        {
					        list.Add(new Vector3(unitInfo.MoveInfo.X[i], unitInfo.MoveInfo.Y[i], unitInfo.MoveInfo.Z[i]));
				        }

				        unit.MoveToAsync(list).Coroutine();
			        }
		        }
	        }

	        unit.AddComponent<ObjectWait>();

	        unit.AddComponent<XunLuoPathComponent>();
	        
	        Game.EventSystem.Publish(new EventType.AfterUnitCreate() {Unit = unit});
            return unit;
        }
    }
}
