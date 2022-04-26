Shader "MuCharacter/Specular1-Alpha" {
	Properties {
		_MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {} 
		_Color ("Main Color", Color) = (1,1,1,1)
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" { TexGen CubeReflect }
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)

		_SpecPow("SpecularPower", Range(2, 100)) = 40
	   //_ViewDir ("View Direction", Vector) = (0, 0, 1, 0) // for test
		_SpecColor1("Spec Light Color 1", Color) = (1, 1, 1, 1)
		_TimeScale1 ("Time Scale for Animation 1", Float) = 8
		_ViewDirTex1 ("View Direction Animation 1", 2D) = "white" {}
	}

	SubShader 
	{
		Tags {"Queue"="Transparent" "RenderType"="Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off
		LOD 2000

		Pass
		{
			CGPROGRAM
			#include "../MuCharacter.cginc"
			#pragma vertex vs_main_normal
			#pragma fragment ps_SpecColor1
			#pragma target 2.0
			ENDCG
		}
	}

	FallBack "MuCharacter/Base-Alpha"
}
