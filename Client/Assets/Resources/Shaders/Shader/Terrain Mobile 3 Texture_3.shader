Shader "Artist/Scene/Terrain Mobile 3 Texture" {
Properties {
 _Layer1 ("Layer 1 (R)", 2D) = "white" { }
 _Layer2 ("Layer 2 (G)", 2D) = "white" { }
 _Layer3 ("Layer 3 (B)", 2D) = "white" { }
 _MainTex ("Control (RGB)", 2D) = "white" { }
}
SubShader { 
 Tags { "QUEUE"="Geometry+1" "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry+1" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 18946
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform mediump vec4 _Layer1_ST;
uniform mediump vec4 _Layer2_ST;
uniform mediump vec4 _Layer3_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer3_ST.xy) + _Layer3_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3.xy = tmpvar_5;
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
  mediump float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normalize(
    (((v_6.xyz * _glesNormal.x) + (v_7.xyz * _glesNormal.y)) + (v_8.xyz * _glesNormal.z))
  ), _WorldSpaceLightPos0.xyz), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  tmpvar_4.w = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
  xlv_TEXCOORD0_2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform sampler2D _Layer3;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 weights_1;
  mediump vec3 splat2_2;
  mediump vec3 splat1_3;
  mediump vec3 splat0_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Layer1, xlv_TEXCOORD0.xy).xyz;
  splat0_4 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Layer2, xlv_TEXCOORD0.zw).xyz;
  splat1_3 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Layer3, xlv_TEXCOORD0_1.xy).xyz;
  splat2_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_2.xy);
  weights_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (((
    (weights_1.x * splat0_4)
   + 
    (weights_1.y * splat1_3)
  ) + (weights_1.z * splat2_2)) * ((_LightColor0.xyz * xlv_TEXCOORD4.w) + (glstate_lightmodel_ambient * 2.0).xyz));
  gl_FragData[0] = tmpvar_9;
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    t0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD0 = t0;
    t0.xy = in_TEXCOORD0.xy * _Layer3_ST.xy + _Layer3_ST.zw;
    vs_TEXCOORD1.xy = t0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
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
    t0.x = dot(t0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = clamp(t0.x, 0.0, 1.0);
    vs_TEXCOORD4.w = t0.x;
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _Layer3;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    t16_3.xyz = t10_1.xyz * t10_2.yyy;
    t16_3.xyz = t10_2.xxx * t10_0.xyz + t16_3.xyz;
    t10_0.xyz = texture(_Layer3, vs_TEXCOORD1.xy).xyz;
    t16_3.xyz = t10_2.zzz * t10_0.xyz + t16_3.xyz;
    t10_4.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0);
    t16_5.xyz = _LightColor0.xyz * vs_TEXCOORD4.www + t10_4.xyz;
    SV_Target0.xyz = t16_3.xyz * t16_5.xyz;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LightmapST;
