Shader "Custom/TestShowHidden" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Color ("Main Color", Color) = (0, 1, 0, 0.5)
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue"="Geometry+1" }
		LOD 200
		
		UsePass "Custom/RevealOcclution/SOFTADDHIDDEN"
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
		
	} 
	FallBack "Diffuse"
}
