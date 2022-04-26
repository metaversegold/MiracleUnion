// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Artist/Scene/Blinking Near Fade Light Ray" {
	Properties {
		_MainTex ("Base texture", 2D) = "white" {}
		_FadeOutDistNear ("Near fadeout dist", float) = 10
		_Multiplier("Color multiplier", float) = 1
		_TimeOnDuration("Blink duration", float) = 0.5
		_NoiseAmount("Blink amount", Range(0, 1)) = 0.5
		_Color("Color", Color) = (1, 1, 1, 1)
	}

	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend One One
		Cull Off Lighting Off ZWrite Off
		LOD 100
	
		CGINCLUDE	
		#include "UnityCG.cginc"

		sampler2D _MainTex;
		float _FadeOutDistNear;
		float _Multiplier;
		float _TimeOnDuration;
		float _NoiseAmount;
		float4 _Color;
	
		struct v2f {
			float4	pos	: SV_POSITION;
			float2	uv		: TEXCOORD0;
			fixed4	color	: TEXCOORD1;
		};
	
		v2f vert (appdata_full v)
		{
			v2f o;
			
			float noiseTime	=  _Time.y *  (6.2831853f / _TimeOnDuration);
			float noise = sin(noiseTime) * (0.5f * cos(noiseTime * 0.6366f + 56.7272f) + 0.5f);
			float noiseWave	= _NoiseAmount * noise + (1 - _NoiseAmount);
		 
			float3 viewPos = mul(UNITY_MATRIX_MV, v.vertex);
			float dist = length(viewPos);
			float nfadeout = saturate(dist / _FadeOutDistNear);
			nfadeout *= nfadeout;
			nfadeout *= nfadeout;
				
			o.uv = v.texcoord.xy;
			o.pos	= UnityObjectToClipPos(v.vertex);
			o.color = nfadeout * _Color * _Multiplier * noiseWave;
			return o;
		}
		ENDCG

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			fixed4 frag (v2f i) : COLOR
			{		
				return tex2D (_MainTex, i.uv.xy) * i.color;
			}
			ENDCG 
		}	
	}
}