uniform mediump vec4 _Layer1_ST;
uniform mediump vec4 _Layer2_ST;
uniform mediump vec4 _Layer3_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer3_ST.xy) + _Layer3_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3.xy = tmpvar_5;
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
  mediump float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normalize(
    (((v_6.xyz * _glesNormal.x) + (v_7.xyz * _glesNormal.y)) + (v_8.xyz * _glesNormal.z))
  ), _WorldSpaceLightPos0.xyz), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4.w = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
  xlv_TEXCOORD0_2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform sampler2D _Layer3;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 weights_1;
  mediump vec3 splat2_2;
  mediump vec3 splat1_3;
  mediump vec3 splat0_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Layer1, xlv_TEXCOORD0.xy).xyz;
  splat0_4 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Layer2, xlv_TEXCOORD0.zw).xyz;
  splat1_3 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Layer3, xlv_TEXCOORD0_1.xy).xyz;
  splat2_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_2.xy);
  weights_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD4.xy);
  mediump vec3 tmpvar_10;
  tmpvar_10 = (2.0 * tmpvar_9.xyz);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (((
    (weights_1.x * splat0_4)
   + 
    (weights_1.y * splat1_3)
  ) + (weights_1.z * splat2_2)) * ((_LightColor0.xyz * xlv_TEXCOORD4.w) + tmpvar_10));
  gl_FragData[0] = tmpvar_11;
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    t0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD0 = t0;
    t0.xy = in_TEXCOORD0.xy * _Layer3_ST.xy + _Layer3_ST.zw;
    vs_TEXCOORD1.xy = t0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
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
    t0.x = dot(t0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = clamp(t0.x, 0.0, 1.0);
    vs_TEXCOORD4.w = t0.x;
    t0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = t0.xy;
    vs_TEXCOORD4.z = 0.0;
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _Layer3;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D unity_Lightmap;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    t16_3.xyz = t10_1.xyz * t10_2.yyy;
    t16_3.xyz = t10_2.xxx * t10_0.xyz + t16_3.xyz;
    t10_0.xyz = texture(_Layer3, vs_TEXCOORD1.xy).xyz;
    t16_3.xyz = t10_2.zzz * t10_0.xyz + t16_3.xyz;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    t10_4.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t16_5.xyz = _LightColor0.xyz * vs_TEXCOORD4.www + t10_4.xyz;
    SV_Target0.xyz = t16_3.xyz * t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform mediump vec4 _Layer1_ST;
uniform mediump vec4 _Layer2_ST;
uniform mediump vec4 _Layer3_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer3_ST.xy) + _Layer3_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3.xy = tmpvar_5;
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
  mediump float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normalize(
    (((v_6.xyz * _glesNormal.x) + (v_7.xyz * _glesNormal.y)) + (v_8.xyz * _glesNormal.z))
  ), _WorldSpaceLightPos0.xyz), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  tmpvar_4.w = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
  xlv_TEXCOORD0_2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform sampler2D _Layer3;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 weights_1;
  mediump vec3 splat2_2;
  mediump vec3 splat1_3;
  mediump vec3 splat0_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Layer1, xlv_TEXCOORD0.xy).xyz;
  splat0_4 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Layer2, xlv_TEXCOORD0.zw).xyz;
  splat1_3 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Layer3, xlv_TEXCOORD0_1.xy).xyz;
  splat2_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_2.xy);
  weights_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (((
    (weights_1.x * splat0_4)
   + 
    (weights_1.y * splat1_3)
  ) + (weights_1.z * splat2_2)) * ((_LightColor0.xyz * xlv_TEXCOORD4.w) + (glstate_lightmodel_ambient * 2.0).xyz));
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LightmapST;
uniform mediump vec4 _Layer1_ST;
uniform mediump vec4 _Layer2_ST;
uniform mediump vec4 _Layer3_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer3_ST.xy) + _Layer3_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3.xy = tmpvar_5;
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
  mediump float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normalize(
    (((v_6.xyz * _glesNormal.x) + (v_7.xyz * _glesNormal.y)) + (v_8.xyz * _glesNormal.z))
  ), _WorldSpaceLightPos0.xyz), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4.w = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
  xlv_TEXCOORD0_2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform sampler2D _Layer3;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 weights_1;
  mediump vec3 splat2_2;
  mediump vec3 splat1_3;
  mediump vec3 splat0_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Layer1, xlv_TEXCOORD0.xy).xyz;
  splat0_4 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Layer2, xlv_TEXCOORD0.zw).xyz;
  splat1_3 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Layer3, xlv_TEXCOORD0_1.xy).xyz;
  splat2_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_2.xy);
  weights_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD4.xy);
  mediump vec3 tmpvar_10;
  tmpvar_10 = (2.0 * tmpvar_9.xyz);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (((
    (weights_1.x * splat0_4)
   + 
    (weights_1.y * splat1_3)
  ) + (weights_1.z * splat2_2)) * ((_LightColor0.xyz * xlv_TEXCOORD4.w) + tmpvar_10));
  gl_FragData[0] = tmpvar_11;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform mediump vec4 _Layer1_ST;
uniform mediump vec4 _Layer2_ST;
uniform mediump vec4 _Layer3_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer3_ST.xy) + _Layer3_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3.xy = tmpvar_5;
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
  mediump float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normalize(
    (((v_6.xyz * _glesNormal.x) + (v_7.xyz * _glesNormal.y)) + (v_8.xyz * _glesNormal.z))
  ), _WorldSpaceLightPos0.xyz), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  tmpvar_4.w = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
  xlv_TEXCOORD0_2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform sampler2D _Layer3;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 weights_1;
  mediump vec3 splat2_2;
  mediump vec3 splat1_3;
  mediump vec3 splat0_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Layer1, xlv_TEXCOORD0.xy).xyz;
  splat0_4 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Layer2, xlv_TEXCOORD0.zw).xyz;
  splat1_3 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Layer3, xlv_TEXCOORD0_1.xy).xyz;
  splat2_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_2.xy);
  weights_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (((
    (weights_1.x * splat0_4)
   + 
    (weights_1.y * splat1_3)
  ) + (weights_1.z * splat2_2)) * ((_LightColor0.xyz * xlv_TEXCOORD4.w) + (glstate_lightmodel_ambient * 2.0).xyz));
  gl_FragData[0] = tmpvar_9;
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    t0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD0 = t0;
    t0.xy = in_TEXCOORD0.xy * _Layer3_ST.xy + _Layer3_ST.zw;
    vs_TEXCOORD1.xy = t0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
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
    t0.x = dot(t0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = clamp(t0.x, 0.0, 1.0);
    vs_TEXCOORD4.w = t0.x;
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _Layer3;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    t16_3.xyz = t10_1.xyz * t10_2.yyy;
    t16_3.xyz = t10_2.xxx * t10_0.xyz + t16_3.xyz;
    t10_0.xyz = texture(_Layer3, vs_TEXCOORD1.xy).xyz;
    t16_3.xyz = t10_2.zzz * t10_0.xyz + t16_3.xyz;
    t10_4.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0);
    t16_5.xyz = _LightColor0.xyz * vs_TEXCOORD4.www + t10_4.xyz;
    SV_Target0.xyz = t16_3.xyz * t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform mediump vec4 _Layer1_ST;
