Shader "MU/Particle-Lightmap" {
	Properties {
		_Color ("Tint Color (RGBA)", Color) = (1, 1, 1, 1)
		_MainTex ("Base (RGB) Transparent(A)", 2D) = "white" {}
	}

	SubShader {
		Tags { "RenderQueue"="Transparent" }
		LOD 200

		UsePass "Transparent/Diffuse/FORWARD"

		Blend SrcAlpha One
		Lighting Off
		ZWrite Off
		ZTest Off
		CGPROGRAM
		#pragma surface surf Lambert alpha

		sampler2D _MainTex;
		half4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex) * 2 * _Color ;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
