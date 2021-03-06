// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Mobile/Particles/MUTransparentAlphaBlend_Alpha"
{
	Properties
	{
		_MainColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
	}
	SubShader
	{
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 100

		Cull Off
		ZWrite On
		ZTest LEqual 
		Blend SrcAlpha OneMinusSrcAlpha 

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				fixed4 color : COLOR;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				fixed4 color : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _MainColor;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 color = _MainColor * i.color;

				fixed4 texColor = tex2D(_MainTex, i.uv);
				color *= texColor;
		
				return color;
			}
			ENDCG
		}
	}
}
