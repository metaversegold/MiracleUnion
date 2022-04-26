Shader "T4MShaders/ShaderModel2/Diffuse/T4M 4 Textures" {
Properties {
 _Splat0 ("Layer 1", 2D) = "white" { }
 _Splat1 ("Layer 2", 2D) = "white" { }
 _Splat2 ("Layer 3", 2D) = "white" { }
 _Splat3 ("Layer 4", 2D) = "white" { }
 _Control ("Control (RGBA)", 2D) = "white" { }
 _MainTex ("Never Used", 2D) = "white" { }
}
SubShader { 
 Tags { "RenderType"="Opaque" "SplatCount"="4" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" "SplatCount"="4" }
  GpuProgramID 10982
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_5;
  v_5.x = _World2Object[0].x;
  v_5.y = _World2Object[1].x;
  v_5.z = _World2Object[2].x;
  v_5.w = _World2Object[3].x;
  highp vec4 v_6;
  v_6.x = _World2Object[0].y;
  v_6.y = _World2Object[1].y;
  v_6.z = _World2Object[2].y;
  v_6.w = _World2Object[3].y;
  highp vec4 v_7;
  v_7.x = _World2Object[0].z;
  v_7.y = _World2Object[1].z;
  v_7.z = _World2Object[2].z;
  v_7.w = _World2Object[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _glesNormal.x)
   + 
    (v_6.xyz * _glesNormal.y)
  ) + (v_7.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_8;
  tmpvar_4 = worldNormal_1;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldNormal_1;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  x1_12.x = dot (unity_SHAr, normal_10);
  x1_12.y = dot (unity_SHAg, normal_10);
  x1_12.z = dot (unity_SHAb, normal_10);
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_10.xyzz * normal_10.yzzx);
  x2_11.x = dot (unity_SHBr, tmpvar_13);
  x2_11.y = dot (unity_SHBg, tmpvar_13);
  x2_11.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = ((x2_11 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )) + x1_12);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec3 tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_7 = (((
    (texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_8.x)
   + 
    (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_8.y)
  ) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_8.z)) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_8.w));
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp vec4 c_10;
  lowp float diff_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_11 = tmpvar_12;
  c_10.xyz = ((tmpvar_7 * tmpvar_1) * diff_11);
  c_10.w = 0.0;
  c_9.w = c_10.w;
  c_9.xyz = (c_10.xyz + (tmpvar_7 * xlv_TEXCOORD5));
  c_3.xyz = c_9.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
highp vec4 t0;
highp vec3 t1;
mediump vec4 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
highp float t12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_1 = t0.yzzx * t0.xyzz;
    t16_3.x = dot(unity_SHBr, t16_1);
    t16_3.y = dot(unity_SHBg, t16_1);
    t16_3.z = dot(unity_SHBb, t16_1);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_3.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    vs_TEXCOORD5.xyz = t16_2.xyz + t16_3.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump vec3 t16_6;
mediump float t16_26;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = t10_4.xyz * _LightColor0.xyz;
    t16_6.xyz = t10_4.xyz * vs_TEXCOORD5.xyz;
    t16_26 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
    t16_26 = max(t16_26, 0.0);
    t16_5.xyz = t16_5.xyz * vec3(t16_26) + t16_6.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  highp vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  highp vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_4 = worldNormal_1;
  tmpvar_5.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_1 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, tmpvar_1.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (2.0 * tmpvar_4.xyz);
  lowp vec4 c_6;
  c_6.w = 0.0;
  c_6.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_3.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_3.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_3.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_3.w)) * tmpvar_5);
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
lowp vec3 t10_5;
mediump vec3 t16_6;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    t10_5.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t16_6.xyz = t10_4.xyz * t10_5.xyz;
    SV_Target0.xyz = t16_6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec4 v_7;
  v_7.x = _World2Object[0].x;
  v_7.y = _World2Object[1].x;
  v_7.z = _World2Object[2].x;
  v_7.w = _World2Object[3].x;
  highp vec4 v_8;
  v_8.x = _World2Object[0].y;
  v_8.y = _World2Object[1].y;
  v_8.z = _World2Object[2].y;
  v_8.w = _World2Object[3].y;
  highp vec4 v_9;
  v_9.x = _World2Object[0].z;
  v_9.y = _World2Object[1].z;
  v_9.z = _World2Object[2].z;
  v_9.w = _World2Object[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_4 = worldNormal_1;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_1;
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  x1_14.x = dot (unity_SHAr, normal_12);
  x1_14.y = dot (unity_SHAg, normal_12);
  x1_14.z = dot (unity_SHAb, normal_12);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (normal_12.xyzz * normal_12.yzzx);
  x2_13.x = dot (unity_SHBr, tmpvar_15);
  x2_13.y = dot (unity_SHBg, tmpvar_15);
  x2_13.z = dot (unity_SHBb, tmpvar_15);
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 normal_21;
  normal_21 = worldNormal_1;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  ndotl_23 = (tmpvar_25 * normal_21.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * normal_21.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * normal_21.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(lengthSq_24)));
  ndotl_23 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (lengthSq_24 * lightAttenSq_20)
  ))));
  col_22 = (lightColor0_16 * tmpvar_29.x);
  col_22 = (col_22 + (lightColor1_17 * tmpvar_29.y));
  col_22 = (col_22 + (lightColor2_18 * tmpvar_29.z));
  col_22 = (col_22 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_5 = (((x2_13 + 
    (unity_SHC.xyz * ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y)))
  ) + x1_14) + col_22);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec3 tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_7 = (((
    (texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_8.x)
   + 
    (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_8.y)
  ) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_8.z)) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_8.w));
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp vec4 c_10;
  lowp float diff_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_11 = tmpvar_12;
  c_10.xyz = ((tmpvar_7 * tmpvar_1) * diff_11);
  c_10.w = 0.0;
  c_9.w = c_10.w;
  c_9.xyz = (c_10.xyz + (tmpvar_7 * xlv_TEXCOORD5));
  c_3.xyz = c_9.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
highp vec4 t0;
highp vec4 t1;
mediump vec3 t16_2;
highp vec4 t3;
mediump vec4 t16_3;
highp vec4 t4;
mediump vec3 t16_4;
highp vec4 t5;
highp float t18;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t18 = dot(t0.xyz, t0.xyz);
    t18 = inversesqrt(t18);
    t0.xyz = vec3(t18) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD4.xyz = t1.xyz;
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_3 = t0.yzzx * t0.xyzz;
    t16_4.x = dot(unity_SHBr, t16_3);
    t16_4.y = dot(unity_SHBg, t16_3);
    t16_4.z = dot(unity_SHBb, t16_3);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_4.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    t16_2.xyz = t16_2.xyz + t16_3.xyz;
    t3 = (-t1.yyyy) + unity_4LightPosY0;
    t4 = t0.yyyy * t3;
    t3 = t3 * t3;
    t5 = (-t1.xxxx) + unity_4LightPosX0;
    t1 = (-t1.zzzz) + unity_4LightPosZ0;
    t4 = t5 * t0.xxxx + t4;
    t0 = t1 * t0.zzzz + t4;
    t3 = t5 * t5 + t3;
    t1 = t1 * t1 + t3;
    t3 = inversesqrt(t1);
    t1 = t1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    t1 = vec4(1.0, 1.0, 1.0, 1.0) / t1;
    t0 = t0 * t3;
    t0 = max(t0, vec4(0.0, 0.0, 0.0, 0.0));
    t0 = t1 * t0;
    t1.xyz = t0.yyy * unity_LightColor[1].xyz;
    t1.xyz = unity_LightColor[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = unity_LightColor[2].xyz * t0.zzz + t1.xyz;
    t0.xyz = unity_LightColor[3].xyz * t0.www + t0.xyz;
    t0.xyz = t0.xyz + t16_2.xyz;
    vs_TEXCOORD5.xyz = t0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump vec3 t16_6;
mediump float t16_26;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = t10_4.xyz * _LightColor0.xyz;
    t16_6.xyz = t10_4.xyz * vs_TEXCOORD5.xyz;
    t16_26 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
    t16_26 = max(t16_26, 0.0);
    t16_5.xyz = t16_5.xyz * vec3(t16_26) + t16_6.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  highp vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  highp vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_5 = worldNormal_1;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = worldNormal_1;
  mediump vec4 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  x1_13.x = dot (unity_SHAr, normal_11);
  x1_13.y = dot (unity_SHAg, normal_11);
  x1_13.z = dot (unity_SHAb, normal_11);
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_11.xyzz * normal_11.yzzx);
  x2_12.x = dot (unity_SHBr, tmpvar_14);
  x2_12.y = dot (unity_SHBg, tmpvar_14);
  x2_12.z = dot (unity_SHBb, tmpvar_14);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = ((x2_12 + (unity_SHC.xyz * 
    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
  )) + x1_13);
  xlv_TEXCOORD6 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec3 tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_7 = (((
    (texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_8.x)
   + 
    (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_8.y)
  ) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_8.z)) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_8.w));
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp vec4 c_10;
  lowp float diff_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_11 = tmpvar_12;
  c_10.xyz = ((tmpvar_7 * tmpvar_1) * diff_11);
  c_10.w = 0.0;
  c_9.w = c_10.w;
  c_9.xyz = (c_10.xyz + (tmpvar_7 * xlv_TEXCOORD5));
  highp float tmpvar_13;
  tmpvar_13 = clamp (xlv_TEXCOORD6, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_9.xyz, vec3(tmpvar_13));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
