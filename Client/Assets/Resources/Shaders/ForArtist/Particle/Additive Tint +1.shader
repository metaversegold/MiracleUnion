// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Artist/Particle/Additive Tint +1" {
	Properties {
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Main Texture", 2D) = "white" {}
	}

	SubShader {
		Tags { "Queue"="Transparent+1" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha One
		Cull Off Lighting Off ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#include "UnityCG.cginc"

			struct vertex
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 color : COLOR;
			};

			struct v2f
			{
				float4 pos : POSITION;
				half2 uv : TEXCOORD0;
				fixed4 color : TEXCOORD1;
			};

			fixed4 _TintColor;
			fixed4 _MainTex_ST;

			v2f vert(vertex v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color * _TintColor;
				return o;
			}

			sampler2D _MainTex;

			fixed4 frag(v2f i) : COLOR
			{
				return tex2D(_MainTex, i.uv) * i.color * 2;
			}
			ENDCG
		}
	}
}
