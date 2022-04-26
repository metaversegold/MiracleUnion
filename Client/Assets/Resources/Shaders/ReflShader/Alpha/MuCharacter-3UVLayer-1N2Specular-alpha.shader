// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/MuCharacter-3UVLaye-1N2Specularr-Alpha" {
	Properties {
		_MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {} 
		_Color ("Main Color", Color) = (1,1,1,1)
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" { TexGen CubeReflect }
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
		_SpecSpeedU0("Rotate Angle Speed", Float) = 100

		_SpecPow("SpecularPower", Range(2, 100)) = 40
	   //_ViewDir ("View Direction", Vector) = (0, 0, 1, 0) // for test
		_SpecColor1("Spec Light Color 1", Color) = (1, 1, 1, 1)
		_TimeScale1 ("Time Scale for Animation 1", Float) = 8
		_ViewDirTex1 ("View Direction Animation 1", 2D) = "white" {}
		
		_LightScale("Light Scale", Float) = 8
		_SpecColor2("Spec Light Color 2", Color) = (1, 1, 1, 1)
		_TimeScale2 ("Time Scale for Animation 2", Float) = 8
		_ViewDirTex2 ("View Direction Animation 2", 2D) = "white" {}
	}
	
	SubShader 
	{
		Tags 
		{
		 	"Queue"="Transparent"
			"RenderType"="Transparent" 
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha 
			Cull off

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
				half3 normalW : TEXCOORD2;
			};

			float _SpecSpeedU0;
			fixed4 _Color;
			fixed4 _ReflectColor;
			sampler2D _MainTex;
			samplerCUBE _Cube;

			half _SpecPow;
			fixed4 _SpecColor1;
			half _TimeScale1;
			sampler2D _ViewDirTex1;
			
			half _LightScale;
			fixed4 _SpecColor2;
			half _TimeScale2;
			sampler2D _ViewDirTex2;

			VS_Output vert(VS_Input v)
			{
				VS_Output o;
				o.position = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;				
				o.normalW = normalize( mul((float3x3)unity_ObjectToWorld, v.normal) );

				half3 viewDirW = _WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v.vertex).xyz;
				half3 reflectDirW = viewDirW - 2 * o.normalW * dot(o.normalW, viewDirW);

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
				//baseColor = half4(lerp(baseColor.rgb, reflColor, _ReflectColor.a), baseColor.a);
				baseColor = half4(baseColor.rgb + reflColor, baseColor.a);

				float4x4 view_mat_t = transpose(UNITY_MATRIX_V);
				half3 rightView = view_mat_t[0].xyz;
				half3 upView = half3(0, 1, 0);
				half3 forwardView = cross(upView, rightView);
				half3x3 matView2World = half3x3(rightView,
														upView,
														forwardView);
				half3 normalW = normalize(i.normalW);

				half3 viewDirInViewSpace = tex2D(_ViewDirTex1, float2(_Time.x * _TimeScale1, 0)).xyz * 2 - 1;
				half3 viewDirW = mul(matView2World, viewDirInViewSpace);
				half reflection = max( 0, dot(normalize(viewDirW), normalW) );
				half specPow = pow(reflection, _SpecPow);		
				half4 layerColor1 = _SpecColor1 * specPow;

				viewDirInViewSpace = tex2D(_ViewDirTex2, float2(_Time.x * _TimeScale2, 0)).xyz * 2 - 1;
				viewDirW = mul(matView2World, viewDirInViewSpace);
				reflection = max( 0, dot(normalize(viewDirW), normalW) );
				specPow = saturate(reflection * _LightScale - _LightScale + 1);
				half4 layerColor2 =  _SpecColor2 * specPow;

				return baseColor + baseColor.a*layerColor1 + baseColor.a*layerColor2;
				//return baseColor + layerColor1 + layerColor2;
			}

			ENDCG
		}
	}
	
	FallBack "Diffuse"
}