highp vec4 t0;
highp vec3 t1;
mediump vec4 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
highp float t12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD6 = t0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_1 = t0.yzzx * t0.xyzz;
    t16_3.x = dot(unity_SHBr, t16_1);
    t16_3.y = dot(unity_SHBg, t16_1);
    t16_3.z = dot(unity_SHBb, t16_1);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_3.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    vs_TEXCOORD5.xyz = t16_2.xyz + t16_3.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump vec3 t16_6;
highp float t21;
mediump float t16_26;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = t10_4.xyz * _LightColor0.xyz;
    t16_6.xyz = t10_4.xyz * vs_TEXCOORD5.xyz;
    t16_26 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
    t16_26 = max(t16_26, 0.0);
    t16_5.xyz = t16_5.xyz * vec3(t16_26) + t16_6.xyz;
    t16_0.xyz = t16_5.xyz + (-unity_FogColor.xyz);
    t21 = vs_TEXCOORD6;
    t21 = clamp(t21, 0.0, 1.0);
    t0.xyz = vec3(t21) * t16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_7;
  v_7.x = _World2Object[0].x;
  v_7.y = _World2Object[1].x;
  v_7.z = _World2Object[2].x;
  v_7.w = _World2Object[3].x;
  highp vec4 v_8;
  v_8.x = _World2Object[0].y;
  v_8.y = _World2Object[1].y;
  v_8.z = _World2Object[2].y;
  v_8.w = _World2Object[3].y;
  highp vec4 v_9;
  v_9.x = _World2Object[0].z;
  v_9.y = _World2Object[1].z;
  v_9.z = _World2Object[2].z;
  v_9.w = _World2Object[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_5 = worldNormal_1;
  tmpvar_6.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_1 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, tmpvar_1.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (2.0 * tmpvar_4.xyz);
  lowp vec4 c_6;
  c_6.w = 0.0;
  c_6.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_3.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_3.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_3.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_3.w)) * tmpvar_5);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD6, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_6.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD6 = t0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
lowp vec3 t10_5;
highp float t18;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    t10_5.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t16_0.xyz = t10_4.xyz * t10_5.xyz + (-unity_FogColor.xyz);
    t18 = vs_TEXCOORD6;
    t18 = clamp(t18, 0.0, 1.0);
    t0.xyz = vec3(t18) * t16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  highp vec4 v_8;
  v_8.x = _World2Object[0].x;
  v_8.y = _World2Object[1].x;
  v_8.z = _World2Object[2].x;
  v_8.w = _World2Object[3].x;
  highp vec4 v_9;
  v_9.x = _World2Object[0].y;
  v_9.y = _World2Object[1].y;
  v_9.z = _World2Object[2].y;
  v_9.w = _World2Object[3].y;
  highp vec4 v_10;
  v_10.x = _World2Object[0].z;
  v_10.y = _World2Object[1].z;
  v_10.z = _World2Object[2].z;
  v_10.w = _World2Object[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_11;
  tmpvar_5 = worldNormal_1;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = worldNormal_1;
  mediump vec4 normal_13;
  normal_13 = tmpvar_12;
  mediump vec3 x2_14;
  mediump vec3 x1_15;
  x1_15.x = dot (unity_SHAr, normal_13);
  x1_15.y = dot (unity_SHAg, normal_13);
  x1_15.z = dot (unity_SHAb, normal_13);
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_13.xyzz * normal_13.yzzx);
  x2_14.x = dot (unity_SHBr, tmpvar_16);
  x2_14.y = dot (unity_SHBg, tmpvar_16);
  x2_14.z = dot (unity_SHBb, tmpvar_16);
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 normal_22;
  normal_22 = worldNormal_1;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
  ndotl_24 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (lengthSq_25 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_30.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_6 = (((x2_14 + 
    (unity_SHC.xyz * ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y)))
  ) + x1_15) + col_23);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec3 tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_7 = (((
    (texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_8.x)
   + 
    (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_8.y)
  ) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_8.z)) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_8.w));
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp vec4 c_10;
  lowp float diff_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_11 = tmpvar_12;
  c_10.xyz = ((tmpvar_7 * tmpvar_1) * diff_11);
  c_10.w = 0.0;
  c_9.w = c_10.w;
  c_9.xyz = (c_10.xyz + (tmpvar_7 * xlv_TEXCOORD5));
  highp float tmpvar_13;
  tmpvar_13 = clamp (xlv_TEXCOORD6, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_9.xyz, vec3(tmpvar_13));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
highp vec4 t0;
highp vec4 t1;
mediump vec3 t16_2;
highp vec4 t3;
mediump vec4 t16_3;
highp vec4 t4;
mediump vec3 t16_4;
highp vec4 t5;
highp float t18;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD6 = t0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t18 = dot(t0.xyz, t0.xyz);
    t18 = inversesqrt(t18);
    t0.xyz = vec3(t18) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD4.xyz = t1.xyz;
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_3 = t0.yzzx * t0.xyzz;
    t16_4.x = dot(unity_SHBr, t16_3);
    t16_4.y = dot(unity_SHBg, t16_3);
    t16_4.z = dot(unity_SHBb, t16_3);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_4.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    t16_2.xyz = t16_2.xyz + t16_3.xyz;
    t3 = (-t1.yyyy) + unity_4LightPosY0;
    t4 = t0.yyyy * t3;
    t3 = t3 * t3;
    t5 = (-t1.xxxx) + unity_4LightPosX0;
    t1 = (-t1.zzzz) + unity_4LightPosZ0;
    t4 = t5 * t0.xxxx + t4;
    t0 = t1 * t0.zzzz + t4;
    t3 = t5 * t5 + t3;
    t1 = t1 * t1 + t3;
    t3 = inversesqrt(t1);
    t1 = t1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    t1 = vec4(1.0, 1.0, 1.0, 1.0) / t1;
    t0 = t0 * t3;
    t0 = max(t0, vec4(0.0, 0.0, 0.0, 0.0));
    t0 = t1 * t0;
    t1.xyz = t0.yyy * unity_LightColor[1].xyz;
    t1.xyz = unity_LightColor[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = unity_LightColor[2].xyz * t0.zzz + t1.xyz;
    t0.xyz = unity_LightColor[3].xyz * t0.www + t0.xyz;
    t0.xyz = t0.xyz + t16_2.xyz;
    vs_TEXCOORD5.xyz = t0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump vec3 t16_6;
highp float t21;
mediump float t16_26;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = t10_4.xyz * _LightColor0.xyz;
    t16_6.xyz = t10_4.xyz * vs_TEXCOORD5.xyz;
    t16_26 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
    t16_26 = max(t16_26, 0.0);
    t16_5.xyz = t16_5.xyz * vec3(t16_26) + t16_6.xyz;
    t16_0.xyz = t16_5.xyz + (-unity_FogColor.xyz);
    t21 = vs_TEXCOORD6;
    t21 = clamp(t21, 0.0, 1.0);
    t0.xyz = vec3(t21) * t16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"!!GLES3"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" "SplatCount"="4" }
  ZWrite Off
  Blend One One
  GpuProgramID 111670
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_5;
  v_5.x = _World2Object[0].x;
  v_5.y = _World2Object[1].x;
  v_5.z = _World2Object[2].x;
  v_5.w = _World2Object[3].x;
  highp vec4 v_6;
  v_6.x = _World2Object[0].y;
  v_6.y = _World2Object[1].y;
  v_6.z = _World2Object[2].y;
  v_6.w = _World2Object[3].y;
  highp vec4 v_7;
  v_7.x = _World2Object[0].z;
  v_7.y = _World2Object[1].z;
  v_7.z = _World2Object[2].z;
  v_7.w = _World2Object[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _glesNormal.x)
   + 
    (v_6.xyz * _glesNormal.y)
  ) + (v_7.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_8;
  tmpvar_4 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Control, xlv_TEXCOORD0.xy);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD4;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_LightMatrix0 * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_7.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_7.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_7.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_7.w)
  ) * tmpvar_1) * diff_14);
  c_13.w = 0.0;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightTexture0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump float t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
