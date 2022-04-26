﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Artist/Dissolve/Mask Alpha Blended Tint" {
	Properties {
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Main Texture", 2D) = "white" {}
		_Mask ("Mask Texture", 2D) = "white" {}
		_DissolveTex ("Dissolve Tex (A)", 2D) = "white" {}
		_Dissolve ("Dissolve Strength", Range(0, 1)) = 0.0
	}

	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off Lighting Off ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#include "UnityCG.cginc"
			#include "Dissolve.cginc"

			struct vertex
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 color : COLOR;
			};

			struct v2f
			{
				float4 pos : POSITION;
				half4 uv : TEXCOORD0;
				fixed4 color : TEXCOORD1;
			};

			fixed4 _TintColor;
			fixed4 _MainTex_ST;
			fixed4 _Mask_ST;

			v2f vert(vertex v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = half4(TRANSFORM_TEX(v.uv, _MainTex), TRANSFORM_TEX(v.uv, _Mask));
				o.color = v.color * _TintColor;
				return o;
			}

			sampler2D _MainTex;
			sampler2D _Mask;

			fixed4 frag(v2f i) : COLOR
			{
				fixed4 mask = tex2D(_Mask, i.uv.zw);
				fixed4 c = tex2D(_MainTex, i.uv.xy) * mask * i.color * 2;
				return calcDissolve(c, i.uv.xy);
			}
			ENDCG
		}
	}
}
