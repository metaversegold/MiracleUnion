Shader "MU_Emission"
{
	Properties 
	{
_Diffuse("_Diffuse", 2D) = "black" {}
_EMission("_EMission", 2D) = "black" {}

	}
	
	SubShader 
	{
		Tags
		{
"Queue"="Geometry"
"IgnoreProjector"="False"
"RenderType"="Opaque"

		}

		
Cull Back
ZWrite On
ZTest LEqual
ColorMask RGBA
Fog{
}
		CGPROGRAM
#pragma surface surf BlinnPhongEditor  vertex:vert nolightmap
#pragma target 2.0


sampler2D _Diffuse;
sampler2D _EMission;

			struct EditorSurfaceOutput {
				half3 Albedo;
				half3 Normal;
				half3 Emission;
				half3 Gloss;
				half Specular;
				half Alpha;
				half4 Custom;
			};
			
			inline half4 LightingBlinnPhongEditor_PrePass (EditorSurfaceOutput s, half4 light)
			{
			
			
				half3 spec = light.a * s.Gloss;
				half4 c;
				c.rgb = (s.Albedo * float4(0.6,0.6,0.6,1));
				c.a = s.Alpha;
				return c;

			}

			inline half4 LightingBlinnPhongEditor (EditorSurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
			{
				//lightDir = (0.9f,0.9f,0.9f);
				half3 h = normalize (lightDir + viewDir);
				
				half diff = max (0, dot ( lightDir, s.Normal ));
				
				float nh = max (0, dot (s.Normal, h));
				float spec = pow (nh, s.Specular*128.0);
				
				half4 res;
				float3 c = (0.5,0.5,0.5);
				res.rgb = c * diff;
				res.w = spec * Luminance (c);
				res *= atten * 2.0;

				return LightingBlinnPhongEditor_PrePass( s, res );
			}
			
			struct Input {
				float2 uv_Diffuse;
				float2 uv_EMission;

			};

			void vert (inout appdata_full v, out Input o) {
			float4 VertexOutputMaster0_0_NoInput = float4(0,0,0,0);
			float4 VertexOutputMaster0_1_NoInput = float4(0,0,0,0);
			float4 VertexOutputMaster0_2_NoInput = float4(0,0,0,0);
			float4 VertexOutputMaster0_3_NoInput = float4(0,0,0,0);


			}
			

			void surf (Input IN, inout EditorSurfaceOutput o) {
				o.Normal = float3(0.0,0.0,1.0);
				//o.Normal = float3(1.0,0.0,1.0);
				o.Alpha = 1.0;
				o.Albedo = 0.0;
				o.Emission = 0.0;
				o.Gloss = 0.0;
				o.Specular = 0.0;
				o.Custom = 0.0;
				//float2 d = (1,1);
float4 Sampled2D0=tex2D(_Diffuse,IN.uv_Diffuse.xy);
float4 Sampled2D1=tex2D(_EMission,IN.uv_EMission.xy);
float4 Master0_1_NoInput = float4(0,0,1,1);
float4 Master0_3_NoInput = float4(0,0,0,0);
float4 Master0_4_NoInput = float4(0,0,0,0);
float4 Master0_5_NoInput = float4(1,1,1,1);
float4 Master0_7_NoInput = float4(0,0,0,0);
float4 Master0_6_NoInput = float4(1,1,1,1);
o.Albedo = Sampled2D0;
o.Emission = Sampled2D1;

				o.Normal = normalize(o.Normal);
			}
		ENDCG

	}
	Fallback "Diffuse"
}