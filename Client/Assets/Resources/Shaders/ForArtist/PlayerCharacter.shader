// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Artist/PlayerCharacter" 
{
	Properties {
		_MainTex ("Base (RGB) Cutoff (A)", 2D) = "white" {} 
		_MaskTex ("SpecColor(RGB) Skin(A)", 2D) = "white" {} 
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" {}
		_ReflectStrength ("Reflection Strength", Range(0, 2)) = 0

		_EmissionTex ("Emission (RGB)", 2D) = "white" {}
		_EmissionMask ("Emission Mask (A)", 2D) = "white" {}
		_EmissionColor ("Emission Color", Color) = (1,1,1,0.5)
		
		_SpecPow("SpecularPower", Range(0, 1)) = 0.5
		_TimeScale1 ("Time Scale for Animation 1", Float) = 8
		_ViewDirTex1 ("View Direction Animation 1", 2D) = "white" {}
		
		[HideInInspector] _Color ("__color", Color) = (1, 1, 1, 1)
		[HideInInspector] _SrcBlend ("__src", Float) = 1.0
		[HideInInspector] _DstBlend ("__dst", Float) = 0.0
		[HideInInspector] _CullMode ("__cull", Float) = 2.0
		[HideInInspector] _Cutoff ("__cutout", Range(0, 1)) = 0.01
	}
	
	SubShader {
		Tags { "RenderType"="Opaque" "Queue"="Geometry" }
		Blend [_SrcBlend] [_DstBlend]
		Cull [_CullMode]

		Pass
		{
			Tags { "LightMode"="ForwardBase" }

			CGPROGRAM
			#pragma target 2.0
			
			#pragma shader_feature _ _EMISSION _MASK_EMISSION

			#pragma multi_compile __ _ALPHATEST_ON
			#pragma multi_compile __ _REF_SPEC _REF_SPEC1

			#pragma multi_compile_fog
			#pragma skip_variants FOG_EXP FOG_EXP2
			#pragma exclude_renderers xbox360 ps3

			#include "UnityCG.cginc"
			#include "UnityStandardBRDF.cginc"

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_REF_SPEC) || defined(_REF_SPEC1)
			#define _SPEC_ON
			#endif

			struct vertex_data
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				half2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : POSITION;
				half4 uv : TEXCOORD0;
				half4 lighting : TEXCOORD1;
				UNITY_FOG_COORDS(2)
				#ifdef _SPEC_ON
					half3 reflectW : TEXCOORD3;
					#ifndef _REF_SPEC
						half3 normalV : TEXCOORD4;
					#endif
				#endif
			};

			half4 _EmissionTex_ST;
			fixed _ReflectStrength;
			half4x4 _RotateMatrix;

			v2f vert(vertex_data v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv.xyxy;
				#if defined(_EMISSION) || defined(_MASK_EMISSION)
					o.uv.zw = TRANSFORM_TEX(v.uv, _EmissionTex);
				#endif
				
				//normal, view, light direction
				half3 dirNormal = normalize(mul((float3x3)unity_ObjectToWorld, v.normal));
				half3 dirEye = normalize(_WorldSpaceCameraPos.xyz - v.vertex.xyz);
				half3 dirLight = _WorldSpaceLightPos0.xyz;
				
				o.lighting = 0;
				#ifdef _SPEC_ON
					half NdotE = dot(dirNormal, dirEye);
					half3 dirHalf = normalize(dirLight + dirEye);
					half spec = Pow5(max(0, dot(dirNormal, dirHalf)));
					o.lighting.rgb = spec * spec;
					o.lighting.w = (1 - Pow5(max(0, NdotE))) *_ReflectStrength * 10;
					o.reflectW = mul((half3x3)_RotateMatrix, dirNormal * NdotE * 2 - dirEye);
					#ifndef _REF_SPEC
						o.normalV = mul( (half3x3)UNITY_MATRIX_V, dirNormal );
					#endif
				#else
					half NdotL = max(0, dot(dirNormal, dirLight));
					o.lighting.rgb = _LightColor0.rgb * NdotL;
				#endif

				UNITY_TRANSFER_FOG(o, o.pos);
				return o;
			}

			sampler2D _MainTex;
			sampler2D _MaskTex;
			sampler2D _ViewDirTex1;
			sampler2D _EmissionTex;
			sampler2D _EmissionMask;
			sampler2D _NHxRoughness;
			samplerCUBE _Cube;

			fixed4 _SpecColor1;
			fixed4 _EmissionColor;
			fixed4 _Color;

			float _TimeScale1;
			half _SpecPow;
			fixed _Cutoff;

			fixed4 frag(v2f i) : COLOR
			{
				fixed4 baseColor = tex2D(_MainTex, i.uv.xy);

				#if defined(_ALPHATEST_ON)
					clip(baseColor.a - _Cutoff);
				#endif

				#ifdef _SPEC_ON
					fixed4 maskColor = tex2D(_MaskTex, i.uv.xy);
					fixed3 color = baseColor.rgb * (1 + i.lighting.rgb);
					fixed3 refColor = texCUBE(_Cube, normalize(i.reflectW)).rgb * baseColor.rgb * baseColor.rgb * baseColor.rgb * i.lighting.w * maskColor.a;

					#ifndef _REF_SPEC
						i.normalV.y = 0;
						half3 normalV = normalize(i.normalV);
						half3 dirEye1 = tex2D(_ViewDirTex1, half2(_Time.x * _TimeScale1, 0)).xyz * 2 - 1;
						half ndote = dot(dirEye1, normalV);
						refColor += maskColor.rgb * tex2D(_NHxRoughness, half2(Pow4(ndote), _SpecPow)).r * 2;
					#endif

					color += refColor;
				#else
					fixed3 color = baseColor.rgb * (i.lighting.rgb + UNITY_LIGHTMODEL_AMBIENT.rgb);
				#endif

				#ifdef _EMISSION
					color += tex2D(_EmissionTex, i.uv.zw).rgb * _EmissionColor.rgb;
				#elif defined (_MASK_EMISSION)
					color += tex2D(_EmissionTex, i.uv.zw).rgb * _EmissionColor.rgb * tex2D(_EmissionMask, i.uv.xy).a;
				#endif
				
				UNITY_APPLY_FOG(i.fogCoord, color.rgb);
				return fixed4(color, _Color.a);
			}
			ENDCG
		}

		// ------------------------------------------------------------------
		//  Shadow rendering pass
		Pass {
			Name "ShadowCaster"
			Tags { "LightMode" = "ShadowCaster" }
			
			ZWrite On ZTest LEqual

			CGPROGRAM
			#pragma target 2.0

			#pragma multi_compile __ _ALPHATEST_ON
			#pragma skip_variants SHADOWS_SOFT SHADOWS_CUBE
			#pragma multi_compile_shadowcaster

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityStandardShadow.cginc"

			
			void vert (VertexInput v,
				#ifdef UNITY_STANDARD_USE_SHADOW_OUTPUT_STRUCT
				out VertexOutputShadowCaster o,
				#endif
				out float4 opos : SV_POSITION)
			{
				TRANSFER_SHADOW_CASTER_NOPOS(o,opos)
				#if defined(UNITY_STANDARD_USE_SHADOW_UVS)
					o.tex = TRANSFORM_TEX(v.uv0, _MainTex);
				#endif
			}

			half4 frag (
				#ifdef UNITY_STANDARD_USE_SHADOW_OUTPUT_STRUCT
				VertexOutputShadowCaster i
				#endif
				#ifdef UNITY_STANDARD_USE_DITHER_MASK
				, UNITY_VPOS_TYPE vpos : VPOS
				#endif
				) : SV_Target
			{
				#if defined(UNITY_STANDARD_USE_SHADOW_UVS)
					half alpha = tex2D(_MainTex, i.tex).a;
					#if defined(_ALPHATEST_ON)
						clip (alpha - _Cutoff);
					#endif
					#if defined(_ALPHABLEND_ON)
						#if defined(UNITY_STANDARD_USE_DITHER_MASK)
							// Use dither mask for alpha blended shadows, based on pixel position xy
							// and alpha level. Our dither texture is 4x4x16.
							half alphaRef = tex3D(_DitherMaskLOD, float3(vpos.xy*0.25, alpha*0.9375)).a;
							clip (alphaRef - 0.01);
						#else
							clip (alpha - _Cutoff);
						#endif
					#endif
				#endif // #if defined(UNITY_STANDARD_USE_SHADOW_UVS)

				SHADOW_CASTER_FRAGMENT(i)
			}			

			ENDCG
		}
	}

	CustomEditor "PlayerCharacterShaderGUI"
}
