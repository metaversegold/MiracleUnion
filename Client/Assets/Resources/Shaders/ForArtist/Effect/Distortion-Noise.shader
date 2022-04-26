// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Artist/Effect/Distort-Noise"
{
	Properties {
		_NoiseTex ("Noise Texture (RG)", 2D) = "white" {}
		_HeatTime  ("Heat Time", range (0,1.5)) = 1
		_HeatForce  ("Heat Force", range (0,0.1)) = 0.1
	}
	
	SubShader 
	{
		Tags { "Queue"="Transparent+100" "RenderType"="Opaque" }
		Blend SrcAlpha OneMinusSrcAlpha
		Lighting Off ZWrite Off
		Pass {
			Name "BASE"
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata_t 
			{
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord: TEXCOORD0;
			};

			struct v2f 
			{
				float4 vertex : POSITION;
				float4 uvgrab : TEXCOORD0;
				float2 uvnoise : TEXCOORD1;
			};

			float _HeatForce;
			float _HeatTime;
			float4 _NoiseTex_ST;
			sampler2D _NoiseTex;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
				#else
				float scale = 1.0;
				#endif
				o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y*scale) + o.vertex.w) * 0.5;
				o.uvgrab.zw = o.vertex.zw;
				o.uvnoise = TRANSFORM_TEX( v.texcoord, _NoiseTex );
				return o;
			}

			sampler2D _GrabTexture;

			half4 frag( v2f i ) : COLOR
			{
				//noise effect
				half4 offsetColor1 = tex2D(_NoiseTex, i.uvnoise + _Time.xz*_HeatTime);
				half4 offsetColor2 = tex2D(_NoiseTex, i.uvnoise - _Time.yx*_HeatTime);
				i.uvgrab.x += ((offsetColor1.r + offsetColor2.r) - 1) * _HeatForce;
				i.uvgrab.y += ((offsetColor1.g + offsetColor2.g) - 1) * _HeatForce;

				half4 col = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				col.a = 1.0f;
				return col;
			}
			ENDCG
		}
	}
}