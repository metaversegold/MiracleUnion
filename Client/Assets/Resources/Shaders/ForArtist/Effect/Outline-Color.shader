// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/RimSilhouette" 
{
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
	}

	SubShader {
		ZTest Always
		ZWrite Off
		Lighting Off
		Blend SrcAlpha One

		Pass
		{
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct vertex_data
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				fixed rim : TEXCOORD0;
			};

			v2f vert(vertex_data v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				/*
				float4 posW = mul(_Object2World, v.vertex);
				float3 toEyeW = normalize(_WorldSpaceCameraPos - posW.xyz);
				float3 normalW = mul((float3x3)_Object2World, v.normal);
				o.rim = 1 - dot(toEyeW, normalW);
				o.rim *= o.rim;*/
				return o;
			}

			fixed4 _Color;

			fixed4 frag(v2f i) : COLOR
			{
				return fixed4(_Color.rgb, _Color.a);
			}
			ENDCG
		}
	}
}