uniform mediump vec4 _Layer2_ST;
uniform mediump vec4 _Layer3_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer3_ST.xy) + _Layer3_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3.xy = tmpvar_5;
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
  mediump float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normalize(
    (((v_6.xyz * _glesNormal.x) + (v_7.xyz * _glesNormal.y)) + (v_8.xyz * _glesNormal.z))
  ), _WorldSpaceLightPos0.xyz), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  tmpvar_4.w = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
  xlv_TEXCOORD0_2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform sampler2D _Layer3;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 weights_1;
  mediump vec3 splat2_2;
  mediump vec3 splat1_3;
  mediump vec3 splat0_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Layer1, xlv_TEXCOORD0.xy).xyz;
  splat0_4 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Layer2, xlv_TEXCOORD0.zw).xyz;
  splat1_3 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Layer3, xlv_TEXCOORD0_1.xy).xyz;
  splat2_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_2.xy);
  weights_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (((
    (weights_1.x * splat0_4)
   + 
    (weights_1.y * splat1_3)
  ) + (weights_1.z * splat2_2)) * ((_LightColor0.xyz * xlv_TEXCOORD4.w) + (glstate_lightmodel_ambient * 2.0).xyz));
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform mediump vec4 _Layer1_ST;
uniform mediump vec4 _Layer2_ST;
uniform mediump vec4 _Layer3_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer3_ST.xy) + _Layer3_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3.xy = tmpvar_5;
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
  mediump float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normalize(
    (((v_6.xyz * _glesNormal.x) + (v_7.xyz * _glesNormal.y)) + (v_8.xyz * _glesNormal.z))
  ), _WorldSpaceLightPos0.xyz), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  tmpvar_4.w = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
  xlv_TEXCOORD0_2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform sampler2D _Layer3;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 weights_1;
  mediump vec3 splat2_2;
  mediump vec3 splat1_3;
  mediump vec3 splat0_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Layer1, xlv_TEXCOORD0.xy).xyz;
  splat0_4 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Layer2, xlv_TEXCOORD0.zw).xyz;
  splat1_3 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Layer3, xlv_TEXCOORD0_1.xy).xyz;
  splat2_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_2.xy);
  weights_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (((
    (weights_1.x * splat0_4)
   + 
    (weights_1.y * splat1_3)
  ) + (weights_1.z * splat2_2)) * ((_LightColor0.xyz * xlv_TEXCOORD4.w) + (glstate_lightmodel_ambient * 2.0).xyz));
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    t0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD0 = t0;
    t0.xy = in_TEXCOORD0.xy * _Layer3_ST.xy + _Layer3_ST.zw;
    vs_TEXCOORD1.xy = t0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
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
    t0.x = dot(t0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = clamp(t0.x, 0.0, 1.0);
    vs_TEXCOORD4.w = t0.x;
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _Layer3;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    t16_3.xyz = t10_1.xyz * t10_2.yyy;
    t16_3.xyz = t10_2.xxx * t10_0.xyz + t16_3.xyz;
    t10_0.xyz = texture(_Layer3, vs_TEXCOORD1.xy).xyz;
    t16_3.xyz = t10_2.zzz * t10_0.xyz + t16_3.xyz;
    t10_4.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0);
    t16_5.xyz = _LightColor0.xyz * vs_TEXCOORD4.www + t10_4.xyz;
    SV_Target0.xyz = t16_3.xyz * t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LightmapST;
