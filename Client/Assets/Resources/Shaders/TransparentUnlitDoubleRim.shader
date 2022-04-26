// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/Transparent/UnlitDoubleRim" {
	Properties {
		_Color ("MainColor (RGB) Opacity(A)", Color) = (1, 1, 1, 0.5)
		_RimColor ("Rim Color", Color) = (0.5,0.5,0.5,0.5)
		_RimPower ("Rim Power", Range(0.0,10.0)) = 2.5
		_InnerColor ("Inner Color", Color) = (0.5,0.5,0.5,0.5)
		_InnerColorPower ("Inner Color Power", Range(0.0,10.0)) = 0.5
	}
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
		LOD 150
		Cull Back
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
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 normal : TEXCOORD0;
				float4 viewDir : TEXCOORD1;
			};

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = mul(unity_ObjectToWorld, float4(v.normal, 1));
				o.viewDir = float4(WorldSpaceViewDir(v.vertex), 1);
				return o;
			}

			fixed4 _Color;
			fixed4 _RimColor;
			half _RimPower;
			half _InnerColorPower;
			fixed4 _InnerColor;
			
			fixed4 frag (v2f i) : COLOR
			{
				half3 normalV = i.normal.xyz / i.normal.w;
				half3 viewDirV = i.viewDir.xyz / i.viewDir.w;
				half rim = 1 - saturate( dot(normalize(normalV), normalize(viewDirV)) );
				fixed4 output = _Color;
				fixed3 rimColor = _RimColor.rgb * pow(rim, _RimPower) + 2 * _InnerColor.rgb * pow(rim, _InnerColorPower);
				half rimAlpha = Luminance(rimColor);
				output = lerp(output, fixed4(rimColor, rimAlpha), rimAlpha);
				return output;
			}
			ENDCG
		}
	
	}
	
	Fallback "Transparent/Cutout/VertexLit"
}
