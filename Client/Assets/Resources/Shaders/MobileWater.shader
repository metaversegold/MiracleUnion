// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "MobileWater/MobileWater" {
Properties {
    _Color ("Water Colour", Color) = (1,1,1,1)
	_MainTex ("Water Texture", 2D) = ""
}

 

Category {
	Tags {"Queue"="Transparent" "IgnoreProjector"="True"}
    ZWrite Off
    Blend SrcAlpha OneMinusSrcAlpha 

 SubShader {
 	Pass {
        GLSLPROGRAM
        varying mediump vec2 uv;
        #ifdef VERTEX
        uniform mediump vec4 _MainTex_ST;
        void main() {
			gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            uv = gl_MultiTexCoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        }
		#endif
        #ifdef FRAGMENT
        uniform lowp sampler2D _MainTex;
        uniform lowp vec4 _Color;
        void main() {
            gl_FragColor = texture2D(_MainTex, uv) * _Color;
        }

        #endif      
        ENDGLSL
    }
 }

 	SubShader
	{
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 100
	
		Blend SrcAlpha One
		AlphaTest Greater 0.1
		ColorMask RGB
		Cull Off Lighting Off ZWrite Off Fog { Mode Off }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				fixed4 color : COLOR;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				fixed4 color : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 color = _Color;

				fixed4 texColor = tex2D(_MainTex, i.uv);
				color *= texColor;
		
				return color;
			}
			ENDCG
		}
	}

}

 

}