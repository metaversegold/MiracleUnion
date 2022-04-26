// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Artist/Scene/Terrain Mobile 3 Texture" {
	Properties 
	{
		_Layer1 ("Layer 1 (R)", 2D) = "white" {}
		_Layer2 ("Layer 2 (G)", 2D) = "white" {}
		_Layer3 ("Layer 3 (B)", 2D) = "white" {}
		_MainTex ("Control (RGB)", 2D) = "white" {}
	}
	
	SubShader {
		Tags { "RenderType"="Opaque" "Queue" = "Geometry+1"}
		Pass
		{
			Name "FORWARD"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#pragma exclude_renderers xbox360 ps3
			#pragma multi_compile_fog
			#pragma multi_compile_fwdbase nodynlightmap
			
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"
			#include "UnityGlobalIllumination.cginc"

			struct v2f {
				float4 pos : SV_POSITION;
				half4 uvPack[3] : TEXCOORD0;
				UNITY_FOG_COORDS(3)
				half4 ambientOrLightmapUV : TEXCOORD4;	// SH or Lightmap UV
			};
			
			half4 _Layer1_ST;
			half4 _Layer2_ST;
			half4 _Layer3_ST;

			v2f vert (appdata_full v) {
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f, o);
				o.uvPack[0].xy = TRANSFORM_TEX(v.texcoord, _Layer1);
				o.uvPack[0].zw = TRANSFORM_TEX(v.texcoord, _Layer2);
				o.uvPack[1].xy = TRANSFORM_TEX(v.texcoord, _Layer3);
				o.uvPack[2].xy = v.texcoord;

				o.pos = UnityObjectToClipPos(v.vertex);
				float3 normalWorld = UnityObjectToWorldNormal(v.normal);
				half ndotl = saturate(dot(normalWorld, _WorldSpaceLightPos0.xyz));
				
				// Static lightmaps
				#ifndef LIGHTMAP_OFF
					o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif
				o.ambientOrLightmapUV.w = ndotl;

				UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
				return o;
			}

			sampler2D _Layer1;
			sampler2D _Layer2;
			sampler2D _Layer3;
			sampler2D _MainTex;

			half4 frag(v2f i) : COLOR
			{
				half3 splat0 = tex2D (_Layer1, i.uvPack[0].xy);
				half3 splat1 = tex2D (_Layer2, i.uvPack[0].zw);
				half3 splat2 = tex2D (_Layer3, i.uvPack[1].xy);
				half4 weights = tex2D (_MainTex, i.uvPack[2].xy);
				half3 baseColor = weights.x * splat0.rgb + weights.y * splat1.rgb + weights.z * splat2.rgb;

				#ifdef LIGHTMAP_ON
					fixed4 bakedColorTex = UNITY_SAMPLE_TEX2D(unity_Lightmap, i.ambientOrLightmapUV.xy); 
					half3 bakedColor = DecodeLightmap(bakedColorTex);
					
					#if DIRLIGHTMAP_COMBINED
						half atten = UNITY_SAMPLE_TEX2D_SAMPLER (unity_LightmapInd, unity_Lightmap, i.ambientOrLightmapUV.xy).r;
						i.ambientOrLightmapUV.w *= atten;
						bakedColor = MixLightmapWithRealtimeAttenuation (bakedColor, atten, bakedColorTex);
					#endif
					half3 color = baseColor * (_LightColor0.rgb * i.ambientOrLightmapUV.w + bakedColor);
				#else
					half3 color = baseColor * (_LightColor0.rgb * i.ambientOrLightmapUV.w + UNITY_LIGHTMODEL_AMBIENT.rgb);
				#endif
				
				half4 c = half4(color, 1);
				UNITY_APPLY_FOG(i.fogCoord, c.rgb);
				return c;
			}
			ENDCG
		}
	}
}