highp float t18;
mediump float t16_23;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = vs_TEXCOORD4.yyy * _LightMatrix0[1].xyz;
    t16_5.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD4.xxx + t16_5.xyz;
    t16_5.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD4.zzz + t16_5.xyz;
    t16_5.xyz = t16_5.xyz + _LightMatrix0[3].xyz;
    t16_0 = dot(t16_5.xyz, t16_5.xyz);
    t10_0.x = texture(_LightTexture0, vec2(t16_0)).w;
    t16_5.xyz = t10_0.xxx * _LightColor0.xyz;
    t16_5.xyz = t10_4.xyz * t16_5.xyz;
    t0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    t18 = dot(t0.xyz, t0.xyz);
    t18 = inversesqrt(t18);
    t0.xyz = vec3(t18) * t0.xyz;
    t16_23 = dot(vs_TEXCOORD3.xyz, t0.xyz);
    t16_23 = max(t16_23, 0.0);
    t16_5.xyz = vec3(t16_23) * t16_5.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_5;
  v_5.x = _World2Object[0].x;
  v_5.y = _World2Object[1].x;
  v_5.z = _World2Object[2].x;
  v_5.w = _World2Object[3].x;
  highp vec4 v_6;
  v_6.x = _World2Object[0].y;
  v_6.y = _World2Object[1].y;
  v_6.z = _World2Object[2].y;
  v_6.w = _World2Object[3].y;
  highp vec4 v_7;
  v_7.x = _World2Object[0].z;
  v_7.y = _World2Object[1].z;
  v_7.z = _World2Object[2].z;
  v_7.w = _World2Object[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _glesNormal.x)
   + 
    (v_6.xyz * _glesNormal.y)
  ) + (v_7.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_8;
  tmpvar_4 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_7.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_7.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_7.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_7.w)
  ) * tmpvar_1) * diff_10);
  c_9.w = 0.0;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump float t16_23;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = t10_4.xyz * _LightColor0.xyz;
    t16_23 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
    t16_23 = max(t16_23, 0.0);
    t16_5.xyz = vec3(t16_23) * t16_5.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_5;
  v_5.x = _World2Object[0].x;
  v_5.y = _World2Object[1].x;
  v_5.z = _World2Object[2].x;
  v_5.w = _World2Object[3].x;
  highp vec4 v_6;
  v_6.x = _World2Object[0].y;
  v_6.y = _World2Object[1].y;
  v_6.z = _World2Object[2].y;
  v_6.w = _World2Object[3].y;
  highp vec4 v_7;
  v_7.x = _World2Object[0].z;
  v_7.y = _World2Object[1].z;
  v_7.z = _World2Object[2].z;
  v_7.w = _World2Object[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _glesNormal.x)
   + 
    (v_6.xyz * _glesNormal.y)
  ) + (v_7.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_8;
  tmpvar_4 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  mediump vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Control, xlv_TEXCOORD0.xy);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD4;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10);
  lightCoord_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump vec2 P_13;
  P_13 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
  tmpvar_12 = texture2D (_LightTexture0, P_13);
  highp vec3 LightCoord_14;
  LightCoord_14 = lightCoord_5.xyz;
  highp float tmpvar_15;
  tmpvar_15 = dot (LightCoord_14, LightCoord_14);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightTextureB0, vec2(tmpvar_15));
  mediump float tmpvar_17;
  tmpvar_17 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_12.w) * tmpvar_16.w);
  atten_4 = tmpvar_17;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_18;
  lowp vec4 c_19;
  lowp float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_20 = tmpvar_21;
  c_19.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_9.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_9.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_9.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_9.w)
  ) * tmpvar_1) * diff_20);
  c_19.w = 0.0;
  c_18.w = c_19.w;
  c_18.xyz = c_19.xyz;
  c_3.xyz = c_18.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightTexture0;
uniform lowp sampler2D _LightTextureB0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec2 t16_1;
lowp vec4 t10_1;
highp vec3 t2;
lowp vec3 t10_2;
lowp vec3 t10_3;
lowp vec3 t10_4;
lowp vec3 t10_5;
bool tb8;
mediump float t16_14;
lowp float t10_14;
mediump float t16_18;
highp float t20;
void main()
{
    t16_0 = vs_TEXCOORD4.yyyy * _LightMatrix0[1];
    t16_0 = _LightMatrix0[0] * vs_TEXCOORD4.xxxx + t16_0;
    t16_0 = _LightMatrix0[2] * vs_TEXCOORD4.zzzz + t16_0;
    t16_0 = t16_0 + _LightMatrix0[3];
    t16_1.xy = t16_0.xy / t16_0.ww;
    t16_1.xy = t16_1.xy + vec2(0.5, 0.5);
    t10_2.x = texture(_LightTexture0, t16_1.xy).w;
    tb8 = 0.0<t16_0.z;
    t16_14 = dot(t16_0.xyz, t16_0.xyz);
    t10_14 = texture(_LightTextureB0, vec2(t16_14)).w;
    t10_3.x = (tb8) ? 1.0 : 0.0;
    t10_3.x = t10_2.x * t10_3.x;
    t10_3.x = t10_14 * t10_3.x;
    t16_0.xyz = t10_3.xxx * _LightColor0.xyz;
    t10_2.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_4.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_5.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_1 = texture(_Control, vs_TEXCOORD0.xy);
    t10_3.xyz = t10_1.yyy * t10_5.xyz;
    t10_3.xyz = t10_4.xyz * t10_1.xxx + t10_3.xyz;
    t10_3.xyz = t10_2.xyz * t10_1.zzz + t10_3.xyz;
    t10_2.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_3.xyz = t10_2.xyz * t10_1.www + t10_3.xyz;
    t16_0.xyz = t16_0.xyz * t10_3.xyz;
    t2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    t20 = dot(t2.xyz, t2.xyz);
    t20 = inversesqrt(t20);
    t2.xyz = vec3(t20) * t2.xyz;
    t16_18 = dot(vs_TEXCOORD3.xyz, t2.xyz);
    t16_18 = max(t16_18, 0.0);
    t16_0.xyz = vec3(t16_18) * t16_0.xyz;
    SV_Target0.xyz = t16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_5;
  v_5.x = _World2Object[0].x;
  v_5.y = _World2Object[1].x;
  v_5.z = _World2Object[2].x;
  v_5.w = _World2Object[3].x;
  highp vec4 v_6;
  v_6.x = _World2Object[0].y;
  v_6.y = _World2Object[1].y;
  v_6.z = _World2Object[2].y;
  v_6.w = _World2Object[3].y;
  highp vec4 v_7;
  v_7.x = _World2Object[0].z;
  v_7.y = _World2Object[1].z;
  v_7.z = _World2Object[2].z;
  v_7.w = _World2Object[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _glesNormal.x)
   + 
    (v_6.xyz * _glesNormal.y)
  ) + (v_7.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_8;
  tmpvar_4 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Control, xlv_TEXCOORD0.xy);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD4;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_LightMatrix0 * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, tmpvar_9).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_7.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_7.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_7.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_7.w)
  ) * tmpvar_1) * diff_14);
  c_13.w = 0.0;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightTextureB0;
