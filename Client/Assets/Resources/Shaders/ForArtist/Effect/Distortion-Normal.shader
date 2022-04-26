// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Artist/Effect/Distort-Normal" 
{
	Properties {
		_MainTex ("Tint Color (RGB)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_BumpAmt  ("Distortion", range (0,128)) = 10
	}

	SubShader 
	{
		Tags { "Queue"="Transparent+100" "RenderType"="Opaque" }
		Lighting Off ZWrite Off
		Cull Off

		Pass 
		{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag

			struct appdata_t {
				float4 vertex : POSITION;
				float2 texcoord: TEXCOORD0;
			};

			struct v2f {
				float4 vertex : POSITION;
				float4 uvgrab : TEXCOORD0;
				float2 uvbump : TEXCOORD1;
				float2 uvmain : TEXCOORD2;
			};

			sampler2D _GrabTexture;
			float4 _GrabTexture_TexelSize;
			sampler2D _BumpMap;
			sampler2D _MainTex;
			float _BumpAmt;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				
				#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
				#else
				float scale = 1.0;
				#endif
				
				o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y * scale) + o.vertex.w) * 0.5;
				o.uvgrab.zw = o.vertex.zw;
				o.uvbump = MultiplyUV( UNITY_MATRIX_TEXTURE1, v.texcoord );
				o.uvmain = MultiplyUV( UNITY_MATRIX_TEXTURE2, v.texcoord );
				return o;
			}

			half4 frag( v2f i ) : COLOR
			{
				// calculate perturbed coordinates
				half2 bump = UnpackNormal(tex2D( _BumpMap, i.uvbump )).rg;
				float2 offset = bump * _BumpAmt * _GrabTexture_TexelSize.xy;
				i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;
	
				half4 col = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				half4 tint = tex2D( _MainTex, i.uvmain );
				return col * tint;
			}
			ENDCG
		}
	}

	Fallback "Artist/Particle/Additive Tint +1"
}
