Shader "TerrainForMobile/2TexturesDiffuseSimple" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _Layer1 ("Layer1 (RGB)", 2D) = "white" { }
 _Layer2 ("Layer2 (RGB)", 2D) = "white" { }
 _MainTex ("Mask (RGB)", 2D) = "white" { }
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 55415
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  highp vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  highp vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  highp vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_3 = worldNormal_1;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = worldNormal_1;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 x2_10;
  mediump vec3 x1_11;
  x1_11.x = dot (unity_SHAr, normal_9);
  x1_11.y = dot (unity_SHAg, normal_9);
  x1_11.z = dot (unity_SHAb, normal_9);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_9.xyzz * normal_9.yzzx);
  x2_10.x = dot (unity_SHBr, tmpvar_12);
  x2_10.y = dot (unity_SHBg, tmpvar_12);
  x2_10.z = dot (unity_SHBb, tmpvar_12);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((x2_10 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )) + x1_11);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD4;
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
  tmpvar_4 = xlv_TEXCOORD2;
  lowp vec3 tmpvar_7;
  lowp vec4 lay_8;
  mediump vec4 Mask_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_9 = tmpvar_10;
  lay_8 = (Mask_9.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_8 = (lay_8 + (Mask_9.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  tmpvar_7 = (lay_8.xyz * _Color.xyz);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_11;
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  c_11.w = c_12.w;
  c_11.xyz = (c_12.xyz + (tmpvar_7 * xlv_TEXCOORD4));
  c_3.xyz = c_11.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
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
    vs_TEXCOORD4.xyz = t16_2.xyz + t16_3.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
lowp vec3 t10_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec2 t10_2;
lowp vec3 t10_3;
mediump vec3 t16_4;
mediump vec3 t16_5;
mediump float t16_22;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_1.xyz = t10_1.xyz * t10_2.yyy;
    t16_0.xyz = t10_2.xxx * t10_0.xyz + t16_1.xyz;
    t10_3.xyz = t16_0.xyz * _Color.xyz;
    t16_4.xyz = t10_3.xyz * _LightColor0.xyz;
    t16_5.xyz = t10_3.xyz * vs_TEXCOORD4.xyz;
    t16_22 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    t16_22 = max(t16_22, 0.0);
    t16_4.xyz = t16_4.xyz * vec3(t16_22) + t16_5.xyz;
    SV_Target0.xyz = t16_4.xyz;
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
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
  tmpvar_3 = worldNormal_1;
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 c_2;
  lowp vec4 lay_3;
  mediump vec4 Mask_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_4 = tmpvar_5;
  lay_3 = (Mask_4.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_3 = (lay_3 + (Mask_4.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  tmpvar_1 = xlv_TEXCOORD4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, tmpvar_1.xy);
  mediump vec3 tmpvar_7;
  tmpvar_7 = (2.0 * tmpvar_6.xyz);
  lowp vec4 c_8;
  c_8.w = 0.0;
  c_8.xyz = ((lay_3.xyz * _Color.xyz) * tmpvar_7);
  c_2.xyz = c_8.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
lowp vec3 t10_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec2 t10_2;
lowp vec3 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_1.xyz = t10_1.xyz * t10_2.yyy;
    t16_0.xyz = t10_2.xxx * t10_0.xyz + t16_1.xyz;
    t10_3.xyz = t16_0.xyz * _Color.xyz;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    t10_4.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t16_5.xyz = t10_3.xyz * t10_4.xyz;
    SV_Target0.xyz = t16_5.xyz;
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
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
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
  tmpvar_3 = worldNormal_1;
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
  highp vec4 tmpvar_14;
  tmpvar_14 = (_Object2World * _glesVertex);
  tmpvar_4 = (unity_World2Shadow[0] * tmpvar_14);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_14.xyz;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )) + x1_12);
  xlv_TEXCOORD5 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD2;
  lowp vec3 tmpvar_8;
  lowp vec4 lay_9;
  mediump vec4 Mask_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_10 = tmpvar_11;
  lay_9 = (Mask_10.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_9 = (lay_9 + (Mask_10.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  tmpvar_8 = (lay_9.xyz * _Color.xyz);
  lowp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (float((texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x > 
    (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w)
  )), _LightShadowData.x);
  tmpvar_12 = tmpvar_13;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_12;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_14;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_14) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = (c_16.xyz + (tmpvar_8 * xlv_TEXCOORD4));
  c_4.xyz = c_15.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
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
  tmpvar_3 = worldNormal_1;
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * _glesVertex);
  tmpvar_5 = (unity_World2Shadow[0] * tmpvar_10);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10.xyz;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform sampler2D unity_Lightmap;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec4 tmpvar_2;
  lowp vec4 c_3;
  lowp vec4 lay_4;
  mediump vec4 Mask_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_5 = tmpvar_6;
  lay_4 = (Mask_5.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_4 = (lay_4 + (Mask_5.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  lowp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x > 
    (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w)
  )), _LightShadowData.x);
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD4;
  mediump vec3 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, tmpvar_2.xy);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (2.0 * tmpvar_10.xyz);
  tmpvar_9 = max (min (tmpvar_11, (tmpvar_10.xyz * tmpvar_1)), (tmpvar_11 * tmpvar_1));
  lowp vec4 c_12;
  c_12.w = 0.0;
  c_12.xyz = ((lay_4.xyz * _Color.xyz) * tmpvar_9);
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
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
  tmpvar_3 = worldNormal_1;
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
  highp vec4 tmpvar_14;
  tmpvar_14 = (_Object2World * _glesVertex);
  tmpvar_4 = (unity_World2Shadow[0] * tmpvar_14);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_14.xyz;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )) + x1_12);
  xlv_TEXCOORD5 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD2;
  lowp vec3 tmpvar_8;
  lowp vec4 lay_9;
  mediump vec4 Mask_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_10 = tmpvar_11;
  lay_9 = (Mask_10.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_9 = (lay_9 + (Mask_10.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  tmpvar_8 = (lay_9.xyz * _Color.xyz);
  lowp float shadow_12;
  shadow_12 = (_LightShadowData.x + (shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz) * (1.0 - _LightShadowData.x)));
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = shadow_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_13) * diff_16);
  c_15.w = 0.0;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8 * xlv_TEXCOORD4));
  c_4.xyz = c_14.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
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
    vs_TEXCOORD4.xyz = t16_2.xyz + t16_3.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1 = t0.yyyy * unity_World2Shadow[0][1];
    t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
    t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
    t0 = unity_World2Shadow[0][3] * t0.wwww + t1;
    vs_TEXCOORD5 = t0;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
