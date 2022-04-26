Shader "Custom/4Layer_uv2_alpha"
{
	Properties 
	{
		_MainTex("Base (RGB) Gloss (A)", 2D) = "white" {}
		_SpecPow("SpecularPower", Range(2, 100)) = 40
		
		_LayerColor0("Layer1 Color", Color) = (0.9104478,0,0,1)
		_SpeedU0("Speed in U Direction", Float) = 1
		_SpeedV0("Speed in V Direction", Float) = -1
		_LayerTex0("Main Spec Layer", 2D) = "white" {}
		
		_LayerColor1("Layer2 Color", Color) = (0,0.1188812,1,1)
		_SpeedU1("Speed in U Direction", Float) = 1
		_SpeedV1("Speed in V Direction", Float) = -1
		_LayerTex1("Rim Layer", 2D) = "white" {}
		_RimPow("_RimPow", Range(0.5, 5) ) = 0.5
		
		_LayerColor2("Layer3 Color", Color) = (1,1,1,1)
		_SpeedU2("Speed in U Direction", Float) = 1
		_SpeedV2("Speed in V Direction", Float) = -1
		_LayerTex2("Layer 3", 2D) = "black" {}
		
		_LayerColor3("Layer4 Color", Color) = (1,1,1,1)
		_SpeedU3("Speed in U Direction", Float) = 1
		_SpeedV3("Speed in V Direction", Float) = -1
		_LayerTex3("Layer 4", 2D) = "black" {}
	}
	
	SubShader 
	{
		Tags {	"IgnoreProjector"="True" }
		Cull Back
		ZWrite On
		ZTest LEqual
		ColorMask RGBA

		CGPROGRAM
		#pragma surface surf CustomBlinnPhong
		//#pragma target 2.0

		sampler2D _MainTex;
		float _SpecPow;
		float _RimPow;
		
		sampler2D _LayerTex0;
		float4 _LayerColor0;
		float _SpeedU0;
		float _SpeedV0;
		
		sampler2D _LayerTex1;
		float4 _LayerColor1;
		float _SpeedU1;
		float _SpeedV1;
		
		sampler2D _LayerTex2;
		float4 _LayerColor2;
		float _SpeedU2;
		float _SpeedV2;
		
		sampler2D _LayerTex3;
		float4 _LayerColor3;
		float _SpeedU3;
		float _SpeedV3;
		
		struct Input 
		{
			float2 uv_MainTex;
			float3 viewDir;
			float2 uv2_LayerTex0;
			float2 uv2_LayerTex1;
			float2 uv2_LayerTex2;
			float2 uv2_LayerTex3;
		};

		inline half4 LightingCustomBlinnPhong (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half3 h = normalize (lightDir + viewDir);

          	half diff = max (0, dot (s.Normal, lightDir));

          	float nh = max (0, dot (s.Normal, h));
          	
          	float spec = pow (nh, _SpecPow);

          	half4 c;
          	c.rgb = (s.Albedo * _LightColor0.rgb * diff) * (atten * 2);
          	c.a = s.Alpha;
          	return c;
		}
		
		void surf (Input IN, inout SurfaceOutput o) {			
			float4 mainTexColor=tex2D(_MainTex,IN.uv_MainTex);
			
			float reflection = max( 0, dot(normalize(IN.viewDir), normalize(o.Normal)) );
			float edge = 1 - reflection;
			float specPow = pow(reflection, _SpecPow);
			float rimPow = pow(edge, _RimPow);
			
			float layer0_offset_u = (_SinTime + 1) * _SpeedU0;
			float layer0_offset_v = _CosTime * _SpeedV0;
			float2 layer0uv = float2(IN.uv2_LayerTex0.x + layer0_offset_u, IN.uv2_LayerTex0.y + layer0_offset_v);
			float4 layerColor0 = tex2D(_LayerTex0, layer0uv) * _LayerColor0 * specPow;
			
			
			float layer1_offset_u =_SinTime * _SpeedU1;
			float layer1_offset_v = _CosTime * _SpeedV1;
			float2 layer1uv = float2(IN.uv2_LayerTex1.x + layer1_offset_u, IN.uv2_LayerTex1.y + layer1_offset_v);
			float4 layerColor1 = tex2D(_LayerTex1, layer1uv)  * _LayerColor1 * rimPow;
			
			
			float layer2_offset_u =_Time * _SpeedU2;
			float layer2_offset_v = _Time * _SpeedV2;
			float2 layer2uv = float2(IN.uv2_LayerTex2.x + layer2_offset_u, IN.uv2_LayerTex2.y + layer2_offset_v);
			float4 layerColor2 = tex2D(_LayerTex2, layer2uv)  * _LayerColor2;
			
			
			float layer3_offset_u =_Time * _SpeedU3;
			float layer3_offset_v = _Time * _SpeedV3;
			float2 layer3uv = float2(IN.uv2_LayerTex3.x + layer3_offset_u, IN.uv2_LayerTex3.y + layer3_offset_v);
			float4 layerColor3 = tex2D(_LayerTex3, layer3uv)  * _LayerColor3;
			
			float4 addColor = (layerColor1 + layerColor3) * 0.5f + layerColor0 + layerColor2;
			
			o.Alpha = mainTexColor.a;
			o.Albedo = mainTexColor.rgb;
			o.Emission = addColor;
			//o.Gloss = _Specular;
		}
		ENDCG
	}
	Fallback "Diffuse"
}