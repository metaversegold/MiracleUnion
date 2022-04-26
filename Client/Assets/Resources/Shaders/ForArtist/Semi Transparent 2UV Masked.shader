// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Artist/Semi Transparent 2UV Masked" {
	Properties {
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		_LightTex ("Additive (RGBA)", 2D) = "white" {}
		_MaskTex ("Mask (A)", 2D) = "white" {}
	}

	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha 
		Cull Off Lighting Off ZWrite Off

		Pass
		{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0

			struct vertex_data
			{
				float4 vertex : POSITION;
				float4 uv : TEXCOORD0;
				float4 uv2 : TEXCOORD1;
			};

			struct v2f
			{
				float4 pos : POSITION;
				half4 uv1 : TEXCOORD0;
				half4 uv2 : TEXCOORD1;
			};

			sampler2D _MainTex;
			sampler2D _MaskTex;
			sampler2D _LightTex;
			fixed4 _MainTex_ST;
			fixed4 _MaskTex_ST;
			fixed4 _LightTex_ST;

			v2f vert(vertex_data v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv1 = half4(TRANSFORM_TEX(v.uv, _MainTex), 0, 0);
				o.uv2 = half4(TRANSFORM_TEX(v.uv2, _MaskTex), TRANSFORM_TEX(v.uv2, _LightTex));
				return o;
			}

			half4 frag(v2f i) : COLOR
			{
				half4 col = tex2D(_MainTex, i.uv1.xy);
				half4 add = tex2D(_LightTex, i.uv2.zw);
				half opacity = tex2D(_MaskTex, i.uv2.xy).a;
				return half4(col.rgb + add.rgb * add.a * opacity, col.a);
			}
			ENDCG
		}
	}
}