uniform lowp samplerCube _LightTexture0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump float t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
lowp float t10_6;
highp float t18;
mediump float t16_23;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = vs_TEXCOORD4.yyy * _LightMatrix0[1].xyz;
    t16_5.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD4.xxx + t16_5.xyz;
    t16_5.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD4.zzz + t16_5.xyz;
    t16_5.xyz = t16_5.xyz + _LightMatrix0[3].xyz;
    t16_0 = dot(t16_5.xyz, t16_5.xyz);
    t10_6 = texture(_LightTexture0, t16_5.xyz).w;
    t10_0.x = texture(_LightTextureB0, vec2(t16_0)).w;
    t16_0 = t10_6 * t10_0.x;
    t16_5.xyz = vec3(t16_0) * _LightColor0.xyz;
    t16_5.xyz = t10_4.xyz * t16_5.xyz;
    t0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    t18 = dot(t0.xyz, t0.xyz);
    t18 = inversesqrt(t18);
    t0.xyz = vec3(t18) * t0.xyz;
    t16_23 = dot(vs_TEXCOORD3.xyz, t0.xyz);
    t16_23 = max(t16_23, 0.0);
    t16_5.xyz = vec3(t16_23) * t16_5.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_5;
  v_5.x = _World2Object[0].x;
  v_5.y = _World2Object[1].x;
  v_5.z = _World2Object[2].x;
  v_5.w = _World2Object[3].x;
  highp vec4 v_6;
  v_6.x = _World2Object[0].y;
  v_6.y = _World2Object[1].y;
  v_6.z = _World2Object[2].y;
  v_6.w = _World2Object[3].y;
  highp vec4 v_7;
  v_7.x = _World2Object[0].z;
  v_7.y = _World2Object[1].z;
  v_7.z = _World2Object[2].z;
  v_7.w = _World2Object[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _glesNormal.x)
   + 
    (v_6.xyz * _glesNormal.y)
  ) + (v_7.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_8;
  tmpvar_4 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Control, xlv_TEXCOORD0.xy);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD4;
  highp vec2 tmpvar_9;
  tmpvar_9 = (_LightMatrix0 * tmpvar_8).xy;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, tmpvar_9).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_10);
  lowp vec4 c_11;
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_7.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_7.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_7.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_7.w)
  ) * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  c_11.w = c_12.w;
  c_11.xyz = c_12.xyz;
  c_3.xyz = c_11.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightTexture0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump float t16_23;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xy = vs_TEXCOORD4.yy * _LightMatrix0[1].xy;
    t16_5.xy = _LightMatrix0[0].xy * vs_TEXCOORD4.xx + t16_5.xy;
    t16_5.xy = _LightMatrix0[2].xy * vs_TEXCOORD4.zz + t16_5.xy;
    t16_5.xy = t16_5.xy + _LightMatrix0[3].xy;
    t10_0.x = texture(_LightTexture0, t16_5.xy).w;
    t16_5.xyz = t10_0.xxx * _LightColor0.xyz;
    t16_5.xyz = t10_4.xyz * t16_5.xyz;
    t16_23 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
    t16_23 = max(t16_23, 0.0);
    t16_5.xyz = vec3(t16_23) * t16_5.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "POINT" "FOG_LINEAR" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  highp vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  highp vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_5 = worldNormal_1;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Control, xlv_TEXCOORD0.xy);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD4;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_LightMatrix0 * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_7.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_7.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_7.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_7.w)
  ) * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT" "FOG_LINEAR" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD5 = t0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightTexture0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump float t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
highp float t18;
mediump float t16_23;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = vs_TEXCOORD4.yyy * _LightMatrix0[1].xyz;
    t16_5.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD4.xxx + t16_5.xyz;
    t16_5.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD4.zzz + t16_5.xyz;
    t16_5.xyz = t16_5.xyz + _LightMatrix0[3].xyz;
    t16_0 = dot(t16_5.xyz, t16_5.xyz);
    t10_0.x = texture(_LightTexture0, vec2(t16_0)).w;
    t16_5.xyz = t10_0.xxx * _LightColor0.xyz;
    t16_5.xyz = t10_4.xyz * t16_5.xyz;
    t0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    t18 = dot(t0.xyz, t0.xyz);
    t18 = inversesqrt(t18);
    t0.xyz = vec3(t18) * t0.xyz;
    t16_23 = dot(vs_TEXCOORD3.xyz, t0.xyz);
    t16_23 = max(t16_23, 0.0);
    t16_5.xyz = vec3(t16_23) * t16_5.xyz;
    t0.x = vs_TEXCOORD5;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.xyz = t16_5.xyz * t0.xxx;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  highp vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  highp vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_5 = worldNormal_1;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_7.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_7.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_7.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_7.w)
  ) * tmpvar_1) * diff_9);
  c_8.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD5 = t0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump float t16_23;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = t10_4.xyz * _LightColor0.xyz;
    t16_23 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
    t16_23 = max(t16_23, 0.0);
    t16_5.xyz = vec3(t16_23) * t16_5.xyz;
    t0.x = vs_TEXCOORD5;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.xyz = t16_5.xyz * t0.xxx;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" "FOG_LINEAR" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  highp vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  highp vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_5 = worldNormal_1;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  mediump vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Control, xlv_TEXCOORD0.xy);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD4;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10);
  lightCoord_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump vec2 P_13;
  P_13 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
  tmpvar_12 = texture2D (_LightTexture0, P_13);
  highp vec3 LightCoord_14;
  LightCoord_14 = lightCoord_5.xyz;
  highp float tmpvar_15;
  tmpvar_15 = dot (LightCoord_14, LightCoord_14);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightTextureB0, vec2(tmpvar_15));
  mediump float tmpvar_17;
  tmpvar_17 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_12.w) * tmpvar_16.w);
  atten_4 = tmpvar_17;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_9.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_9.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_9.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_9.w)
  ) * tmpvar_1) * diff_19);
  c_18.w = 0.0;
  highp float tmpvar_21;
  tmpvar_21 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = (c_18.xyz * vec3(tmpvar_21));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" "FOG_LINEAR" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD5 = t0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightTexture0;
uniform lowp sampler2D _LightTextureB0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec2 t16_1;
lowp vec4 t10_1;
highp vec3 t2;
lowp vec3 t10_2;
lowp vec3 t10_3;
lowp vec3 t10_4;
lowp vec3 t10_5;
bool tb8;
mediump float t16_14;
lowp float t10_14;
mediump float t16_18;
highp float t20;
void main()
{
    t16_0 = vs_TEXCOORD4.yyyy * _LightMatrix0[1];
    t16_0 = _LightMatrix0[0] * vs_TEXCOORD4.xxxx + t16_0;
    t16_0 = _LightMatrix0[2] * vs_TEXCOORD4.zzzz + t16_0;
    t16_0 = t16_0 + _LightMatrix0[3];
    t16_1.xy = t16_0.xy / t16_0.ww;
    t16_1.xy = t16_1.xy + vec2(0.5, 0.5);
    t10_2.x = texture(_LightTexture0, t16_1.xy).w;
    tb8 = 0.0<t16_0.z;
    t16_14 = dot(t16_0.xyz, t16_0.xyz);
    t10_14 = texture(_LightTextureB0, vec2(t16_14)).w;
    t10_3.x = (tb8) ? 1.0 : 0.0;
    t10_3.x = t10_2.x * t10_3.x;
    t10_3.x = t10_14 * t10_3.x;
    t16_0.xyz = t10_3.xxx * _LightColor0.xyz;
    t10_2.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_4.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_5.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_1 = texture(_Control, vs_TEXCOORD0.xy);
    t10_3.xyz = t10_1.yyy * t10_5.xyz;
    t10_3.xyz = t10_4.xyz * t10_1.xxx + t10_3.xyz;
    t10_3.xyz = t10_2.xyz * t10_1.zzz + t10_3.xyz;
    t10_2.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_3.xyz = t10_2.xyz * t10_1.www + t10_3.xyz;
    t16_0.xyz = t16_0.xyz * t10_3.xyz;
    t2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    t20 = dot(t2.xyz, t2.xyz);
    t20 = inversesqrt(t20);
    t2.xyz = vec3(t20) * t2.xyz;
    t16_18 = dot(vs_TEXCOORD3.xyz, t2.xyz);
    t16_18 = max(t16_18, 0.0);
    t16_0.xyz = vec3(t16_18) * t16_0.xyz;
    t2.x = vs_TEXCOORD5;
    t2.x = clamp(t2.x, 0.0, 1.0);
    t2.xyz = t16_0.xyz * t2.xxx;
    SV_Target0.xyz = t2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  highp vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  highp vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_5 = worldNormal_1;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Control, xlv_TEXCOORD0.xy);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD4;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_LightMatrix0 * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, tmpvar_9).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_7.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_7.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_7.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_7.w)
  ) * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD5 = t0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightTextureB0;
