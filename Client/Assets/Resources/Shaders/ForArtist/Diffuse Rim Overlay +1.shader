﻿Shader "Artist/Diffuse Rim Overlay +1" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Tint ("Tint (RBG)", Color) = (0, 1, 1, 1)
	}
	
	SubShader {
		Tags {"Queue"="Transparent+1" "IgnoreProjector"="True" "RenderType"="Transparent"}
		ZWrite Off ZTest Always
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
      	#pragma surface surf Lambert noforwardadd nofog nometa nodirlightmap nodynlightmap nolightmap noshadow exclude_path:deferred exclude_path:prepass interpolateview
      	struct Input {
      	    float2 uv_MainTex;
      	    float3 viewDir;
      	    float3 worldNormal;
      	};
      	sampler2D _MainTex;
      	half4 _Tint;
      	void surf (Input IN, inout SurfaceOutput o) {
       	   o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * 5.0 * _Tint.rgb;
       	   o.Alpha = 1 - saturate( dot(normalize(IN.worldNormal), normalize(IN.viewDir)) );
      	}
      	ENDCG
	} 
}
