Shader "Hidden/BlurAndFlares" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "" { }
 _NonBlurredTex ("Base (RGB)", 2D) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 12069
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 unity_ColorSpaceLuminance;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_2;
  gl_FragData[0] = (color_1 / (1.5 + dot (color_1.xyz, unity_ColorSpaceLuminance.xyz)));
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump vec4 _Offsets;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _StretchWidth;
uniform 	mediump vec2 _Threshhold;
uniform 	mediump float _Saturation;
uniform 	mediump vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out vec4 undefined;
out mediump vec2 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump vec4 _Offsets;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _StretchWidth;
uniform 	mediump vec2 _Threshhold;
uniform 	mediump float _Saturation;
uniform 	mediump vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 t10_0;
mediump float t16_1;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_1 = dot(t10_0.xyz, unity_ColorSpaceLuminance.xyz);
    t16_1 = t16_1 + 1.5;
    SV_Target0 = t10_0 / vec4(t16_1);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 67396
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _Offsets;
uniform mediump float _StretchWidth;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
varying mediump vec2 xlv_TEXCOORD0_2;
varying mediump vec2 xlv_TEXCOORD0_3;
varying mediump vec2 xlv_TEXCOORD0_4;
varying mediump vec2 xlv_TEXCOORD0_5;
varying mediump vec2 xlv_TEXCOORD0_6;
void main ()
{
  mediump float tmpvar_1;
  tmpvar_1 = (_StretchWidth * 2.0);
  mediump float tmpvar_2;
  tmpvar_2 = (_StretchWidth * 4.0);
  mediump float tmpvar_3;
  tmpvar_3 = (_StretchWidth * 6.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD0_1 = (_glesMultiTexCoord0.xy + (tmpvar_1 * _Offsets.xy));
  xlv_TEXCOORD0_2 = (_glesMultiTexCoord0.xy - (tmpvar_1 * _Offsets.xy));
  xlv_TEXCOORD0_3 = (_glesMultiTexCoord0.xy + (tmpvar_2 * _Offsets.xy));
  xlv_TEXCOORD0_4 = (_glesMultiTexCoord0.xy - (tmpvar_2 * _Offsets.xy));
  xlv_TEXCOORD0_5 = (_glesMultiTexCoord0.xy + (tmpvar_3 * _Offsets.xy));
  xlv_TEXCOORD0_6 = (_glesMultiTexCoord0.xy - (tmpvar_3 * _Offsets.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
varying mediump vec2 xlv_TEXCOORD0_2;
varying mediump vec2 xlv_TEXCOORD0_3;
varying mediump vec2 xlv_TEXCOORD0_4;
varying mediump vec2 xlv_TEXCOORD0_5;
varying mediump vec2 xlv_TEXCOORD0_6;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0_1);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0_3);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0_4);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0_5);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_6);
  mediump vec4 tmpvar_9;
  tmpvar_9 = max (max (max (color_1, tmpvar_3), max (tmpvar_4, tmpvar_5)), max (max (tmpvar_6, tmpvar_7), tmpvar_8));
  color_1 = tmpvar_9;
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump vec4 _Offsets;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _StretchWidth;
uniform 	mediump vec2 _Threshhold;
uniform 	mediump float _Saturation;
uniform 	mediump vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out vec4 undefined;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
out mediump vec2 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
highp vec4 t0;
mediump vec4 t16_0;
mediump float t16_1;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    t16_1 = _StretchWidth + _StretchWidth;
    vs_TEXCOORD1.xy = vec2(t16_1) * _Offsets.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = (-vec2(t16_1)) * _Offsets.xy + in_TEXCOORD0.xy;
    t16_0 = vec4(_StretchWidth) * vec4(4.0, 4.0, 6.0, 6.0);
    vs_TEXCOORD3.xy = t16_0.xy * _Offsets.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.xy = (-t16_0.xy) * _Offsets.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD5.xy = t16_0.zw * _Offsets.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD6.xy = (-t16_0.zw) * _Offsets.xy + in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec2 vs_TEXCOORD4;