mediump vec3 t16_2;
lowp vec3 t10_2;
lowp vec2 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump float t16_6;
mediump float t16_18;
void main()
{
    vec3 txVec10 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
    t16_0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec10, 0.0);
    t16_6 = (-_LightShadowData.x) + 1.0;
    t16_0.x = t16_0.x * t16_6 + _LightShadowData.x;
    t16_0.xyz = t16_0.xxx * _LightColor0.xyz;
    t10_1.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_2.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_3.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_2.xyz = t10_2.xyz * t10_3.yyy;
    t16_1.xyz = t10_3.xxx * t10_1.xyz + t16_2.xyz;
    t10_4.xyz = t16_1.xyz * _Color.xyz;
    t16_0.xyz = t16_0.xyz * t10_4.xyz;
    t16_5.xyz = t10_4.xyz * vs_TEXCOORD4.xyz;
    t16_18 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    t16_18 = max(t16_18, 0.0);
    t16_0.xyz = t16_0.xyz * vec3(t16_18) + t16_5.xyz;
    SV_Target0.xyz = t16_0.xyz;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
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
  tmpvar_3 = worldNormal_1;
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * _glesVertex);
  tmpvar_5 = (unity_World2Shadow[0] * tmpvar_10);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10.xyz;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform mediump vec4 _LightShadowData;
