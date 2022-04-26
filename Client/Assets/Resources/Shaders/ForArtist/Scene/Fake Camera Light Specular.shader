// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Artist/Scene/Fake Camera Light Specular" {
	Properties {
		_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
		_SpecOffset ("Specular Offset from Camera", Vector) = (1, 10, 2, 0)
		_SpecColor ("Specular Color", Color) = (1, 1, 1, 1)
		_Shininess ("Shininess", Range (1, 128)) = 9
		_SHLightingScale("Ambient Lighting Scale",float) = 1
	}

	SubShader {
		Tags { "RenderType"="Opaque" "LightMode"="ForwardBase"}
		LOD 100
	
		CGINCLUDE
		#pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
		#include "UnityCG.cginc"

		sampler2D _MainTex;
		float4 _MainTex_ST;
		float3 _SpecOffset;
		float3 _SpecColor;
		float _Shininess;
		float _SHLightingScale;
	
		struct v2f {
			float4 pos : SV_POSITION;
			float2 uv : TEXCOORD0;
			float3 refl : TEXCOORD1;
			fixed3 spec : TEXCOORD3;
			fixed3 SHLighting: TEXCOORD4;
		};
	
		v2f vert (appdata_full v)
		{
			v2f o;
			UNITY_INITIALIZE_OUTPUT(v2f, o);

			o.pos = UnityObjectToClipPos(v.vertex);
			o.uv = v.texcoord;
		
			float3 worldNormal = mul((float3x3)unity_ObjectToWorld, v.normal);		
			float3 viewNormal = mul((float3x3)UNITY_MATRIX_MV, v.normal);
			float4 viewPos = mul(UNITY_MATRIX_MV, v.vertex);
			float3 viewDir = float3(0, 0, 1);
			float3 viewLightPos = _SpecOffset;
			viewLightPos.z = -viewLightPos.z;
			float3 dirToLight = viewPos.xyz - viewLightPos;
			float3 h = (viewDir + normalize(-dirToLight)) * 0.5;

			o.spec = _SpecColor * pow(saturate(dot(viewNormal, normalize(h))), _Shininess) * 2;
			o.SHLighting	= ShadeSH9(float4(worldNormal, 1)) * _SHLightingScale;
			return o;
		}
		ENDCG

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest		
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 c	= tex2D (_MainTex, i.uv);
				c.rgb *= i.SHLighting;
				c.rgb += i.spec.rgb * c.a;
				return c;
			}
			ENDCG 
		}	
	}
}
