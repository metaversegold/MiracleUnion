Shader "Artist/Diffuse" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}

	SubShader {
		Tags { "RenderType"="Opaque" "IgnoreProjector"="True" }
		LOD 100

		CGPROGRAM
		#pragma surface surf Lambert noforwardadd nometa nodirlightmap nodynlightmap nolightmap noshadow exclude_path:deferred exclude_path:prepass interpolateview

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	}

	Fallback "Mobile/VertexLit"
}
