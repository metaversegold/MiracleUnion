Shader "Artist/Diffuse Alpha Cut" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_AlphaCut ("Alpha Cut", Range(0, 1)) = 0.1
	}

	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		
		CGPROGRAM
		#pragma surface surf Lambert alphatest:_AlphaCut noforwardadd nometa nodirlightmap nodynlightmap nolightmap noshadow exclude_path:deferred exclude_path:prepass interpolateview

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}

	Fallback "Mobile/VertexLit"
}
