Shader "Custom/Reflective/DiffuseAlpha" 
{
	Properties {
		_MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {} 
		_Color ("Main Color", Color) = (1,1,1,1)
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" { TexGen CubeReflect }
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
		//_SpecPow("SpecularPower", Range(2, 100)) = 40

		//_MySpecColor("Spec Light Color", Color) = (0,0,0,1)
		_SpecSpeedU0("Rotate Angle Speed", Float) = 100
	}

	SubShader {

		LOD 200
		Tags 
		{
		 	"Queue"="Transparent"
			"IgnoreProjector"="True"
			"RenderType"="Transparent" 
		}

		Cull Off
		//ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		//ZTest LEqual

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		//sampler2D _CombineTex;
		samplerCUBE _Cube;

		fixed4 _Color;
		fixed4 _ReflectColor;
		//float _SpecPow;

		//float4 _MySpecColor;
		float _SpecSpeedU0;

		struct Input {
			float2 uv_MainTex;
			//float2 uv_CombineTex;
			float3 worldRefl;
			float3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o) {

			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);

			float cosAngle = cos(_Time.x * _SpecSpeedU0);
			float sinAngle = sin(_Time.x * _SpecSpeedU0);
			float4x4 rotateMat = {cosAngle, 0, sinAngle, 0,
								  0, 1, 0, 0,
								  -sinAngle, 0, cosAngle, 0,
								  0, 0, 0, 1};
								  			
			IN.worldRefl = mul(rotateMat, float4(IN.worldRefl, 1)).xyz;
			fixed4 reflcol = texCUBE (_Cube, IN.worldRefl);

			//IN.viewDir = mul(rotateMat, float4(IN.viewDir, 1)).xyz;
			//float reflection = max( 0, dot(normalize(IN.viewDir), normalize(o.Normal)) );
			//float specPow = pow(reflection, _SpecPow);
			//float4 layerColor0 = _MySpecColor * specPow;

			o.Albedo = (tex * _Color).rgb;
			o.Emission = reflcol.rgb * _ReflectColor.rgb;// + layerColor0;//addColor;
			o.Alpha = tex.a;//reflcol.a * _ReflectColor.a;
		}
		ENDCG
	}
	
	FallBack "Reflective/VertexLit"
} 