uniform sampler2D unity_Lightmap;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec4 tmpvar_2;
  lowp vec4 c_3;
  lowp vec4 lay_4;
  mediump vec4 Mask_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_5 = tmpvar_6;
  lay_4 = (Mask_5.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_4 = (lay_4 + (Mask_5.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  lowp float shadow_7;
  shadow_7 = (_LightShadowData.x + (shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz) * (1.0 - _LightShadowData.x)));
  tmpvar_1 = shadow_7;
  tmpvar_2 = xlv_TEXCOORD4;
  mediump vec3 tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, tmpvar_2.xy);
  mediump vec3 tmpvar_10;
  tmpvar_10 = (2.0 * tmpvar_9.xyz);
  tmpvar_8 = max (min (tmpvar_10, (tmpvar_9.xyz * tmpvar_1)), (tmpvar_10 * tmpvar_1));
  lowp vec4 c_11;
  c_11.w = 0.0;
  c_11.xyz = ((lay_4.xyz * _Color.xyz) * tmpvar_8);
  c_3.xyz = c_11.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
highp vec4 t0;
highp vec4 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1 = t0.yyyy * unity_World2Shadow[0][1];
    t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
    t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
    t0 = unity_World2Shadow[0][3] * t0.wwww + t1;
    vs_TEXCOORD5 = t0;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D unity_Lightmap;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
mediump vec3 t16_4;
lowp vec3 t10_4;
lowp vec2 t10_5;
mediump vec3 t16_6;
void main()
{
    vec3 txVec10 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
    t16_0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec10, 0.0);
    t16_6.x = (-_LightShadowData.x) + 1.0;
    t16_0.x = t16_0.x * t16_6.x + _LightShadowData.x;
    t10_1.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    t16_6.xyz = t16_0.xxx * t10_1.xyz;
    t10_2.xyz = t10_1.xyz * vec3(2.0, 2.0, 2.0);
    t16_6.xyz = min(t16_6.xyz, t10_2.xyz);
    t16_3.xyz = t16_0.xxx * t10_2.xyz;
    t16_0.xyz = max(t16_6.xyz, t16_3.xyz);
    t10_1.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_4.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_5.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_4.xyz = t10_4.xyz * t10_5.yyy;
    t16_1.xyz = t10_5.xxx * t10_1.xyz + t16_4.xyz;
    t10_2.xyz = t16_1.xyz * _Color.xyz;
    t16_0.xyz = t16_0.xyz * t10_2.xyz;
    SV_Target0.xyz = t16_0.xyz;
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
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Blend One One
  GpuProgramID 126690
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  highp vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  highp vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  highp vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD3));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD2;
  lowp vec4 lay_7;
  mediump vec4 Mask_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_8 = tmpvar_9;
  lay_7 = (Mask_8.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_7 = (lay_7 + (Mask_8.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD3;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10).xyz;
  highp float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, tmpvar_11);
  lowp float tmpvar_13;
  tmpvar_13 = texture2D (_LightTexture0, vec2(tmpvar_12)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_13);
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((lay_7.xyz * _Color.xyz) * (tmpvar_1 * diff_16));
  c_15.w = 0.0;
  c_14.w = c_15.w;
  c_14.xyz = c_15.xyz;
  c_3.xyz = c_14.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _LightTexture0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
highp vec3 t1;
mediump vec3 t16_1;
lowp vec3 t10_1;
mediump vec3 t16_2;
lowp vec3 t10_2;
lowp vec2 t10_3;
lowp vec3 t10_4;
mediump float t16_15;
highp float t16;
void main()
{
    t16_0.xyz = vs_TEXCOORD3.yyy * _LightMatrix0[1].xyz;
    t16_0.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD3.xxx + t16_0.xyz;
    t16_0.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD3.zzz + t16_0.xyz;
    t16_0.xyz = t16_0.xyz + _LightMatrix0[3].xyz;
    t16_1.x = dot(t16_0.xyz, t16_0.xyz);
    t10_1.x = texture(_LightTexture0, t16_1.xx).w;
    t16_0.xyz = t10_1.xxx * _LightColor0.xyz;
    t10_1.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_2.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_3.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_2.xyz = t10_2.xyz * t10_3.yyy;
    t16_1.xyz = t10_3.xxx * t10_1.xyz + t16_2.xyz;
    t10_4.xyz = t16_1.xyz * _Color.xyz;
    t16_0.xyz = t16_0.xyz * t10_4.xyz;
    t1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
    t16 = dot(t1.xyz, t1.xyz);
    t16 = inversesqrt(t16);
    t1.xyz = vec3(t16) * t1.xyz;
    t16_15 = dot(vs_TEXCOORD2.xyz, t1.xyz);
    t16_15 = max(t16_15, 0.0);
    t16_0.xyz = vec3(t16_15) * t16_0.xyz;
    SV_Target0.xyz = t16_0.xyz;
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  highp vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  highp vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  highp vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD2;
  lowp vec4 lay_7;
  mediump vec4 Mask_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_8 = tmpvar_9;
  lay_7 = (Mask_8.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_7 = (lay_7 + (Mask_8.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_10;
  lowp vec4 c_11;
  lowp float diff_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_12 = tmpvar_13;
  c_11.xyz = ((lay_7.xyz * _Color.xyz) * (tmpvar_1 * diff_12));
  c_11.w = 0.0;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_3.xyz = c_10.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
lowp vec3 t10_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec2 t10_2;
lowp vec3 t10_3;
mediump vec3 t16_4;
mediump float t16_19;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_1.xyz = t10_1.xyz * t10_2.yyy;
    t16_0.xyz = t10_2.xxx * t10_0.xyz + t16_1.xyz;
    t10_3.xyz = t16_0.xyz * _Color.xyz;
    t16_4.xyz = t10_3.xyz * _LightColor0.xyz;
    t16_19 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    t16_19 = max(t16_19, 0.0);
    t16_4.xyz = vec3(t16_19) * t16_4.xyz;
    SV_Target0.xyz = t16_4.xyz;
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  highp vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  highp vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  highp vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD3));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD2;
  lowp vec4 lay_9;
  mediump vec4 Mask_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_10 = tmpvar_11;
  lay_9 = (Mask_10.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_9 = (lay_9 + (Mask_10.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_LightMatrix0 * tmpvar_12);
  lightCoord_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  mediump vec2 P_15;
  P_15 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
  tmpvar_14 = texture2D (_LightTexture0, P_15);
  highp vec3 LightCoord_16;
  LightCoord_16 = lightCoord_5.xyz;
  highp float tmpvar_17;
  tmpvar_17 = dot (LightCoord_16, LightCoord_16);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_LightTextureB0, vec2(tmpvar_17));
  mediump float tmpvar_19;
  tmpvar_19 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_14.w) * tmpvar_18.w);
  atten_4 = tmpvar_19;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_20;
  lowp vec4 c_21;
  lowp float diff_22;
  mediump float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_22 = tmpvar_23;
  c_21.xyz = ((lay_9.xyz * _Color.xyz) * (tmpvar_1 * diff_22));
  c_21.w = 0.0;
  c_20.w = c_21.w;
  c_20.xyz = c_21.xyz;
  c_3.xyz = c_20.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _LightTexture0;
uniform lowp sampler2D _LightTextureB0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec2 t16_1;
highp vec3 t2;
mediump vec3 t16_2;
lowp vec3 t10_2;
lowp vec3 t10_3;
mediump vec3 t16_4;
lowp vec3 t10_4;
lowp vec2 t10_5;
bool tb8;
mediump float t16_14;
lowp float t10_14;
mediump float t16_18;
highp float t20;
void main()
{
    t16_0 = vs_TEXCOORD3.yyyy * _LightMatrix0[1];
    t16_0 = _LightMatrix0[0] * vs_TEXCOORD3.xxxx + t16_0;
    t16_0 = _LightMatrix0[2] * vs_TEXCOORD3.zzzz + t16_0;
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
    t10_2.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_4.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_5.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_4.xyz = t10_4.xyz * t10_5.yyy;
    t16_2.xyz = t10_5.xxx * t10_2.xyz + t16_4.xyz;
    t10_3.xyz = t16_2.xyz * _Color.xyz;
    t16_0.xyz = t16_0.xyz * t10_3.xyz;
    t2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
    t20 = dot(t2.xyz, t2.xyz);
    t20 = inversesqrt(t20);
    t2.xyz = vec3(t20) * t2.xyz;
    t16_18 = dot(vs_TEXCOORD2.xyz, t2.xyz);
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  highp vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  highp vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  highp vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD3));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD2;
  lowp vec4 lay_7;
  mediump vec4 Mask_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_8 = tmpvar_9;
  lay_7 = (Mask_8.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_7 = (lay_7 + (Mask_8.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD3;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10).xyz;
  highp float tmpvar_12;
  tmpvar_12 = dot (tmpvar_11, tmpvar_11);
  lowp float tmpvar_13;
  tmpvar_13 = (texture2D (_LightTextureB0, vec2(tmpvar_12)).w * textureCube (_LightTexture0, tmpvar_11).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_13);
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((lay_7.xyz * _Color.xyz) * (tmpvar_1 * diff_16));
  c_15.w = 0.0;
  c_14.w = c_15.w;
  c_14.xyz = c_15.xyz;
  c_3.xyz = c_14.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _LightTextureB0;
uniform lowp samplerCube _LightTexture0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
highp vec3 t1;
mediump vec3 t16_1;
lowp vec3 t10_1;
mediump vec3 t16_2;
lowp vec3 t10_2;
lowp vec2 t10_3;
lowp vec3 t10_4;
lowp float t10_6;
mediump float t16_15;
highp float t16;
void main()
{
    t16_0.xyz = vs_TEXCOORD3.yyy * _LightMatrix0[1].xyz;
    t16_0.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD3.xxx + t16_0.xyz;
    t16_0.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD3.zzz + t16_0.xyz;
    t16_0.xyz = t16_0.xyz + _LightMatrix0[3].xyz;
    t16_1.x = dot(t16_0.xyz, t16_0.xyz);
    t10_6 = texture(_LightTexture0, t16_0.xyz).w;
    t10_1.x = texture(_LightTextureB0, t16_1.xx).w;
    t16_1.x = t10_6 * t10_1.x;
    t16_0.xyz = t16_1.xxx * _LightColor0.xyz;
    t10_1.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_2.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_3.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_2.xyz = t10_2.xyz * t10_3.yyy;
    t16_1.xyz = t10_3.xxx * t10_1.xyz + t16_2.xyz;
    t10_4.xyz = t16_1.xyz * _Color.xyz;
    t16_0.xyz = t16_0.xyz * t10_4.xyz;
    t1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
    t16 = dot(t1.xyz, t1.xyz);
    t16 = inversesqrt(t16);
    t1.xyz = vec3(t16) * t1.xyz;
    t16_15 = dot(vs_TEXCOORD2.xyz, t1.xyz);
    t16_15 = max(t16_15, 0.0);
    t16_0.xyz = vec3(t16_15) * t16_0.xyz;
    SV_Target0.xyz = t16_0.xyz;
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
  highp vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  highp vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  highp vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
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
  tmpvar_4 = xlv_TEXCOORD2;
  lowp vec4 lay_7;
  mediump vec4 Mask_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_8 = tmpvar_9;
  lay_7 = (Mask_8.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_7 = (lay_7 + (Mask_8.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD3;
  highp vec2 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10).xy;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, tmpvar_11).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_12);
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((lay_7.xyz * _Color.xyz) * (tmpvar_1 * diff_15));
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = c_14.xyz;
  c_3.xyz = c_13.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D _LightTexture0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
lowp vec3 t10_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec2 t10_2;
lowp vec3 t10_3;
mediump vec3 t16_4;
mediump float t16_19;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_1.xyz = t10_1.xyz * t10_2.yyy;
    t16_0.xyz = t10_2.xxx * t10_0.xyz + t16_1.xyz;
    t10_3.xyz = t16_0.xyz * _Color.xyz;
    t16_4.xy = vs_TEXCOORD3.yy * _LightMatrix0[1].xy;
    t16_4.xy = _LightMatrix0[0].xy * vs_TEXCOORD3.xx + t16_4.xy;
    t16_4.xy = _LightMatrix0[2].xy * vs_TEXCOORD3.zz + t16_4.xy;
    t16_4.xy = t16_4.xy + _LightMatrix0[3].xy;
    t10_0.x = texture(_LightTexture0, t16_4.xy).w;
    t16_4.xyz = t10_0.xxx * _LightColor0.xyz;
    t16_4.xyz = t10_3.xyz * t16_4.xyz;
    t16_19 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    t16_19 = max(t16_19, 0.0);
    t16_4.xyz = vec3(t16_19) * t16_4.xyz;
    SV_Target0.xyz = t16_4.xyz;
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
}
 }
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "RenderType"="Opaque" }
  GpuProgramID 163862
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
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
  tmpvar_3 = worldNormal_1;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
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
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = ((x2_11 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )) + x1_12);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 outDiffuse_1;
  mediump vec4 outEmission_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD2;
  lowp vec3 tmpvar_4;
  lowp vec4 lay_5;
  mediump vec4 Mask_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_6 = tmpvar_7;
  lay_5 = (Mask_6.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_5 = (lay_5 + (Mask_6.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  tmpvar_4 = (lay_5.xyz * _Color.xyz);
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
  emission_10.xyz = (emission_10.xyz + (tmpvar_4 * xlv_TEXCOORD5));
  outDiffuse_1.xyz = outDiffuseOcclusion_8.xyz;
  outEmission_2.w = emission_10.w;
  outEmission_2.xyz = exp2(-(emission_10.xyz));
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = outNormal_9;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
mediump vec3 t16_0;
lowp vec3 t10_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec2 t10_2;
lowp vec3 t10_3;
mediump vec3 t16_4;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_1.xyz = t10_1.xyz * t10_2.yyy;
    t16_0.xyz = t10_2.xxx * t10_0.xyz + t16_1.xyz;
    t10_3.xyz = t16_0.xyz * _Color.xyz;
    SV_Target0.xyz = t10_3.xyz;
    t16_4.xyz = t10_3.xyz * vs_TEXCOORD5.xyz;
    SV_Target3.xyz = exp2((-t16_4.xyz));
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    t10_3.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_3.xyz;
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
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
  tmpvar_3 = worldNormal_1;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * _glesVertex);
  tmpvar_5.xyz = ((tmpvar_10.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10.xyz;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outDiffuse_1;
  mediump vec4 outEmission_2;
  mediump vec4 tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD2;
  lowp vec3 tmpvar_5;
  lowp vec4 lay_6;
  mediump vec4 Mask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_7 = tmpvar_8;
  lay_6 = (Mask_7.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_6 = (lay_6 + (Mask_7.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  tmpvar_5 = (lay_6.xyz * _Color.xyz);
  tmpvar_3 = xlv_TEXCOORD4;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, tmpvar_3.xy);
  mediump vec3 tmpvar_10;
  tmpvar_10 = (2.0 * tmpvar_9.xyz);
  mediump vec4 outDiffuseOcclusion_11;
  mediump vec4 outNormal_12;
  mediump vec4 emission_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  outDiffuseOcclusion_11 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_4 * 0.5) + 0.5);
  outNormal_12 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  emission_13 = tmpvar_16;
  emission_13.xyz = (emission_13.xyz + (tmpvar_5 * tmpvar_10));
  outDiffuse_1.xyz = outDiffuseOcclusion_11.xyz;
  outEmission_2.w = emission_13.w;
  outEmission_2.xyz = exp2(-(emission_13.xyz));
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = outNormal_12;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = t0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = t0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
mediump vec3 t16_0;
lowp vec3 t10_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec2 t10_2;
lowp vec3 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_1.xyz = t10_1.xyz * t10_2.yyy;
    t16_0.xyz = t10_2.xxx * t10_0.xyz + t16_1.xyz;
    t10_3.xyz = t16_0.xyz * _Color.xyz;
    SV_Target0.xyz = t10_3.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    t10_4.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_4.xyz;
    SV_Target2.w = 1.0;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    t10_4.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t16_5.xyz = t10_3.xyz * t10_4.xyz;
    SV_Target3.xyz = exp2((-t16_5.xyz));
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
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
  tmpvar_3 = worldNormal_1;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
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
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = ((x2_11 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )) + x1_12);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 outDiffuse_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec3 tmpvar_3;
  lowp vec4 lay_4;
  mediump vec4 Mask_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_5 = tmpvar_6;
  lay_4 = (Mask_5.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_4 = (lay_4 + (Mask_5.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  tmpvar_3 = (lay_4.xyz * _Color.xyz);
  mediump vec4 outDiffuseOcclusion_7;
  mediump vec4 outNormal_8;
  mediump vec4 emission_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_3;
  outDiffuseOcclusion_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_2 * 0.5) + 0.5);
  outNormal_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vec3(0.0, 0.0, 0.0);
  emission_9 = tmpvar_12;
  emission_9.xyz = (emission_9.xyz + (tmpvar_3 * xlv_TEXCOORD5));
  outDiffuse_1.xyz = outDiffuseOcclusion_7.xyz;
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = outNormal_8;
  gl_FragData[3] = emission_9;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD3.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
mediump vec3 t16_0;
lowp vec3 t10_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec2 t10_2;
lowp vec3 t10_3;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_1.xyz = t10_1.xyz * t10_2.yyy;
    t16_0.xyz = t10_2.xxx * t10_0.xyz + t16_1.xyz;
    t10_3.xyz = t16_0.xyz * _Color.xyz;
    SV_Target0.xyz = t10_3.xyz;
    SV_Target3.xyz = t10_3.xyz * vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    t10_3.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_3.xyz;
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
uniform highp vec4 _Layer1_ST;
uniform highp vec4 _Layer2_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Layer1_ST.xy) + _Layer1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Layer2_ST.xy) + _Layer2_ST.zw);
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
  tmpvar_3 = worldNormal_1;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_Object2World * _glesVertex);
  tmpvar_5.xyz = ((tmpvar_10.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10.xyz;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform sampler2D _Layer1;
uniform sampler2D _Layer2;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outDiffuse_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD2;
  lowp vec3 tmpvar_4;
  lowp vec4 lay_5;
  mediump vec4 Mask_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD1);
  Mask_6 = tmpvar_7;
  lay_5 = (Mask_6.x * texture2D (_Layer1, xlv_TEXCOORD0.xy));
  lay_5 = (lay_5 + (Mask_6.y * texture2D (_Layer2, xlv_TEXCOORD0.zw)));
  tmpvar_4 = (lay_5.xyz * _Color.xyz);
  tmpvar_2 = xlv_TEXCOORD4;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, tmpvar_2.xy);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  mediump vec4 outDiffuseOcclusion_10;
  mediump vec4 outNormal_11;
  mediump vec4 emission_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4;
  outDiffuseOcclusion_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((tmpvar_3 * 0.5) + 0.5);
  outNormal_11 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  emission_12 = tmpvar_15;
  emission_12.xyz = (emission_12.xyz + (tmpvar_4 * tmpvar_9));
  outDiffuse_1.xyz = outDiffuseOcclusion_10.xyz;
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = outNormal_11;
  gl_FragData[3] = emission_12;
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Layer1_ST.xy + _Layer1_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Layer2_ST.xy + _Layer2_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz;
    t0.xyz = t0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = t0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	lowp vec4 _Color;
uniform 	vec4 _Layer1_ST;
uniform 	vec4 _Layer2_ST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Layer1;
uniform lowp sampler2D _Layer2;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
mediump vec3 t16_0;
lowp vec3 t10_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec2 t10_2;
lowp vec3 t10_3;
lowp vec3 t10_4;
void main()
{
    t10_0.xyz = texture(_Layer1, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = texture(_Layer2, vs_TEXCOORD0.zw).xyz;
    t10_2.xy = texture(_MainTex, vs_TEXCOORD1.xy).xy;
    t16_1.xyz = t10_1.xyz * t10_2.yyy;
    t16_0.xyz = t10_2.xxx * t10_0.xyz + t16_1.xyz;
    t10_3.xyz = t16_0.xyz * _Color.xyz;
    SV_Target0.xyz = t10_3.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    t10_4.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_4.xyz;
    SV_Target2.w = 1.0;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    t10_4.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    SV_Target3.xyz = t10_3.xyz * t10_4.xyz;
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
}