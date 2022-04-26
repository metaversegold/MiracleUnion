Shader "Artist/Semi Transparent Texture" {
	Properties {
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
	}

	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha 
		Cull Off Lighting Off ZWrite Off

		Pass
		{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma target 2.0

			sampler2D _MainTex;

			fixed4 frag(v2f_img i) : COLOR
			{
				return tex2D(_MainTex, i.uv);
			}
			ENDCG
		}
	}
}
