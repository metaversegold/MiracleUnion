// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

#include "UnityCG.cginc"
struct VS_Input {
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 uv : TEXCOORD0;
};

struct VS_Output {
	float4 position : SV_POSITION;
	half2 uv : TEXCOORD0;
	half3 viewRelfW : TEXCOORD1;
	half3 normalV : TEXCOORD2;
};

fixed4 _Color;
fixed4 _ReflectColor;
sampler2D _MainTex;
samplerCUBE _Cube;

half _SpecPow;
fixed4 _SpecColor1;
half _TimeScale1;
sampler2D _ViewDirTex1;
			
half _LightScale;
fixed4 _SpecColor2;
half _TimeScale2;
sampler2D _ViewDirTex2;

half4x4 _RotateMatrix;
half4x4 _Wolrd2HV;

VS_Output vs_main(VS_Input v)
{
	VS_Output o;
	UNITY_INITIALIZE_OUTPUT(VS_Output, o)
	o.position = UnityObjectToClipPos(v.vertex);
	o.uv = v.uv;
	half3 reflectDir = reflect(normalize(ObjSpaceViewDir(v.vertex)), v.normal);
	o.viewRelfW = mul(mul(_RotateMatrix, UNITY_MATRIX_MV), half4(reflectDir, 0)).xyz;
	return o;
}

VS_Output vs_main_normal(VS_Input v)
{
	VS_Output o;
	UNITY_INITIALIZE_OUTPUT(VS_Output, o)
	o.position = UnityObjectToClipPos(v.vertex);
	o.uv = v.uv;
	half3 reflectDir = reflect(normalize(ObjSpaceViewDir(v.vertex)), v.normal);
	o.viewRelfW = mul(mul(_RotateMatrix, UNITY_MATRIX_MV), half4(reflectDir, 0)).xyz;
	o.normalV = mul(mul(_Wolrd2HV, unity_ObjectToWorld), half4(v.normal, 0)).xyz;
	return o;
}

fixed4 ps_BaseColor(VS_Output i) : COLOR
{
	fixed4 baseColor = tex2D(_MainTex, i.uv) * _Color;
	fixed3 reflColor = texCUBE(_Cube, i.viewRelfW).rgb * _ReflectColor.rgb;
	return fixed4(baseColor.rgb + reflColor, baseColor.a);
}

fixed4 ps_SpecColor1(VS_Output i) : COLOR
{
	fixed4 baseColor = tex2D(_MainTex, i.uv) * _Color;
	fixed3 reflColor = texCUBE(_Cube, i.viewRelfW).rgb * _ReflectColor.rgb;
	baseColor.rgb += reflColor;

	fixed3 normalV = normalize(i.normalV);

	fixed3 viewDirInViewSpace = tex2D(_ViewDirTex1, half2(_Time.x * _TimeScale1, 0)).xyz * 2 - 1;
	viewDirInViewSpace.y = 0;
	fixed reflection = dot(normalize(viewDirInViewSpace), normalV);
	fixed specPow = 0;
	if (reflection > 0)
		specPow = pow(reflection, _SpecPow);	
	fixed4 layerColor1 = _SpecColor1 * specPow;
					
	return fixed4((baseColor + layerColor1).rgb, baseColor.a);
}

fixed4 ps_SpecColor2(VS_Output i) : COLOR
{
	fixed4 baseColor = tex2D(_MainTex, i.uv) * _Color;
	fixed3 reflColor = texCUBE(_Cube, i.viewRelfW).rgb * _ReflectColor.rgb;
	baseColor.rgb += reflColor;

	fixed3 normalV = normalize(i.normalV);

	fixed3 viewDirInViewSpace = tex2D(_ViewDirTex2, half2(_Time.x * _TimeScale2, 0)).xyz * 2 - 1;
	fixed reflection = dot(normalize(viewDirInViewSpace), normalV);
	fixed specPow = max(0, reflection * _LightScale - _LightScale + 1);
	fixed4 layerColor2 =  _SpecColor2 * specPow;
					
	return fixed4((baseColor + layerColor2).rgb, baseColor.a);
}

fixed4 ps_SpecColor1N2(VS_Output i) : COLOR
{
	fixed4 baseColor = tex2D(_MainTex, i.uv) * _Color;
	fixed3 reflColor = texCUBE(_Cube, i.viewRelfW).rgb * _ReflectColor.rgb;
	baseColor.rgb += reflColor;

	fixed3 normalV = normalize(i.normalV);

	fixed3 viewDirInViewSpace = tex2D(_ViewDirTex1, half2(_Time.x * _TimeScale1, 0)).xyz * 2 - 1;
	fixed reflection = dot(normalize(viewDirInViewSpace), normalV);
	fixed specPow = 0;
	if (reflection > 0)
		specPow = pow(reflection, _SpecPow);	
	fixed4 layerColor1 = _SpecColor1 * specPow;

	viewDirInViewSpace = tex2D(_ViewDirTex2, half2(_Time.x * _TimeScale2, 0)).xyz * 2 - 1;
	reflection = dot(normalize(viewDirInViewSpace), normalV);
	specPow = max(0, reflection * _LightScale - _LightScale + 1);
	fixed4 layerColor2 =  _SpecColor2 * specPow;
					
	return fixed4((baseColor + layerColor1 + layerColor2).rgb, baseColor.a);
}