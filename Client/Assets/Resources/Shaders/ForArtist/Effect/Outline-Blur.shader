// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/BlurOutline" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}

	SubShader 
	{
		Tags { "RenderType" = "PostEffect" }
		Lighting Off
 		ZTest Always 
 		Cull Off 
 		ZWrite Off

		Pass
		{
			Name "DownScale2x"
			Tags {"LightMode" = "Always"}

			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag

			sampler2D _MainTex;
			float4 _MainTex_TexelSize;

			struct v2f
			{
				float4 pos : POSITION;
				half2 uv : TEXCOORD0;
			};

			v2f vert(appdata_img v)
			{
				v2f o = (v2f)0;
				o.pos = UnityObjectToClipPos (v.vertex);
				half2 uv;
				uv = MultiplyUV (UNITY_MATRIX_TEXTURE0, v.texcoord);

				// Direct3D9 needs some texel offset!
				#ifdef UNITY_HALF_TEXEL_OFFSET
				uv.x += _MainTex_TexelSize.x * 2.0;
				uv.y += _MainTex_TexelSize.y * 2.0;
				#endif

				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				half offX = _MainTex_TexelSize.x;
				half offY = _MainTex_TexelSize.y;

				half4 c0 = tex2D(_MainTex, i.uv + half2(-offX,-offY));
				half4 c1 = tex2D(_MainTex, i.uv + half2( offX,-offY));
				half4 c2 = tex2D(_MainTex, i.uv + half2( offX, offY));
				half4 c3 = tex2D(_MainTex, i.uv + half2(-offX, offY));
				fixed4 c = (c0 + c1 + c2 + c3) * 0.25;
				return c;
			}

			ENDCG
		}

		Pass
		{
			Name "HorizontalBlur"
			Tags {"LightMode" = "Always"}

			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag

			sampler2D _MainTex;
			half4 _MainTex_TexelSize;
			half g_BlurScale;

			struct v2f
			{
				float4 pos : SV_POSITION;
				half2 uv[7] : TEXCOORD0;
			};

			v2f vert(appdata_img v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos (v.vertex);
				o.uv[0] = MultiplyUV( UNITY_MATRIX_TEXTURE0, v.texcoord );
				o.uv[1] = o.uv[0] + half2(_MainTex_TexelSize.x, 0) * g_BlurScale;
				o.uv[2] = o.uv[0] + half2(_MainTex_TexelSize.x, 0) * 2 * g_BlurScale;
				o.uv[3] = o.uv[0] + half2(_MainTex_TexelSize.x, 0) * 3 * g_BlurScale;
				o.uv[4] = o.uv[0] - half2(_MainTex_TexelSize.x, 0) * g_BlurScale;
				o.uv[5] = o.uv[0] - half2(_MainTex_TexelSize.x, 0) * 2 * g_BlurScale;
				o.uv[6] = o.uv[0] - half2(_MainTex_TexelSize.x, 0) * 3 * g_BlurScale;
				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				half4 c0 = tex2D(_MainTex, i.uv[0]) * 0.33333333;
				half4 c1 = tex2D(_MainTex, i.uv[1]) * 0.19047619;
				half4 c2 = tex2D(_MainTex, i.uv[2]) * 0.09523809;
				half4 c3 = tex2D(_MainTex, i.uv[3]) * 0.04761904;
				half4 c4 = tex2D(_MainTex, i.uv[4]) * 0.19047619;
				half4 c5 = tex2D(_MainTex, i.uv[5]) * 0.09523809;
				half4 c6 = tex2D(_MainTex, i.uv[6]) * 0.04761904;
				half4 c = c0 + c1 + c2 + c3 + c4 + c5 + c6;
				return c;
			}

			ENDCG
		}

		Pass
		{
			Name "VerticalBlur"
			Tags {"LightMode" = "Always"}

			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag

			sampler2D _MainTex;
			half4 _MainTex_TexelSize;

			struct v2f
			{
				float4 pos : SV_POSITION;
				half2 uv[7] : TEXCOORD0;
			};

			v2f vert(appdata_img v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos (v.vertex);
				o.uv[0] = MultiplyUV( UNITY_MATRIX_TEXTURE0, v.texcoord );
				o.uv[1] = o.uv[0] + half2(0, _MainTex_TexelSize.y);
				o.uv[2] = o.uv[0] + half2(0, _MainTex_TexelSize.y) * 2;
				o.uv[3] = o.uv[0] + half2(0, _MainTex_TexelSize.y) * 3;
				o.uv[4] = o.uv[0] - half2(0, _MainTex_TexelSize.y);
				o.uv[5] = o.uv[0] - half2(0, _MainTex_TexelSize.y) * 2;
				o.uv[6] = o.uv[0] - half2(0, _MainTex_TexelSize.y) * 3;
				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				half4 c0 = tex2D(_MainTex, i.uv[0]) * 0.33333333;
				half4 c1 = tex2D(_MainTex, i.uv[1]) * 0.19047619;
				half4 c2 = tex2D(_MainTex, i.uv[2]) * 0.09523809;
				half4 c3 = tex2D(_MainTex, i.uv[3]) * 0.04761904;
				half4 c4 = tex2D(_MainTex, i.uv[4]) * 0.19047619;
				half4 c5 = tex2D(_MainTex, i.uv[5]) * 0.09523809;
				half4 c6 = tex2D(_MainTex, i.uv[6]) * 0.04761904;
				half4 c = c0 + c1 + c2 + c3 + c4 + c5 + c6;
				return c;
			}

			ENDCG
		}

		Pass
		{
			Name "CombineSilhouette"
			Tags {"LightMode" = "Always"}

			Blend Off

			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag

			sampler2D _MainTex;
			sampler2D g_SolidSilhouette;
			sampler2D g_BlurSilhouette;

			half4 _MainTex_TexelSize;

			struct v2f
			{
				float4 pos : SV_POSITION;
				half2 uv : TEXCOORD0;
			};

			v2f vert(appdata_img v)
			{
				v2f o = (v2f)0;
				o.pos = UnityObjectToClipPos (v.vertex);
				o.uv = v.texcoord.xy;
				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				fixed4 silMask = tex2D(g_SolidSilhouette, i.uv.xy);
				fixed4 frameColor = tex2D(_MainTex, i.uv.xy);
				fixed4 outlineColor = tex2D(g_BlurSilhouette, i.uv.xy);
				if (any (silMask))
					return frameColor;
				return fixed4(frameColor.rgb + outlineColor.rgb, 1);
			}
			
			ENDCG
		}
	}
}
