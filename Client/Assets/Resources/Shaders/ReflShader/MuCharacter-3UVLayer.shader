// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/MuCharacter-3UVLayer" {
	Properties {
		_MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {} 
		_Color ("Main Color", Color) = (1,1,1,1)
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" { TexGen CubeReflect }
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)

		_SpecSpeedU0("Rotate Angle Speed", Float) = 100
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

			float _SpecSpeedU0;
			fixed4 _Color;
			fixed4 _ReflectColor;
			sampler2D _MainTex;
			samplerCUBE _Cube;

			VS_Output vert(VS_Input v)
			{
				VS_Output o;
				o.position = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				
				half3 normalW = normalize( mul((float3x3)unity_ObjectToWorld, v.normal) );
				half3 viewDirW = _WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v.vertex).xyz;
				half3 reflectDirW = viewDirW - 2 * normalW * dot(normalW, viewDirW);

				half cosAngle = cos(_Time.x * _SpecSpeedU0);
				half sinAngle = sin(_Time.x * _SpecSpeedU0);
				half3x3 rotateMat = {cosAngle, 0, sinAngle,
								  0, 1, 0,
								  -sinAngle, 0, cosAngle};
			   
			    o.viewRelfW = mul(rotateMat, reflectDirW).xyz;
				return o;
			}

			half4 frag(VS_Output i) : COLOR
			{
				half3 reflColor = texCUBE(_Cube, i.viewRelfW).rgb * _ReflectColor.rgb;
				half4 baseColor = tex2D(_MainTex, i.uv) * _Color;
				//return half4(lerp(baseColor.rgb, reflColor, _ReflectColor.a), baseColor.a);
				return half4(baseColor.rgb + reflColor, baseColor.a);
			}

			ENDCG
		}
	}
	
	FallBack "Diffuse"
}
