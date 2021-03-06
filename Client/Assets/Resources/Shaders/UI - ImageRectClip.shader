// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "UI/ImageRectClip"
{
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
		_LimitRect("Limit Rect Area", Color) = (0.1, 0.1, 0.3, 0.3)
	}

	SubShader
	{
		LOD 200

		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}

		Pass
		{
			Cull Off
			Lighting Off
			ZWrite Off
			Offset -1, -1
			Fog { Mode Off }
			ColorMask RGB
			Blend SrcAlpha OneMinusSrcAlpha
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _LimitRect;

			struct appdata_t
			{
				float4 vertex : POSITION;
				half4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : POSITION;
				half4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				float2 worldPos : TEXCOORD1;
			};

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
				o.texcoord = v.texcoord;
				o.worldPos = TRANSFORM_TEX(v.vertex.xy, _MainTex);
				return o;
			}

			half4 frag (v2f IN) : COLOR
			{
				// Sample the texture
				half4 col = tex2D(_MainTex, IN.texcoord) * IN.color;

				//float2 factor = abs(IN.worldPos);
				//float val = 1.0 - max(factor.x, factor.y);

				// Option 1: 'if' statement
				//if (val < 0.0) col.a = 0.0;

				// Option 2: no 'if' statement -- may be faster on some devices
				//col.a *= ceil(clamp(val, 0.0, 1.0));

				if ((IN.texcoord.x > _LimitRect.z) && (IN.texcoord.y > _LimitRect.w) && (IN.texcoord.x < _LimitRect.x) && (IN.texcoord.y < _LimitRect.y)) 
					col.a = 0.0;
				return col;
			}
			ENDCG
		}
	}
}