uniform lowp samplerCube _LightTexture0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump float t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
lowp float t10_6;
highp float t18;
mediump float t16_23;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xyz = vs_TEXCOORD4.yyy * _LightMatrix0[1].xyz;
    t16_5.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD4.xxx + t16_5.xyz;
    t16_5.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD4.zzz + t16_5.xyz;
    t16_5.xyz = t16_5.xyz + _LightMatrix0[3].xyz;
    t16_0 = dot(t16_5.xyz, t16_5.xyz);
    t10_6 = texture(_LightTexture0, t16_5.xyz).w;
    t10_0.x = texture(_LightTextureB0, vec2(t16_0)).w;
    t16_0 = t10_6 * t10_0.x;
    t16_5.xyz = vec3(t16_0) * _LightColor0.xyz;
    t16_5.xyz = t10_4.xyz * t16_5.xyz;
    t0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    t18 = dot(t0.xyz, t0.xyz);
    t18 = inversesqrt(t18);
    t0.xyz = vec3(t18) * t0.xyz;
    t16_23 = dot(vs_TEXCOORD3.xyz, t0.xyz);
    t16_23 = max(t16_23, 0.0);
    t16_5.xyz = vec3(t16_23) * t16_5.xyz;
    t0.x = vs_TEXCOORD5;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.xyz = t16_5.xyz * t0.xxx;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  highp vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  highp vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_5 = worldNormal_1;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Control, xlv_TEXCOORD0.xy);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD4;
  highp vec2 tmpvar_9;
  tmpvar_9 = (_LightMatrix0 * tmpvar_8).xy;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, tmpvar_9).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_10);
  lowp vec4 c_11;
  lowp float diff_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_12 = tmpvar_13;
  c_11.xyz = (((
    (((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_7.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_7.y)) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_7.z))
   + 
    (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_7.w)
  ) * tmpvar_1) * diff_12);
  c_11.w = 0.0;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD5 = t0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	mediump mat4 _LightMatrix0;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightTexture0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump float t16_23;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t16_5.xy = vs_TEXCOORD4.yy * _LightMatrix0[1].xy;
    t16_5.xy = _LightMatrix0[0].xy * vs_TEXCOORD4.xx + t16_5.xy;
    t16_5.xy = _LightMatrix0[2].xy * vs_TEXCOORD4.zz + t16_5.xy;
    t16_5.xy = t16_5.xy + _LightMatrix0[3].xy;
    t10_0.x = texture(_LightTexture0, t16_5.xy).w;
    t16_5.xyz = t10_0.xxx * _LightColor0.xyz;
    t16_5.xyz = t10_4.xyz * t16_5.xyz;
    t16_23 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
    t16_23 = max(t16_23, 0.0);
    t16_5.xyz = vec3(t16_23) * t16_5.xyz;
    t0.x = vs_TEXCOORD5;
    t0.x = clamp(t0.x, 0.0, 1.0);
    t0.xyz = t16_5.xyz * t0.xxx;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT" "FOG_LINEAR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "FOG_LINEAR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "FOG_LINEAR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "FOG_LINEAR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"!!GLES3"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" "SplatCount"="4" }
  GpuProgramID 143921
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  highp vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  highp vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * _glesNormal.x)
   + 
    (v_4.xyz * _glesNormal.y)
  ) + (v_5.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_6;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
varying mediump vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out mediump vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD0.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD1.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
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
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" "SplatCount"="4" }
  ZWrite Off
  GpuProgramID 216289
Program "vp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_1.zw;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  highp vec4 v_9;
  v_9.x = _World2Object[0].x;
  v_9.y = _World2Object[1].x;
  v_9.z = _World2Object[2].x;
  v_9.w = _World2Object[3].x;
  highp vec4 v_10;
  v_10.x = _World2Object[0].y;
  v_10.y = _World2Object[1].y;
  v_10.z = _World2Object[2].y;
  v_10.w = _World2Object[3].y;
  highp vec4 v_11;
  v_11.x = _World2Object[0].z;
  v_11.y = _World2Object[1].z;
  v_11.z = _World2Object[2].z;
  v_11.w = _World2Object[3].z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  mediump vec3 tmpvar_13;
  mediump vec4 normal_14;
  normal_14 = tmpvar_12;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  x1_16.x = dot (unity_SHAr, normal_14);
  x1_16.y = dot (unity_SHAg, normal_14);
  x1_16.z = dot (unity_SHAb, normal_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_14.xyzz * normal_14.yzzx);
  x2_15.x = dot (unity_SHBr, tmpvar_17);
  x2_15.y = dot (unity_SHBg, tmpvar_17);
  x2_15.z = dot (unity_SHBb, tmpvar_17);
  tmpvar_13 = ((x2_15 + (unity_SHC.xyz * 
    ((normal_14.x * normal_14.x) - (normal_14.y * normal_14.y))
  )) + x1_16);
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Control, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
  lowp vec4 c_6;
  c_6.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_4.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_4.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_4.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_4.w)) * light_3.xyz);
  c_6.w = 0.0;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
highp vec4 t0;
highp vec4 t1;
mediump vec4 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
highp float t12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = t0.zw;
    vs_TEXCOORD4.xy = t1.zz + t1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_1 = t0.yzzx * t0.xyzz;
    t16_3.x = dot(unity_SHBr, t16_1);
    t16_3.y = dot(unity_SHBg, t16_1);
    t16_3.z = dot(unity_SHBb, t16_1);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_3.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    t16_2.xyz = t16_2.xyz + t16_3.xyz;
    vs_TEXCOORD6.xyz = t16_2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightBuffer;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    t10_0.xyz = texture(_LightBuffer, t0.xy).xyz;
    t16_5.xyz = max(t10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    t16_5.xyz = log2(t16_5.xyz);
    t0.xyz = (-t16_5.xyz) + vs_TEXCOORD6.xyz;
    t16_5.xyz = t0.xyz * t10_4.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_1.zw;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  tmpvar_5.xyz = ((tmpvar_9.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_9.xyz;
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  lowp vec3 lm_3;
  mediump vec4 light_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Control, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_4 = tmpvar_6;
  light_4 = -(log2(max (light_4, vec4(0.001, 0.001, 0.001, 0.001))));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD5.xy);
  mediump vec3 tmpvar_8;
  tmpvar_8 = (2.0 * tmpvar_7.xyz);
  lm_3 = tmpvar_8;
  light_4.xyz = (light_4.xyz + lm_3);
  lowp vec4 c_9;
  c_9.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_5.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_5.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_5.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_5.w)) * light_4.xyz);
  c_9.w = 0.0;
  c_2.xyz = c_9.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