uniform mediump vec4 _Layer1_ST;
uniform mediump vec4 _Layer2_ST;
uniform mediump vec4 _Layer3_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer3_ST.xy) + _Layer3_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3.xy = tmpvar_5;
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
  mediump float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normalize(
    (((v_6.xyz * _glesNormal.x) + (v_7.xyz * _glesNormal.y)) + (v_8.xyz * _glesNormal.z))
  ), _WorldSpaceLightPos0.xyz), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4.w = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
  xlv_TEXCOORD0_2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform sampler2D unity_Lightmap;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform sampler2D _Layer3;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 weights_1;
  mediump vec3 splat2_2;
  mediump vec3 splat1_3;
  mediump vec3 splat0_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Layer1, xlv_TEXCOORD0.xy).xyz;
  splat0_4 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Layer2, xlv_TEXCOORD0.zw).xyz;
  splat1_3 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Layer3, xlv_TEXCOORD0_1.xy).xyz;
  splat2_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_2.xy);
  weights_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD4.xy);
  mediump vec3 tmpvar_10;
  tmpvar_10 = (2.0 * tmpvar_9.xyz);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (((
    (weights_1.x * splat0_4)
   + 
    (weights_1.y * splat1_3)
  ) + (weights_1.z * splat2_2)) * ((_LightColor0.xyz * xlv_TEXCOORD4.w) + tmpvar_10));
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    t0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD0 = t0;
    t0.xy = in_TEXCOORD0.xy * _Layer3_ST.xy + _Layer3_ST.zw;
    vs_TEXCOORD1.xy = t0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
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
    t0.x = dot(t0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = clamp(t0.x, 0.0, 1.0);
    vs_TEXCOORD4.w = t0.x;
    t0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = t0.xy;
    vs_TEXCOORD4.z = 0.0;
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _Layer3;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D unity_Lightmap;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    t16_3.xyz = t10_1.xyz * t10_2.yyy;
    t16_3.xyz = t10_2.xxx * t10_0.xyz + t16_3.xyz;
    t10_0.xyz = texture(_Layer3, vs_TEXCOORD1.xy).xyz;
    t16_3.xyz = t10_2.zzz * t10_0.xyz + t16_3.xyz;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    t10_4.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t16_5.xyz = _LightColor0.xyz * vs_TEXCOORD4.www + t10_4.xyz;
    SV_Target0.xyz = t16_3.xyz * t16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#version 100

#ifdef VERTEX
#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform mediump vec4 _Layer1_ST;
uniform mediump vec4 _Layer2_ST;
uniform mediump vec4 _Layer3_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer3_ST.xy) + _Layer3_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3.xy = tmpvar_5;
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
  mediump float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (normalize(
    (((v_6.xyz * _glesNormal.x) + (v_7.xyz * _glesNormal.y)) + (v_8.xyz * _glesNormal.z))
  ), _WorldSpaceLightPos0.xyz), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  tmpvar_4.w = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
  xlv_TEXCOORD0_2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform sampler2D _Layer3;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 weights_1;
  mediump vec3 splat2_2;
  mediump vec3 splat1_3;
  mediump vec3 splat0_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Layer1, xlv_TEXCOORD0.xy).xyz;
  splat0_4 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Layer2, xlv_TEXCOORD0.zw).xyz;
  splat1_3 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Layer3, xlv_TEXCOORD0_1.xy).xyz;
  splat2_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0_2.xy);
  weights_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (((
    (weights_1.x * splat0_4)
   + 
    (weights_1.y * splat1_3)
  ) + (weights_1.z * splat2_2)) * ((_LightColor0.xyz * xlv_TEXCOORD4.w) + (glstate_lightmodel_ambient * 2.0).xyz));
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    t0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD0 = t0;
    t0.xy = in_TEXCOORD0.xy * _Layer3_ST.xy + _Layer3_ST.zw;
    vs_TEXCOORD1.xy = t0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
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
    t0.x = dot(t0.xyz, _WorldSpaceLightPos0.xyz);
    t0.x = clamp(t0.x, 0.0, 1.0);
    vs_TEXCOORD4.w = t0.x;
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Layer1_ST;
uniform 	mediump vec4 _Layer2_ST;
uniform 	mediump vec4 _Layer3_ST;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _Layer3;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    t16_3.xyz = t10_1.xyz * t10_2.yyy;
    t16_3.xyz = t10_2.xxx * t10_0.xyz + t16_3.xyz;
    t10_0.xyz = texture(_Layer3, vs_TEXCOORD1.xy).xyz;
    t16_3.xyz = t10_2.zzz * t10_0.xyz + t16_3.xyz;
    t10_4.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0);
    t16_5.xyz = _LightColor0.xyz * vs_TEXCOORD4.www + t10_4.xyz;
    SV_Target0.xyz = t16_3.xyz * t16_5.xyz;
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLES3"
}
}
 }
}
}