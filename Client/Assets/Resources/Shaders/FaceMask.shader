// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/FaceMask" 
{
     Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
		_MaskTex ("Mask (A)", 2D) = "black" {}
        _Progress ("Progress", Range(0,1)) = 0.5
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
			};
	
			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Progress;
			sampler2D _MaskTex;
				
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = v.texcoord;
				o.color = v.color;
				return o;
			}
				
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 col = tex2D(_MainTex, i.texcoord) * i.color;
				fixed ca = tex2D(_MaskTex, i.texcoord).a;
				if(ca < _Progress)
				{
				  ca = 0;
				}
				else
				{
				   ca = 1;
				}
				col.a *= ca;
				return col;
			}
			ENDCG
		}
	}
}