in mediump vec2 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 t16_0;
lowp vec4 t10_0;
lowp vec4 t10_1;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    t16_0 = max(t10_0, t10_1);
    t10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    t16_0 = max(t16_0, t10_1);
    t10_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    t16_0 = max(t16_0, t10_1);
    t10_1 = texture(_MainTex, vs_TEXCOORD4.xy);
    t16_0 = max(t16_0, t10_1);
    t10_1 = texture(_MainTex, vs_TEXCOORD5.xy);
    t16_0 = max(t16_0, t10_1);
    t10_1 = texture(_MainTex, vs_TEXCOORD6.xy);
    t16_0 = max(t16_0, t10_1);
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 136774
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _Offsets;
uniform mediump vec4 _MainTex_TexelSize;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
varying mediump vec2 xlv_TEXCOORD0_2;
varying mediump vec2 xlv_TEXCOORD0_3;
varying mediump vec2 xlv_TEXCOORD0_4;
varying mediump vec2 xlv_TEXCOORD0_5;
varying mediump vec2 xlv_TEXCOORD0_6;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = (0.5 * _MainTex_TexelSize.xy);
  mediump vec2 tmpvar_2;
  tmpvar_2 = (1.5 * _MainTex_TexelSize.xy);
  mediump vec2 tmpvar_3;
  tmpvar_3 = (2.5 * _MainTex_TexelSize.xy);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD0_1 = (_glesMultiTexCoord0.xy + (tmpvar_1 * _Offsets.xy));
  xlv_TEXCOORD0_2 = (_glesMultiTexCoord0.xy - (tmpvar_1 * _Offsets.xy));
  xlv_TEXCOORD0_3 = (_glesMultiTexCoord0.xy + (tmpvar_2 * _Offsets.xy));
  xlv_TEXCOORD0_4 = (_glesMultiTexCoord0.xy - (tmpvar_2 * _Offsets.xy));
  xlv_TEXCOORD0_5 = (_glesMultiTexCoord0.xy + (tmpvar_3 * _Offsets.xy));
  xlv_TEXCOORD0_6 = (_glesMultiTexCoord0.xy - (tmpvar_3 * _Offsets.xy));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 unity_ColorSpaceLuminance;
