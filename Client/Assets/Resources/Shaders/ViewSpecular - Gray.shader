// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/ViewSpecular - Gray" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Tint ("Tint Color", Color) = (1, 1, 1, 1)
		_Smoothness ("Smoothness", Range(0, 1)) = 0.9
		_x ("x", Float) = 0.2
		_y ("y", Float) = 0.2
		_Cut ("Alpha Cut", Float) = 0.01
		_Spec ("Specular Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue"="Transparent" }
		LOD 200
		Blend SrcAlpha OneMinusSrcAlpha

		Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord0 : TEXCOORD0;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				float4 uv : TEXCOORD0;
				float4 normalW : TEXCOORD1;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord0.xy, 0, 0 );
				o.normalW = mul( unity_ObjectToWorld, float4(v.normal, 0) );
				return o;
			}

            uniform sampler2D _MainTex;

			half _Smoothness;
			half _x;
			half _y;
			half _Cut;
			half4 _Spec;
			half4 _Tint;

            half4 frag(v2f i) : SV_Target 
			{
				half4 color = tex2D(_MainTex, i.uv.xy) * _Tint;
                clip(color.a - _Cut);
				half3 normal = normalize(i.normalW.xyz);
				half3 toEye = half3(0, 0, -1);
				half3 refDir = reflect(toEye, normal);

				half rdotl = dot(refDir, normalize(half3(_x, _y, 1)));
				half specular = smoothstep(_Smoothness, 1, rdotl);
				half3 specColor = _Spec.rgb * 4 * (specular * specular * specular * specular * specular) * _Spec.a;
				return half4(Luminance(color.rgb + specColor).xxx, color.a);
            }
            ENDCG
        }
	} 
	FallBack "Diffuse"
}
