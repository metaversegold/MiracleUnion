// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "FXMaker/Mask Alpha Blended Tint"
{
	Properties
	{
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_Mask ("Mask", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
// 		AlphaTest Greater .01
// 		ColorMask RGB
		Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				half2 uv : TEXCOORD0;
				fixed4 color : COLOR;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				half4 uv : TEXCOORD0;
				fixed4 color : TEXCOORD1;
			};

			half4 _MainTex_ST;
			half4 _Mask_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = half4(TRANSFORM_TEX(v.uv, _MainTex), TRANSFORM_TEX(v.uv, _Mask));
				o.color = v.color;
				return o;
			}

			sampler2D _MainTex;
			sampler2D _Mask;
			fixed4 _TintColor;
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 color = _TintColor * i.color;

				fixed4 maskColor = tex2D(_Mask, i.uv.zw);
				color = maskColor * color;

				fixed4 mainColor = tex2D(_MainTex, i.uv.xy);
				color = mainColor * color * 2;
		
				return color;
			}
			ENDCG
		}
	}
}
