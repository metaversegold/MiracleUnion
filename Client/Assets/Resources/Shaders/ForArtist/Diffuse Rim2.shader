Shader "Artist/Diffuse Rim2" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_RimColor ("Rim Color", Color) = (0.5,0.5,0.5,0.5)
		_RimPower ("Rim Power", Range(0.0,10.0)) = 2.5
		_InnerColor ("Inner Color", Color) = (0.5,0.5,0.5,0.5)
		_InnerColorPower ("Inner Color Power", Range(0.0,10.0)) = 0.5
	}
	SubShader {
		Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha

		CGPROGRAM
		#pragma surface surf Lambert noforwardadd nofog nometa nodirlightmap nodynlightmap nolightmap noshadow exclude_path:deferred exclude_path:prepass interpolateview

		sampler2D _MainTex;
		float4 _RimColor;
		float _RimPower;
		float _InnerColorPower;
		float4 _InnerColor;

		struct Input {
			float3 viewDir;
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			half rim = 1.0 - abs(dot (normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow (rim, _RimPower) + (_InnerColor.rgb * 2 * pow (rim, _InnerColorPower));
			o.Alpha = c.a;
		}
		ENDCG
	}
}
