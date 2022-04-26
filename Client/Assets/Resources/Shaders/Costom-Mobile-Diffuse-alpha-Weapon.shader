// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Simplified Diffuse shader. Differences from regular Diffuse one:
// - no Main Color
// - fully supports only 1 directional light. Other lights can affect it, but it will be per-vertex/SH.

Shader "Custom/Mobile/Diffuse-alpha-Weapon" {
	Properties
	{
		_MainTex ("Particle Texture", 2D) = "white" {}
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha One
		AlphaTest Greater .01
		ColorMask RGB
		Cull off Lighting Off ZWrite Off Fog { Mode Off }

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
			float4 _TintColor;
			
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
				fixed4 color = _TintColor * i.color;

				fixed4 texColor = tex2D(_MainTex, i.uv);
				color *= texColor * 1.5;
		
				return color;
			}
			ENDCG
		}
	}

	Fallback "Mobile/VertexLit"
}
