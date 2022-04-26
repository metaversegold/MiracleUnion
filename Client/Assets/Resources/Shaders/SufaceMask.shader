// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/SufeMask" {
	Properties
	{
 		_MainTex ("_MainTex", 2D) = "white" {}
 		_MainTex1 ("_MainTex1", 2D) = "white" {}
 		_MainColor2 ("_MainColor2", Color) = (1,1,1,1)
 		_MainTex2 ("_MainTex2", 2D) = "white" {}
 		_MainColor3 ("_MainColor3", Color) = (1,1,1,1)
 		_MainTex3 ("_MainTex3", 2D) = "white" {}
 		_Mask ("Mask Range",range(0,1)) = 1
 		//_LineHight ("_LineHight",float) = 0.01
 		//_LineMixHight("_LineMixHight",range(0,1)) = 0.5
 		//_decayHight("_decayHight",range(2,0)) = 0
	}

	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
 		Blend SrcAlpha OneMinusSrcAlpha
 		Cull Off Lighting Off ZWrite on Fog { Color (0,0,0,0) }
 		
 		BindChannels {
 			Bind "Color", color
 			Bind "Vertex", vertex
 			Bind "TexCoord", texcoord
 		}
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct VS_Input 
			{
 				float4 vertex : POSITION;
 				float3 normal : NORMAL;
 				float4 uv : TEXCOORD0;
 			};
			sampler2D _MainTex;
 			sampler2D _MainTex1;
 			sampler2D _MainTex2;
 			sampler2D _MainTex3;
 			float _Mask;
 			float2 uv_MainTex;
 			float4 _MainColor;
 			float4 _MainColor1;
 			float4 _MainColor2;
 			float4 _MainColor3;
 			float _LineHight;
 			float _LineMixHight;
 			float _decayHight;
 			fixed4 _MainTex_ST;
 			fixed4 _MainTex1_ST;
 			fixed4 _MainTex2_ST;
 			fixed4 _MainTex3_ST;
 			struct VS_Output 
			{
 			    float4 position : POSITION;
 			    float4 OldPosition : TEXCOORD1;
 				half2 uv : TEXCOORD0;
 				half2 uv1 : TEXCOORD2;
 				half2 uv2 : TEXCOORD3;
 				half2 uv3 : TEXCOORD4;
 			};

			VS_Output vert (VS_Input v)
			{
				VS_Output o;
 				o.position = UnityObjectToClipPos(v.vertex);
 				o.OldPosition =  v.vertex;
 				//o.uv.x += _MainTex_ST.x;
 				//o.uv.y += _MainTex_ST.y;
 				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
 				o.uv1 = TRANSFORM_TEX(v.uv, _MainTex1);
 				o.uv2 = TRANSFORM_TEX(v.uv, _MainTex2);
 				o.uv3 = TRANSFORM_TEX(v.uv, _MainTex3);
 				return o;

			}

			half4 frag (VS_Output input) : COLOR
			{
				half4 PowerCol;
 				half4 baseColor;
				
				float2 Line1_uv;
 				float2 Line2_uv;
 				
 				Line1_uv.x = input.uv2.x;
 				Line1_uv.y = (input.uv2.y - (_Mask - 0.03)) / 0.03;
 					
 				Line2_uv.x = input.uv3.x;
 				Line2_uv.y = (input.uv3.y - (_Mask - 0.03)) / 0.03;

 				half4 TexColor1 = tex2D(_MainTex2, Line1_uv) * _MainColor2;
 				half4 TexColor2 = tex2D(_MainTex3, Line2_uv) * _MainColor3;
 				half4 TexColor3 = tex2D(_MainTex, input.uv);
 				half4 TexColor4 = tex2D(_MainTex1, input.uv1);
				

				baseColor.rgb = ((TexColor3.rgb * TexColor3.a) + (TexColor4.rgb * (1 - TexColor3.a)));
				baseColor.a = 1;
 				if(input.uv.y > (_Mask * _MainTex_ST.y)  + _MainTex_ST.w)
 				{
 					baseColor.a = 0;
 				}
				if(input.uv.y <= (_Mask * _MainTex_ST.y)  + _MainTex_ST.w && input.uv.y > (_Mask * _MainTex_ST.y)  + _MainTex_ST.w - 0.05)
				{
					//float LinePercent = ((input.uv2.y - _MainTex2_ST.w - (_Mask - 0.03)) / 0.03); 
 					baseColor.rgb = (TexColor1.rgb * TexColor1.a) + (TexColor2.rgb * (1 - TexColor1.a));
 					baseColor.a = TexColor1.a + TexColor2.a;
					baseColor.rgb += TexColor3.rgb * (1 - baseColor.a);
					baseColor.a += TexColor3.a * smoothstep(0,1,((_Mask * _MainTex_ST.y) + _MainTex_ST.w - input.uv.y - 0.01) / 0.039);
					baseColor.rgb += TexColor4.rgb * (1 - baseColor.a);
					baseColor.a += TexColor4.a * smoothstep(0,1,((_Mask * _MainTex_ST.y) + _MainTex_ST.w - input.uv.y- 0.01) / 0.039);

				}
 				return baseColor;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
