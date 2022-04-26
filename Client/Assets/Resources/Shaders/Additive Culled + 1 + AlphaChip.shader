// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Mobile/Particles/Additive Culled + 1 (AlphaClip)" {
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_Panel ("Panel", Vector) = (0,0,1,1)
	}

	SubShader
	{
		LOD 200

		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}

		Pass
		{
			Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
			Blend SrcAlpha One
			AlphaTest Greater .01
			ColorMask RGB
			Cull off Lighting Off ZWrite Off Fog { Mode Off }
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _TintColor;
			float4 _Panel;

			struct appdata_t
			{
				float4 vertex : POSITION;
				half4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : POSITION;
				half4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				float2 worldPos : TEXCOORD1;
			};

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.worldPos = o.vertex;//TRANSFORM_TEX(v.vertex.xy, _MainTex);
				return o;
			}

			fixed4 frag (v2f IN) : COLOR
			{
				// Sample the texture
				fixed4 col = _TintColor * IN.color;
				fixed4 c = col * tex2D(_MainTex, IN.texcoord) * 2;

				float4 factor = (_Panel * 2) - float4(1,1,1,1);


				if((IN.worldPos.x < factor.x) || (IN.worldPos.y < factor.y))
				{
					c.a = 0.0;
				}
				if((IN.worldPos.x > factor.z) || (IN.worldPos.y > factor.w))
				{
					c.a = 0.0;
				}
				//float val = 1.0 - max(factor.x, factor.y);
				//
				//// Option 1: 'if' statement
				//if (val < 0.0)
				//{
				//	col.a = 0.0;
				//}

				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
