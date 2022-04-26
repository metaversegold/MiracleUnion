Shader "Custom/RevealOcclution" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Color ("Hidden Tint Color", Color) = (0, 1, 0, 0.5)
	}
	SubShader {
		Tags { "Queue"="Transparent" }
		LOD 100
	} 
	FallBack "Diffuse"
}
