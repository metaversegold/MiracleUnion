using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using UnityEngine;
using System.Linq;

namespace ET
{
	public class CodeLoader: IDisposable
	{
		public static CodeLoader Instance = new CodeLoader();

		public Action Update;
		public Action LateUpdate;
		public Action OnApplicationQuit;

		private Assembly assembly;

		private ILRuntime.Runtime.Enviorment.AppDomain appDomain;
		
		private Type[] allTypes;
		
		public CodeMode CodeMode { get; set; }

		private CodeLoader()
		{
		}

		public void Dispose()
		{
			this.appDomain?.Dispose();
		}
		
		public void Start()
		{
			switch (this.CodeMode)
			{
				case CodeMode.Mono:
				{
					Dictionary<string, UnityEngine.Object> dictionary = AssetsBundleHelper.LoadBundle("code.unity3d");
					byte[] assBytes = ((TextAsset)dictionary["Code.dll"]).bytes;
					byte[] pdbBytes = ((TextAsset)dictionary["Code.pdb"]).bytes;
					
					assembly = Assembly.Load(assBytes, pdbBytes);
					this.allTypes = assembly.GetTypes();
					IStaticMethod start = new MonoStaticMethod(assembly, "ET.Entry", "Start");
					start.Run();
					break;
				}
				case CodeMode.ILRuntime:
				{
					Dictionary<string, UnityEngine.Object> dictionary = AssetsBundleHelper.LoadBundle("code.unity3d");
					byte[] assBytes = ((TextAsset)dictionary["Code.dll"]).bytes;
					byte[] pdbBytes = ((TextAsset)dictionary["Code.pdb"]).bytes;
					
					//byte[] assBytes = File.ReadAllBytes(Path.Combine("../Unity/", Define.BuildOutputDir, "Code.dll"));
					//byte[] pdbBytes = File.ReadAllBytes(Path.Combine("../Unity/", Define.BuildOutputDir, "Code.pdb"));
				
					appDomain = new ILRuntime.Runtime.Enviorment.AppDomain();
#if DEBUG && (UNITY_EDITOR || UNITY_ANDROID || UNITY_IPHONE)
					this.appDomain.UnityMainThreadID = System.Threading.Thread.CurrentThread.ManagedThreadId;
#endif
					MemoryStream assStream = new MemoryStream(assBytes);
					MemoryStream pdbStream = new MemoryStream(pdbBytes);
					appDomain.LoadAssembly(assStream, pdbStream, new ILRuntime.Mono.Cecil.Pdb.PdbReaderProvider());

					ILHelper.InitILRuntime(appDomain);

					this.allTypes = appDomain.LoadedTypes.Values.Select(x => x.ReflectionType).ToArray();
					IStaticMethod start = new ILStaticMethod(appDomain, "ET.Entry", "Start", 0);
					start.Run();
					break;
				}
			}
		}

		public Type[] GetTypes()
		{
			return this.allTypes;
		}
	}
}