Shader "MuCharacter/Base" {
	Properties {
		_MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {} 
		_Color ("Main Color", Color) = (1,1,1,1)
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" { TexGen CubeReflect }
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
	}

	SubShader 
	{
		Tags {"Queue"="Geometry" "RenderType"="Opaque"}
		Cull Off
		LOD 200

		Pass
		{
			CGPROGRAM
			#include "MuCharacter.cginc"
			#pragma vertex vs_main
			#pragma fragment ps_BaseColor
			#pragma target 2.0
			ENDCG
		}
	}

	FallBack "Mobile/Diffuse"
}