uniform mediump vec4 _TintColor;
uniform mediump vec2 _Threshhold;
uniform mediump float _Saturation;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
varying mediump vec2 xlv_TEXCOORD0_2;
varying mediump vec2 xlv_TEXCOORD0_3;
varying mediump vec2 xlv_TEXCOORD0_4;
varying mediump vec2 xlv_TEXCOORD0_5;
varying mediump vec2 xlv_TEXCOORD0_6;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0_1);
  color_1 = (color_1 + tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0_2);
  color_1 = (color_1 + tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0_3);
  color_1 = (color_1 + tmpvar_5);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0_4);
  color_1 = (color_1 + tmpvar_6);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0_5);
  color_1 = (color_1 + tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_6);
  color_1 = (color_1 + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = max (((color_1 / 7.0) - _Threshhold.xxxx), vec4(0.0, 0.0, 0.0, 0.0));
  color_1.w = tmpvar_9.w;
  color_1.xyz = (mix (vec3(dot (tmpvar_9.xyz, unity_ColorSpaceLuminance.xyz)), tmpvar_9.xyz, vec3(_Saturation)) * _TintColor.xyz);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump vec4 _Offsets;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _StretchWidth;
uniform 	mediump vec2 _Threshhold;
uniform 	mediump float _Saturation;
uniform 	mediump vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out vec4 undefined;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
out mediump vec2 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
highp vec4 t0;
mediump vec2 t16_1;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    t16_1.xy = _Offsets.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = t16_1.xy * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = (-t16_1.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD3.xy = t16_1.xy * vec2(1.5, 1.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD4.xy = (-t16_1.xy) * vec2(1.5, 1.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD5.xy = t16_1.xy * vec2(2.5, 2.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD6.xy = (-t16_1.xy) * vec2(2.5, 2.5) + in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump vec4 _Offsets;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _StretchWidth;
uniform 	mediump vec2 _Threshhold;
uniform 	mediump float _Saturation;
uniform 	mediump vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec2 vs_TEXCOORD4;
in mediump vec2 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 t16_0;
lowp vec4 t10_0;
lowp vec4 t10_1;
mediump vec3 t16_2;
mediump vec3 t16_5;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    t16_0 = t10_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    t16_0 = t16_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    t16_0 = t16_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD4.xy);
    t16_0 = t16_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD5.xy);
    t16_0 = t16_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD6.xy);
    t16_0 = t16_0 + t10_1;
    t16_0 = t16_0 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + (-_Threshhold.xxyx.yyyy);
    t16_0 = max(t16_0, vec4(0.0, 0.0, 0.0, 0.0));
    t16_2.x = dot(t16_0.xyz, unity_ColorSpaceLuminance.xyz);
    t16_5.xyz = t16_0.xyz + (-t16_2.xxx);
    SV_Target0.w = t16_0.w;
    t16_2.xyz = vec3(vec3(_Saturation, _Saturation, _Saturation)) * t16_5.xyz + t16_2.xxx;
    SV_Target0.xyz = t16_2.xyz * _TintColor.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 207948
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _Offsets;
uniform mediump vec4 _MainTex_TexelSize;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
varying mediump vec2 xlv_TEXCOORD0_2;
varying mediump vec2 xlv_TEXCOORD0_3;
varying mediump vec2 xlv_TEXCOORD0_4;
varying mediump vec2 xlv_TEXCOORD0_5;
varying mediump vec2 xlv_TEXCOORD0_6;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = (0.5 * _MainTex_TexelSize.xy);
  mediump vec2 tmpvar_2;
  tmpvar_2 = (1.5 * _MainTex_TexelSize.xy);
  mediump vec2 tmpvar_3;
  tmpvar_3 = (2.5 * _MainTex_TexelSize.xy);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD0_1 = (_glesMultiTexCoord0.xy + (tmpvar_1 * _Offsets.xy));
  xlv_TEXCOORD0_2 = (_glesMultiTexCoord0.xy - (tmpvar_1 * _Offsets.xy));
  xlv_TEXCOORD0_3 = (_glesMultiTexCoord0.xy + (tmpvar_2 * _Offsets.xy));
  xlv_TEXCOORD0_4 = (_glesMultiTexCoord0.xy - (tmpvar_2 * _Offsets.xy));
  xlv_TEXCOORD0_5 = (_glesMultiTexCoord0.xy + (tmpvar_3 * _Offsets.xy));
  xlv_TEXCOORD0_6 = (_glesMultiTexCoord0.xy - (tmpvar_3 * _Offsets.xy));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 unity_ColorSpaceLuminance;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
varying mediump vec2 xlv_TEXCOORD0_2;
varying mediump vec2 xlv_TEXCOORD0_3;
varying mediump vec2 xlv_TEXCOORD0_4;
varying mediump vec2 xlv_TEXCOORD0_5;
varying mediump vec2 xlv_TEXCOORD0_6;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0_1);
  color_1 = (color_1 + tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0_2);
  color_1 = (color_1 + tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0_3);
  color_1 = (color_1 + tmpvar_5);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0_4);
  color_1 = (color_1 + tmpvar_6);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0_5);
  color_1 = (color_1 + tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_6);
  color_1 = (color_1 + tmpvar_8);
  gl_FragData[0] = (color_1 / (7.5 + dot (color_1.xyz, unity_ColorSpaceLuminance.xyz)));
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump vec4 _Offsets;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _StretchWidth;
uniform 	mediump vec2 _Threshhold;
uniform 	mediump float _Saturation;
uniform 	mediump vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out vec4 undefined;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
out mediump vec2 vs_TEXCOORD5;
out mediump vec2 vs_TEXCOORD6;
highp vec4 t0;
mediump vec2 t16_1;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    t16_1.xy = _Offsets.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = t16_1.xy * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = (-t16_1.xy) * vec2(0.5, 0.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD3.xy = t16_1.xy * vec2(1.5, 1.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD4.xy = (-t16_1.xy) * vec2(1.5, 1.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD5.xy = t16_1.xy * vec2(2.5, 2.5) + in_TEXCOORD0.xy;
    vs_TEXCOORD6.xy = (-t16_1.xy) * vec2(2.5, 2.5) + in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump vec4 _Offsets;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _StretchWidth;
uniform 	mediump vec2 _Threshhold;
uniform 	mediump float _Saturation;
uniform 	mediump vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec2 vs_TEXCOORD4;
in mediump vec2 vs_TEXCOORD5;
in mediump vec2 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 t16_0;
lowp vec4 t10_0;
lowp vec4 t10_1;
mediump float t16_2;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    t16_0 = t10_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    t16_0 = t16_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    t16_0 = t16_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD4.xy);
    t16_0 = t16_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD5.xy);
    t16_0 = t16_0 + t10_1;
    t10_1 = texture(_MainTex, vs_TEXCOORD6.xy);
    t16_0 = t16_0 + t10_1;
    t16_2 = dot(t16_0.xyz, unity_ColorSpaceLuminance.xyz);
    t16_2 = t16_2 + 7.5;
    SV_Target0 = t16_0 / vec4(t16_2);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 292851
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _Offsets;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_1;
  tmpvar_1 = (_Offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0));
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xyxy + tmpvar_1);
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xyxy + (tmpvar_1 * 2.0));
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xyxy + (tmpvar_1 * 3.0));
  xlv_TEXCOORD4 = (_glesMultiTexCoord0.xyxy + (tmpvar_1 * 5.0));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = (0.225 * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = (color_1 + (0.15 * tmpvar_3));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  color_1 = (color_1 + (0.15 * tmpvar_4));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  color_1 = (color_1 + (0.11 * tmpvar_5));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.zw);
  color_1 = (color_1 + (0.11 * tmpvar_6));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  color_1 = (color_1 + (0.075 * tmpvar_7));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD3.zw);
  color_1 = (color_1 + (0.075 * tmpvar_8));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  color_1 = (color_1 + (0.0525 * tmpvar_9));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD4.zw);
  color_1 = (color_1 + (0.0525 * tmpvar_10));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	mediump vec4 _Offsets;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _StretchWidth;
