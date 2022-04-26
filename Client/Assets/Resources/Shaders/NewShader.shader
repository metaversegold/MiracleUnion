// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/nolight" {
	Properties 
	{
		_Diffuse("_Diffuse", 2D) = "black" {}
		_EMission("_EMission", 2D) = "black" {}
	}

	SubShader 
	{
		Tags 
		{
		 	"Queue"="Geometry"
			"RenderType"="Opaque" 
		}

		Pass
		{
			Cull off

			Name "CharacterBase"
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0

			#include "UnityCG.cginc"
			
			struct VS_Input {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 uv : TEXCOORD0;
			};

			struct VS_Output {
			    float4 position : SV_POSITION;
				half2 uv : TEXCOORD0;
				half3 viewRelfW : TEXCOORD1;
			};

			sampler2D _Diffuse;
			sampler2D _EMission;
			
			float _interval;
			float _remainder;

			VS_Output vert(VS_Input v)
			{
				VS_Output o;
				o.position = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			half4 frag(VS_Output i) : COLOR
			{
				half3 reflColor = tex2D(_EMission, i.uv).rgb;
				half4 baseColor = tex2D(_Diffuse, i.uv);
				
				
				//return half4(lerp(baseColor.rgb, reflColor, _ReflectColor.a), baseColor.a);
				return half4(baseColor.rgb + reflColor, baseColor.a);
			}

			ENDCG
		}
	}
	
	FallBack "Diffuse"
}
