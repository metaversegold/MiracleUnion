Shader "DoubleFace_Alpha"
{
	Properties 
	{
		_MainTex("Base (RGB) Gloss (A)", 2D) = "white" {}
	}
	
	SubShader 
	{
		Tags
		{
			"Queue"="Transparent"
			"IgnoreProjector"="True"
			"RenderType"="Transparent"
		}
		
		Cull Off
		ZWrite On
		ZTest LEqual
		ColorMask RGBA

		CGPROGRAM
		#pragma surface surf Lambert alpha
		#pragma target 2.0

		sampler2D _MainTex;
		
		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {		
			
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	
	Fallback "VertexLit"
}