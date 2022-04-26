// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/Gray"
{
	Properties
	{
		_Color ("Main Color", Color) = (1,1,1,1)
        _MainTex ("Base (RGB) Trans (A)", 2D) = "black" {}
        _Grey ("Grey Value", Float) = 1
	}
	
	SubShader
	{
		LOD 100

		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}
		
		Cull Off
		Lighting Off
		ZWrite Off
		Fog { Mode Off }
		Offset -1, -1
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
				
			#include "UnityCG.cginc"
	
			struct appdata_t
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
			};
	
			struct v2f
			{
				float4 vertex : SV_POSITION;
				half2 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
				fixed4 gray :TEXCOORD1;
			};
	
			sampler2D _MainTex;
			float4 _MainTex_ST;
				
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = v.texcoord;
				o.color = v.color;
				o.gray = dot(v.color,fixed4(1,1,1,0));
				return o;
			}
				
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 col = tex2D(_MainTex, i.texcoord);
				col.rgb = dot(col.rgb,fixed3(.222,.707,.071));
				return col;
			}
			ENDCG
		}
	}
}