highp vec4 t0;
highp vec4 t1;
highp float t2;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD3.xyz = t1.xyz;
    t1.xyz = t1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = t1.xyz * unity_ShadowFadeCenterAndType.www;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = t0.zw;
    vs_TEXCOORD4.xy = t1.zz + t1.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = t2 * (-t0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightBuffer;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec2 t0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    t10_0.xyz = texture(_LightBuffer, t0.xy).xyz;
    t16_5.xyz = max(t10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    t16_5.xyz = log2(t16_5.xyz);
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    t16_5.xyz = vec3(2.0, 2.0, 2.0) * t10_0.xyz + (-t16_5.xyz);
    t16_5.xyz = t10_4.xyz * t16_5.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_1.zw;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  highp vec4 v_9;
  v_9.x = _World2Object[0].x;
  v_9.y = _World2Object[1].x;
  v_9.z = _World2Object[2].x;
  v_9.w = _World2Object[3].x;
  highp vec4 v_10;
  v_10.x = _World2Object[0].y;
  v_10.y = _World2Object[1].y;
  v_10.z = _World2Object[2].y;
  v_10.w = _World2Object[3].y;
  highp vec4 v_11;
  v_11.x = _World2Object[0].z;
  v_11.y = _World2Object[1].z;
  v_11.z = _World2Object[2].z;
  v_11.w = _World2Object[3].z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  mediump vec3 tmpvar_13;
  mediump vec4 normal_14;
  normal_14 = tmpvar_12;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  x1_16.x = dot (unity_SHAr, normal_14);
  x1_16.y = dot (unity_SHAg, normal_14);
  x1_16.z = dot (unity_SHAb, normal_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_14.xyzz * normal_14.yzzx);
  x2_15.x = dot (unity_SHBr, tmpvar_17);
  x2_15.y = dot (unity_SHBg, tmpvar_17);
  x2_15.z = dot (unity_SHBb, tmpvar_17);
  tmpvar_13 = ((x2_15 + (unity_SHC.xyz * 
    ((normal_14.x * normal_14.x) - (normal_14.y * normal_14.y))
  )) + x1_16);
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Control, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD6);
  lowp vec4 c_7;
  c_7.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_4.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_4.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_4.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_4.w)) * light_3.xyz);
  c_7.w = 0.0;
  c_2.xyz = c_7.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
highp vec4 t0;
highp vec4 t1;
mediump vec4 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
highp float t12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = t0.zw;
    vs_TEXCOORD4.xy = t1.zz + t1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_1 = t0.yzzx * t0.xyzz;
    t16_3.x = dot(unity_SHBr, t16_1);
    t16_3.y = dot(unity_SHBg, t16_1);
    t16_3.z = dot(unity_SHBb, t16_1);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_3.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    t16_2.xyz = t16_2.xyz + t16_3.xyz;
    vs_TEXCOORD6.xyz = t16_2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightBuffer;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    t10_0.xyz = texture(_LightBuffer, t0.xy).xyz;
    t16_5.xyz = max(t10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    t0.xyz = t16_5.xyz + vs_TEXCOORD6.xyz;
    t16_5.xyz = t0.xyz * t10_4.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_1.zw;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  tmpvar_5.xyz = ((tmpvar_9.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_9.xyz;
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  lowp vec3 lm_3;
  mediump vec4 light_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Control, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = max (light_4, vec4(0.001, 0.001, 0.001, 0.001));
  light_4.w = tmpvar_7.w;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD5.xy);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lm_3 = tmpvar_9;
  light_4.xyz = (tmpvar_7.xyz + lm_3);
  lowp vec4 c_10;
  c_10.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_5.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_5.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_5.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_5.w)) * light_4.xyz);
  c_10.w = 0.0;
  c_2.xyz = c_10.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
highp vec4 t0;
highp vec4 t1;
highp float t2;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD3.xyz = t1.xyz;
    t1.xyz = t1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = t1.xyz * unity_ShadowFadeCenterAndType.www;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = t0.zw;
    vs_TEXCOORD4.xy = t1.zz + t1.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = t2 * (-t0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightBuffer;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec2 t0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    t10_0.xyz = texture(_LightBuffer, t0.xy).xyz;
    t16_5.xyz = max(t10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    t16_5.xyz = vec3(2.0, 2.0, 2.0) * t10_0.xyz + t16_5.xyz;
    t16_5.xyz = t10_4.xyz * t16_5.xyz;
    SV_Target0.xyz = t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_1.zw;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  highp vec4 v_9;
  v_9.x = _World2Object[0].x;
  v_9.y = _World2Object[1].x;
  v_9.z = _World2Object[2].x;
  v_9.w = _World2Object[3].x;
  highp vec4 v_10;
  v_10.x = _World2Object[0].y;
  v_10.y = _World2Object[1].y;
  v_10.z = _World2Object[2].y;
  v_10.w = _World2Object[3].y;
  highp vec4 v_11;
  v_11.x = _World2Object[0].z;
  v_11.y = _World2Object[1].z;
  v_11.z = _World2Object[2].z;
  v_11.w = _World2Object[3].z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  mediump vec3 tmpvar_13;
  mediump vec4 normal_14;
  normal_14 = tmpvar_12;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  x1_16.x = dot (unity_SHAr, normal_14);
  x1_16.y = dot (unity_SHAg, normal_14);
  x1_16.z = dot (unity_SHAb, normal_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_14.xyzz * normal_14.yzzx);
  x2_15.x = dot (unity_SHBr, tmpvar_17);
  x2_15.y = dot (unity_SHBg, tmpvar_17);
  x2_15.z = dot (unity_SHBb, tmpvar_17);
  tmpvar_13 = ((x2_15 + (unity_SHC.xyz * 
    ((normal_14.x * normal_14.x) - (normal_14.y * normal_14.y))
  )) + x1_16);
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Control, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
  lowp vec4 c_6;
  c_6.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_4.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_4.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_4.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_4.w)) * light_3.xyz);
  c_6.w = 0.0;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
highp vec4 t0;
highp vec4 t1;
mediump vec4 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
highp float t12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    vs_TEXCOORD7 = t0.z * unity_FogParams.z + unity_FogParams.w;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = t0.zw;
    vs_TEXCOORD4.xy = t1.zz + t1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_1 = t0.yzzx * t0.xyzz;
    t16_3.x = dot(unity_SHBr, t16_1);
    t16_3.y = dot(unity_SHBg, t16_1);
    t16_3.z = dot(unity_SHBb, t16_1);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_3.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    t16_2.xyz = t16_2.xyz + t16_3.xyz;
    vs_TEXCOORD6.xyz = t16_2.xyz;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightBuffer;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
highp float t18;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    t10_0.xyz = texture(_LightBuffer, t0.xy).xyz;
    t16_5.xyz = max(t10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    t16_5.xyz = log2(t16_5.xyz);
    t0.xyz = (-t16_5.xyz) + vs_TEXCOORD6.xyz;
    t0.xyz = t10_4.xyz * t0.xyz + (-unity_FogColor.xyz);
    t18 = vs_TEXCOORD7;
    t18 = clamp(t18, 0.0, 1.0);
    t0.xyz = vec3(t18) * t0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_1.zw;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  tmpvar_5.xyz = ((tmpvar_9.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_9.xyz;
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  lowp vec3 lm_3;
  mediump vec4 light_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Control, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_4 = tmpvar_6;
  light_4 = -(log2(max (light_4, vec4(0.001, 0.001, 0.001, 0.001))));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD5.xy);
  mediump vec3 tmpvar_8;
  tmpvar_8 = (2.0 * tmpvar_7.xyz);
  lm_3 = tmpvar_8;
  light_4.xyz = (light_4.xyz + lm_3);
  lowp vec4 c_9;
  c_9.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_5.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_5.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_5.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_5.w)) * light_4.xyz);
  c_9.w = 0.0;
  c_2 = c_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_10));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
