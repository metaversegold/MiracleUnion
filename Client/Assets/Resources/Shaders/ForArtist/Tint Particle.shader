// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Artist/Tint Particle" {
	Properties {
		_TintColor ("Tint Color", Color) = (1, 1, 1, 1)
		_MainTex ("Main Texture", 2D) = "white" {}

		_Mask ("Mask Texture", 2D) = "white" {}

		_DissolveTex ("Dissolve Tex (A)", 2D) = "white" {}
		_Dissolve ("Dissolve Strength", Range(0, 1)) = 0.0

		_NumTexTiles("Num tex tiles", Vector) = (4,4,0,0)
		_ReplaySpeed("Replay speed - FPS", Float) = 4

		_Scrolls ("Scroll Speed (XY), Offset(ZW)", Vector) = (0, 0, 0, 0)
		_Tiling ("_Tiling (XY)", Vector) = (1, 1, 0, 0)

		[HideInInspector] _BlendMode ("__bmode", Float) = 0.0
		[HideInInspector] _RenderMode ("__rmode", Float) = 0.0
		[HideInInspector] _SrcBlend ("__src", Float) = 5.0
		[HideInInspector] _DstBlend ("__dst", Float) = 10.0
		[HideInInspector] _BlendOp ("__op", Float) = -1.0
		[HideInInspector] _QueueOffset ("__offset", Float) = 0.0
	}

	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend [_SrcBlend] [_DstBlend]
		BlendOp [_BlendOp]
		Cull Off Lighting Off ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#pragma shader_feature _USE_MASK
			#pragma shader_feature _DISSOLVE
			#pragma shader_feature _ UV_ANIM UV2_ANIM UV_ROT_ANIM FRAME_ANIM
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				#ifndef UV2_ANIM
					float2 texcoord : TEXCOORD0;
				#else
					float2 texcoord : TEXCOORD1;
				#endif
				fixed4 color : COLOR;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				half4 uv : TEXCOORD0;
				fixed4 color : TEXCOORD1;

				#if defined(FRAME_ANIM) || defined(UV_ROT_ANIM)
				half4 uvPack : TEXCOORD2;
				#endif
			};

			sampler2D _Mask;
			sampler2D _MainTex;
			sampler2D _DissolveTex;
			float4 _NumTexTiles;
			float	_ReplaySpeed;
			half _Dissolve;
			float4 _Scrolls;
			half4 _Tiling;
			half4 _MainTex_ST;
			half4 _Mask_ST;
			fixed4 _TintColor;

			v2f vert(appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);

				#if defined(FRAME_ANIM)
					float	time = _Time.y * _ReplaySpeed;
					float	itime	= floor(time);
					float	ntime	 = itime + 1;
					half ftime = time - itime;
		
					float2 texTileSize = 1.f / _NumTexTiles.xy;		
					float4 tile;
					tile.xy = float2(itime, 1 - floor(itime /_NumTexTiles.x));
					tile.zw= float2(ntime, 1 - floor(ntime /_NumTexTiles.x));
					tile = fmod(tile,_NumTexTiles.xyxy);
					o.uv = (v.texcoord.xyxy + tile) * texTileSize.xyxy;
					o.uvPack = ftime.xxxx;
				#elif defined(UV_ANIM) || defined(UV2_ANIM)
					o.uv = half4(v.texcoord * _Tiling.xy +frac( _Scrolls.xy * _Time.y) + _Scrolls.zw, v.texcoord);
				#elif defined(UV_ROT_ANIM)
					half cosA, sinA;
					sincos(_Time.y * _ReplaySpeed, sinA, cosA);
					o.uvPack = half4(cosA, -sinA, sinA, cosA);
					o.uv = half4((v.texcoord - 0.5), v.texcoord.xy);
				#else
					o.uv = half4(TRANSFORM_TEX(v.texcoord, _MainTex), v.texcoord);
				#endif

				#if defined(_USE_MASK)
					#if defined(FRAME_ANIM)
						o.uvPack.xy = TRANSFORM_TEX(v.texcoord, _Mask);
					#else
						o.uv.zw = TRANSFORM_TEX(v.texcoord, _Mask);
					#endif
				#endif

				o.color = v.color * _TintColor;
				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				#if defined(_DISSOLVE)
					half dissolve = tex2D (_DissolveTex, i.uv.xy).a;
					clip(dissolve - _Dissolve);
				#endif
				
				#if defined(FRAME_ANIM)
					fixed4 baseColor = lerp(tex2D (_MainTex, i.uv.xy), tex2D (_MainTex, i.uv.zw), i.uvPack.w);
				#elif defined(UV_ROT_ANIM)
					half2x2 uvMat = half2x2(i.uvPack.xy, i.uvPack.zw);
					fixed4 baseColor = tex2D(_MainTex, saturate(mul(uvMat, i.uv.xy) + 0.5));
				#else
					fixed4 baseColor = tex2D(_MainTex, i.uv.xy);
				#endif

				#if defined(_USE_MASK)
					#if defined(FRAME_ANIM)
						baseColor *= tex2D(_Mask, i.uvPack.xy);
					#else
						baseColor *= tex2D(_Mask, i.uv.zw);
					#endif
				#endif

				return baseColor * i.color * 2;
			}
			ENDCG
		}
	}

	CustomEditor "ParticleShaderGUI"
}
