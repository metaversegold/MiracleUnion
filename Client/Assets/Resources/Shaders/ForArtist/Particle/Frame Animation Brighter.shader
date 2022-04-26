// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Artist/Particle/Frame Animation Brighter" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_NumTexTiles("Num tex tiles",	Vector) = (4,4,0,0)
		_ReplaySpeed("Replay speed - FPS",float) = 4
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader 
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend One One
		BlendOp Max
		Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }

		CGINCLUDE
		#include "UnityCG.cginc"
		sampler2D _MainTex;
	
		float4 _Color;
		float4 _NumTexTiles;
		float	_ReplaySpeed;
		float	_Randomize;
	
		struct v2f {
			float4 pos : SV_POSITION;
			float4 uv : TEXCOORD0;
			fixed lerp : TEXCOORD1;
		};

	
		v2f vert (appdata_full v)
		{
			v2f o;
		
			float	time = _Time.y * _ReplaySpeed;
			float	itime	= floor(time);
			float	ntime	 = itime + 1;
			float	ftime	 = time - itime;
		
			float2 texTileSize = 1.f / _NumTexTiles.xy;		
			float4 tile;
			tile.xy = float2(itime, 1 - floor(itime /_NumTexTiles.x));
			tile.zw= float2(ntime, 1 - floor(ntime /_NumTexTiles.x));
			tile = fmod(tile,_NumTexTiles.xyxy);
		
			o.pos = UnityObjectToClipPos(v.vertex);
			o.uv = (v.texcoord.xyxy + tile) * texTileSize.xyxy;
			o.lerp = ftime;
		
			return o;
		}
		ENDCG

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			fixed4 frag (v2f i) : COLOR
			{
				return lerp(tex2D (_MainTex, i.uv.xy), tex2D (_MainTex, i.uv.zw), i.lerp) * _Color * 2;
			}
			ENDCG 
		}	
	}
}