highp vec4 t0;
highp vec4 t1;
highp float t2;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    vs_TEXCOORD7 = t0.z * unity_FogParams.z + unity_FogParams.w;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD3.xyz = t1.xyz;
    t1.xyz = t1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = t1.xyz * unity_ShadowFadeCenterAndType.www;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = t0.zw;
    vs_TEXCOORD4.xy = t1.zz + t1.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = t2 * (-t0.x);
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightBuffer;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
highp float t18;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    t10_0.xyz = texture(_LightBuffer, t0.xy).xyz;
    t16_5.xyz = max(t10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    t16_5.xyz = log2(t16_5.xyz);
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    t16_5.xyz = vec3(2.0, 2.0, 2.0) * t10_0.xyz + (-t16_5.xyz);
    t16_0.xyz = t10_4.xyz * t16_5.xyz + (-unity_FogColor.xyz);
    t18 = vs_TEXCOORD7;
    t18 = clamp(t18, 0.0, 1.0);
    t0.xyz = vec3(t18) * t16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_1.zw;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  highp vec4 v_9;
  v_9.x = _World2Object[0].x;
  v_9.y = _World2Object[1].x;
  v_9.z = _World2Object[2].x;
  v_9.w = _World2Object[3].x;
  highp vec4 v_10;
  v_10.x = _World2Object[0].y;
  v_10.y = _World2Object[1].y;
  v_10.z = _World2Object[2].y;
  v_10.w = _World2Object[3].y;
  highp vec4 v_11;
  v_11.x = _World2Object[0].z;
  v_11.y = _World2Object[1].z;
  v_11.z = _World2Object[2].z;
  v_11.w = _World2Object[3].z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  mediump vec3 tmpvar_13;
  mediump vec4 normal_14;
  normal_14 = tmpvar_12;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  x1_16.x = dot (unity_SHAr, normal_14);
  x1_16.y = dot (unity_SHAg, normal_14);
  x1_16.z = dot (unity_SHAb, normal_14);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_14.xyzz * normal_14.yzzx);
  x2_15.x = dot (unity_SHBr, tmpvar_17);
  x2_15.y = dot (unity_SHBg, tmpvar_17);
  x2_15.z = dot (unity_SHBb, tmpvar_17);
  tmpvar_13 = ((x2_15 + (unity_SHC.xyz * 
    ((normal_14.x * normal_14.x) - (normal_14.y * normal_14.y))
  )) + x1_16);
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Control, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD6);
  lowp vec4 c_7;
  c_7.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_4.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_4.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_4.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_4.w)) * light_3.xyz);
  c_7.w = 0.0;
  c_2 = c_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
highp vec4 t0;
highp vec4 t1;
mediump vec4 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
highp float t12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    vs_TEXCOORD7 = t0.z * unity_FogParams.z + unity_FogParams.w;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = t0.zw;
    vs_TEXCOORD4.xy = t1.zz + t1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_1 = t0.yzzx * t0.xyzz;
    t16_3.x = dot(unity_SHBr, t16_1);
    t16_3.y = dot(unity_SHBg, t16_1);
    t16_3.z = dot(unity_SHBb, t16_1);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_3.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    t16_2.xyz = t16_2.xyz + t16_3.xyz;
    vs_TEXCOORD6.xyz = t16_2.xyz;
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightBuffer;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
highp float t18;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    t10_0.xyz = texture(_LightBuffer, t0.xy).xyz;
    t16_5.xyz = max(t10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    t0.xyz = t16_5.xyz + vs_TEXCOORD6.xyz;
    t0.xyz = t10_4.xyz * t0.xyz + (-unity_FogColor.xyz);
    t18 = vs_TEXCOORD7;
    t18 = clamp(t18, 0.0, 1.0);
    t0.xyz = vec3(t18) * t0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_1.zw;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = (_Object2World * _glesVertex);
  tmpvar_5.xyz = ((tmpvar_9.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_9.xyz;
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  lowp vec3 lm_3;
  mediump vec4 light_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Control, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = max (light_4, vec4(0.001, 0.001, 0.001, 0.001));
  light_4.w = tmpvar_7.w;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD5.xy);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lm_3 = tmpvar_9;
  light_4.xyz = (tmpvar_7.xyz + lm_3);
  lowp vec4 c_10;
  c_10.xyz = (((
    ((texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_5.x) + (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_5.y))
   + 
    (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_5.z)
  ) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_5.w)) * light_4.xyz);
  c_10.w = 0.0;
  c_2 = c_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_11));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
highp vec4 t0;
highp vec4 t1;
highp float t2;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    vs_TEXCOORD7 = t0.z * unity_FogParams.z + unity_FogParams.w;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD3.xyz = t1.xyz;
    t1.xyz = t1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = t1.xyz * unity_ShadowFadeCenterAndType.www;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = t0.zw;
    vs_TEXCOORD4.xy = t1.zz + t1.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = t2 * (-t0.x);
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D _LightBuffer;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
highp float t18;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    t0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    t10_0.xyz = texture(_LightBuffer, t0.xy).xyz;
    t16_5.xyz = max(t10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    t16_5.xyz = vec3(2.0, 2.0, 2.0) * t10_0.xyz + t16_5.xyz;
    t16_0.xyz = t10_4.xyz * t16_5.xyz + (-unity_FogColor.xyz);
    t18 = vs_TEXCOORD7;
    t18 = clamp(t18, 0.0, 1.0);
    t0.xyz = vec3(t18) * t16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"!!GLES3"
}
}
 }
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "RenderType"="Opaque" "SplatCount"="4" }
  GpuProgramID 271917
Program "vp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  highp vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  highp vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_4 = worldNormal_1;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = vec2(0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = worldNormal_1;
  mediump vec4 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  x1_13.x = dot (unity_SHAr, normal_11);
  x1_13.y = dot (unity_SHAg, normal_11);
  x1_13.z = dot (unity_SHAb, normal_11);
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_11.xyzz * normal_11.yzzx);
  x2_12.x = dot (unity_SHBr, tmpvar_14);
  x2_12.y = dot (unity_SHBg, tmpvar_14);
  x2_12.z = dot (unity_SHBb, tmpvar_14);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = ((x2_12 + (unity_SHC.xyz * 
    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
  )) + x1_13);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 outDiffuse_1;
  mediump vec4 outEmission_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_4 = (((
    (texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_5.x)
   + 
    (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_5.y)
  ) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_5.z)) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_5.w));
  mediump vec4 outDiffuseOcclusion_6;
  mediump vec4 outNormal_7;
  mediump vec4 emission_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_4;
  outDiffuseOcclusion_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_3 * 0.5) + 0.5);
  outNormal_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  emission_8 = tmpvar_11;
  emission_8.xyz = (emission_8.xyz + (tmpvar_4 * xlv_TEXCOORD6));
  outDiffuse_1.xyz = outDiffuseOcclusion_6.xyz;
  outEmission_2.w = emission_8.w;
  outEmission_2.xyz = exp2(-(emission_8.xyz));
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = outNormal_7;
  gl_FragData[3] = outEmission_2;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
highp vec4 t0;
highp vec3 t1;
mediump vec4 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
highp float t12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_1 = t0.yzzx * t0.xyzz;
    t16_3.x = dot(unity_SHBr, t16_1);
    t16_3.y = dot(unity_SHBg, t16_1);
    t16_3.z = dot(unity_SHBb, t16_1);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_3.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    vs_TEXCOORD6.xyz = t16_2.xyz + t16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    SV_Target0.xyz = t10_4.xyz;
    t16_5.xyz = t10_4.xyz * vs_TEXCOORD6.xyz;
    SV_Target3.xyz = exp2((-t16_5.xyz));
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    t10_4.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_4.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_7;
  v_7.x = _World2Object[0].x;
  v_7.y = _World2Object[1].x;
  v_7.z = _World2Object[2].x;
  v_7.w = _World2Object[3].x;
  highp vec4 v_8;
  v_8.x = _World2Object[0].y;
  v_8.y = _World2Object[1].y;
  v_8.z = _World2Object[2].y;
  v_8.w = _World2Object[3].y;
  highp vec4 v_9;
  v_9.x = _World2Object[0].z;
  v_9.y = _World2Object[1].z;
  v_9.z = _World2Object[2].z;
  v_9.w = _World2Object[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_4 = worldNormal_1;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * _glesVertex);
  tmpvar_6.xyz = ((tmpvar_11.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_6.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11.xyz;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D unity_Lightmap;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 outDiffuse_1;
  mediump vec4 outEmission_2;
  mediump vec4 tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD3;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_5 = (((
    (texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_6.x)
   + 
    (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_6.y)
  ) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_6.z)) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_6.w));
  tmpvar_3 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, tmpvar_3.xy);
  mediump vec3 tmpvar_8;
  tmpvar_8 = (2.0 * tmpvar_7.xyz);
  mediump vec4 outDiffuseOcclusion_9;
  mediump vec4 outNormal_10;
  mediump vec4 emission_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_5;
  outDiffuseOcclusion_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((tmpvar_4 * 0.5) + 0.5);
  outNormal_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  emission_11 = tmpvar_14;
  emission_11.xyz = (emission_11.xyz + (tmpvar_5 * tmpvar_8));
  outDiffuse_1.xyz = outDiffuseOcclusion_9.xyz;
  outEmission_2.w = emission_11.w;
  outEmission_2.xyz = exp2(-(emission_11.xyz));
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = outNormal_10;
  gl_FragData[3] = outEmission_2;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
