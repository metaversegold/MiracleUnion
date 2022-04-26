Shader "MuCharacter/Specular1N2" {
	Properties {
		_MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {} 
		_Color ("Main Color", Color) = (1,1,1,1)
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" { TexGen CubeReflect }
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
		
		_SpecPow("SpecularPower", Range(2, 100)) = 40
		_SpecColor1("Spec Light Color 1", Color) = (1, 1, 1, 1)
		_TimeScale1 ("Time Scale for Animation 1", Float) = 8
		_ViewDirTex1 ("View Direction Animation 1", 2D) = "white" {}
		
		_LightScale("Light Scale", Float) = 8
		_SpecColor2("Spec Light Color 2", Color) = (1, 1, 1, 1)
		_TimeScale2 ("Time Scale for Animation 2", Float) = 8
		_ViewDirTex2 ("View Direction Animation 2", 2D) = "white" {}
	}

	SubShader 
	{
		Tags {"Queue"="Geometry" "RenderType"="Opaque"}
		Cull Off
		LOD 2000

		Pass
		{
			CGPROGRAM
			#include "MuCharacter.cginc"
			#pragma vertex vs_main_normal
			#pragma fragment ps_SpecColor1N2
			#pragma target 2.0
			ENDCG
		}
	}

	FallBack "MuCharacter/Base"
}
