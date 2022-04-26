// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ZombieStyle/CameraShake" {
	Properties {
		_MainTex ("Screen", 2D) = "" {}
		_UVDisplacement ("Displacement (UVxx)", Vector) = (0, 0, 0, 0)
	}

	CGINCLUDE

	#include "UnityCG.cginc"

	struct v2f {
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	};

	sampler2D _MainTex;
	half4 _MainTex_TexelSize;
	half4 _UVDisplacement;

	v2f vert (appdata_img v)
	{
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);
		o.uv.xy = v.texcoord.xy + _UVDisplacement.xy;

		//#if UNITY_UV_STARTS_AT_TOP
		//if(_MainTex_TexelSize.y < 0.0)
			//o.uv.y = 1 - o.uv.y;
		//#endif

		return o;
	}

	half4 frag (v2f i) : Color
	{
		return tex2D(_MainTex, i.uv);
	}
	ENDCG

	SubShader {
		ZTest Always Cull Off Zwrite Off
		Fog { Mode off }
		ColorMask RGB

		Pass
		{
			CGPROGRAM
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment frag
			ENDCG
		}
	}

	Fallback off
}