highp vec4 t0;
highp vec3 t1;
highp float t2;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD4.xyz = t0.xyz;
    t0.xyz = t0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD7.xyz = t0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD7.w = t2 * (-t0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
lowp vec3 t10_5;
mediump vec3 t16_6;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    SV_Target0.xyz = t10_4.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    t10_5.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_5.xyz;
    SV_Target2.w = 1.0;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    t10_5.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t16_6.xyz = t10_4.xyz * t10_5.xyz;
    SV_Target3.xyz = exp2((-t16_6.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  highp vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  highp vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_4 = worldNormal_1;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = vec2(0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = worldNormal_1;
  mediump vec4 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  x1_13.x = dot (unity_SHAr, normal_11);
  x1_13.y = dot (unity_SHAg, normal_11);
  x1_13.z = dot (unity_SHAb, normal_11);
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_11.xyzz * normal_11.yzzx);
  x2_12.x = dot (unity_SHBr, tmpvar_14);
  x2_12.y = dot (unity_SHBg, tmpvar_14);
  x2_12.z = dot (unity_SHBb, tmpvar_14);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = ((x2_12 + (unity_SHC.xyz * 
    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
  )) + x1_13);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 outDiffuse_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD3;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_3 = (((
    (texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_4.x)
   + 
    (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_4.y)
  ) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_4.z)) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_4.w));
  mediump vec4 outDiffuseOcclusion_5;
  mediump vec4 outNormal_6;
  mediump vec4 emission_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_3;
  outDiffuseOcclusion_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((tmpvar_2 * 0.5) + 0.5);
  outNormal_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  emission_7 = tmpvar_10;
  emission_7.xyz = (emission_7.xyz + (tmpvar_3 * xlv_TEXCOORD6));
  outDiffuse_1.xyz = outDiffuseOcclusion_5.xyz;
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = outNormal_6;
  gl_FragData[3] = emission_7;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
highp vec4 t0;
highp vec3 t1;
mediump vec4 t16_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
highp float t12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    t16_2.x = t0.y * t0.y;
    t16_2.x = t0.x * t0.x + (-t16_2.x);
    t16_1 = t0.yzzx * t0.xyzz;
    t16_3.x = dot(unity_SHBr, t16_1);
    t16_3.y = dot(unity_SHBg, t16_1);
    t16_3.z = dot(unity_SHBb, t16_1);
    t16_2.xyz = unity_SHC.xyz * t16_2.xxx + t16_3.xyz;
    t0.w = 1.0;
    t16_3.x = dot(unity_SHAr, t0);
    t16_3.y = dot(unity_SHAg, t0);
    t16_3.z = dot(unity_SHAb, t0);
    vs_TEXCOORD6.xyz = t16_2.xyz + t16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    SV_Target0.xyz = t10_4.xyz;
    SV_Target3.xyz = t10_4.xyz * vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    t10_4.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_4.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Control_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat3_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 v_7;
  v_7.x = _World2Object[0].x;
  v_7.y = _World2Object[1].x;
  v_7.z = _World2Object[2].x;
  v_7.w = _World2Object[3].x;
  highp vec4 v_8;
  v_8.x = _World2Object[0].y;
  v_8.y = _World2Object[1].y;
  v_8.z = _World2Object[2].y;
  v_8.w = _World2Object[3].y;
  highp vec4 v_9;
  v_9.x = _World2Object[0].z;
  v_9.y = _World2Object[1].z;
  v_9.z = _World2Object[2].z;
  v_9.w = _World2Object[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_4 = worldNormal_1;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_Object2World * _glesVertex);
  tmpvar_6.xyz = ((tmpvar_11.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_6.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Splat3_ST.xy) + _Splat3_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11.xyz;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D unity_Lightmap;
uniform sampler2D _Control;
uniform sampler2D _Splat0;
uniform sampler2D _Splat1;
uniform sampler2D _Splat2;
uniform sampler2D _Splat3;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 outDiffuse_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Control, xlv_TEXCOORD0.xy);
  tmpvar_4 = (((
    (texture2D (_Splat0, xlv_TEXCOORD0.zw).xyz * tmpvar_5.x)
   + 
    (texture2D (_Splat1, xlv_TEXCOORD1.xy).xyz * tmpvar_5.y)
  ) + (texture2D (_Splat2, xlv_TEXCOORD1.zw).xyz * tmpvar_5.z)) + (texture2D (_Splat3, xlv_TEXCOORD2).xyz * tmpvar_5.w));
  tmpvar_2 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, tmpvar_2.xy);
  mediump vec3 tmpvar_7;
  tmpvar_7 = (2.0 * tmpvar_6.xyz);
  mediump vec4 outDiffuseOcclusion_8;
  mediump vec4 outNormal_9;
  mediump vec4 emission_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_4;
  outDiffuseOcclusion_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((tmpvar_3 * 0.5) + 0.5);
  outNormal_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  emission_10 = tmpvar_13;
  emission_10.xyz = (emission_10.xyz + (tmpvar_4 * tmpvar_7));
  outDiffuse_1.xyz = outDiffuseOcclusion_8.xyz;
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = outNormal_9;
  gl_FragData[3] = emission_10;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
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
uniform 	lowp vec4 _LightColor0;
uniform 	lowp vec4 _SpecColor;
uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
uniform 	vec4 _Control_ST;
uniform 	vec4 _Splat0_ST;
uniform 	vec4 _Splat1_ST;
uniform 	vec4 _Splat2_ST;
uniform 	vec4 _Splat3_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
highp vec4 t0;
highp vec3 t1;
highp float t2;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Control_ST.xy + _Control_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Splat1_ST.xy + _Splat1_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _Splat2_ST.xy + _Splat2_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat3_ST.xy + _Splat3_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    t0.xyz = vec3(t6) * t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD4.xyz = t0.xyz;
    t0.xyz = t0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD7.xyz = t0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD7.w = t2 * (-t0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform lowp sampler2D _Control;
uniform lowp sampler2D _Splat0;
uniform lowp sampler2D _Splat1;
uniform lowp sampler2D _Splat2;
uniform lowp sampler2D _Splat3;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec4 t10_3;
lowp vec3 t10_4;
lowp vec3 t10_5;
void main()
{
    t10_0.xyz = texture(_Splat2, vs_TEXCOORD1.zw).xyz;
    t10_1.xyz = texture(_Splat0, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_Splat1, vs_TEXCOORD1.xy).xyz;
    t10_3 = texture(_Control, vs_TEXCOORD0.xy);
    t10_4.xyz = t10_2.xyz * t10_3.yyy;
    t10_4.xyz = t10_1.xyz * t10_3.xxx + t10_4.xyz;
    t10_4.xyz = t10_0.xyz * t10_3.zzz + t10_4.xyz;
    t10_0.xyz = texture(_Splat3, vs_TEXCOORD2.xy).xyz;
    t10_4.xyz = t10_0.xyz * t10_3.www + t10_4.xyz;
    SV_Target0.xyz = t10_4.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    t10_5.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_5.xyz;
    SV_Target2.w = 1.0;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    t10_5.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    SV_Target3.xyz = t10_4.xyz * t10_5.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLES3"
}
}
 }
}
Fallback "Diffuse"
}