uniform 	mediump vec2 _Threshhold;
uniform 	mediump float _Saturation;
uniform 	mediump vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out vec4 undefined;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = _Offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = _Offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD3 = _Offsets.xyxy * vec4(3.0, 3.0, -3.0, -3.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD4 = _Offsets.xyxy * vec4(5.0, 5.0, -5.0, -5.0) + in_TEXCOORD0.xyxy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 t16_0;
lowp vec4 t10_0;
lowp vec4 t10_1;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    t16_0 = t10_0 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_0 = t10_1 * vec4(0.224999994, 0.224999994, 0.224999994, 0.224999994) + t16_0;
    t10_1 = texture(_MainTex, vs_TEXCOORD1.zw);
    t16_0 = t10_1 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + t16_0;
    t10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    t16_0 = t10_1 * vec4(0.109999999, 0.109999999, 0.109999999, 0.109999999) + t16_0;
    t10_1 = texture(_MainTex, vs_TEXCOORD2.zw);
    t16_0 = t10_1 * vec4(0.109999999, 0.109999999, 0.109999999, 0.109999999) + t16_0;
    t10_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    t16_0 = t10_1 * vec4(0.075000003, 0.075000003, 0.075000003, 0.075000003) + t16_0;
    t10_1 = texture(_MainTex, vs_TEXCOORD3.zw);
    t16_0 = t10_1 * vec4(0.075000003, 0.075000003, 0.075000003, 0.075000003) + t16_0;
    t10_1 = texture(_MainTex, vs_TEXCOORD4.xy);
    t16_0 = t10_1 * vec4(0.0524999984, 0.0524999984, 0.0524999984, 0.0524999984) + t16_0;
    t10_1 = texture(_MainTex, vs_TEXCOORD4.zw);
    t16_0 = t10_1 * vec4(0.0524999984, 0.0524999984, 0.0524999984, 0.0524999984) + t16_0;
    SV_Target0 = t16_0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
Fallback Off
}