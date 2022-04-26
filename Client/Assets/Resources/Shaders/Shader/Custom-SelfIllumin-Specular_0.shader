Shader "Custom/SelfIllumin-Specular" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
 _Illum ("Illumin (A)", 2D) = "white" { }
 _EmissionLM ("Emission (Lightmapper)", Float) = 0
}
SubShader { 
 LOD 300
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 41231
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((x2_10 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )) + x1_11);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_5 = tmpvar_8;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  mediump vec3 viewDir_11;
  viewDir_11 = worldViewDir_5;
  lowp vec4 c_12;
  lowp vec4 c_13;
  highp float nh_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, normalize(
    (tmpvar_2 + viewDir_11)
  )));
  nh_14 = tmpvar_17;
  mediump float y_18;
  y_18 = (_Shininess * 128.0);
  highp float tmpvar_19;
  tmpvar_19 = (pow (nh_14, y_18) * tmpvar_9.w);
  c_13.xyz = (((tmpvar_10.xyz * tmpvar_1) * diff_15) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_19));
  c_13.w = tmpvar_10.w;
  c_12.w = c_13.w;
  c_12.xyz = (c_13.xyz + (tmpvar_10.xyz * xlv_TEXCOORD3));
  c_3.xyz = (c_12.xyz + (tmpvar_10.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w));
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
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
    vs_TEXCOORD3.xyz = t16_2.xyz + t16_3.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp float t10_0;
mediump vec3 t16_1;
lowp vec4 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
mediump vec3 t16_7;
highp float t12;
mediump float t16_13;
void main()
{
    t0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t16_1.xyz = t0.xyz * vec3(t12) + _WorldSpaceLightPos0.xyz;
    t16_13 = dot(t16_1.xyz, t16_1.xyz);
    t16_13 = inversesqrt(t16_13);
    t16_1.xyz = vec3(t16_13) * t16_1.xyz;
    t16_1.x = dot(vs_TEXCOORD1.xyz, t16_1.xyz);
    t16_1.x = max(t16_1.x, 0.0);
    t16_0.x = log2(t16_1.x);
    t16_1.x = _Shininess * 128.0;
    t16_0.x = t16_0.x * t16_1.x;
    t16_0.x = exp2(t16_0.x);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_0.x = t16_0.x * t10_1.w;
    t10_2.xyz = t10_1.xyz * _Color.xyz;
    t16_3.xyz = _LightColor0.xyz * _SpecColor.xyz;
    t16_0.xyz = t16_0.xxx * t16_3.xyz;
    t16_3.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t16_3.x = max(t16_3.x, 0.0);
    t16_7.xyz = t10_2.xyz * _LightColor0.xyz;
    t16_0.xyz = t16_7.xyz * t16_3.xxx + t16_0.xyz;
    t16_3.xyz = t10_2.xyz * vs_TEXCOORD3.xyz + t16_0.xyz;
    t10_0 = texture(_Illum, vs_TEXCOORD0.zw).w;
    SV_Target0.xyz = t10_2.xyz * vec3(t10_0) + t16_3.xyz;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
  tmpvar_1 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, tmpvar_1.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (2.0 * tmpvar_4.xyz);
  lowp vec4 c_6;
  lowp vec4 c_7;
  c_7.xyz = vec3(0.0, 0.0, 0.0);
  c_7.w = tmpvar_3.w;
  c_6.w = c_7.w;
  c_6.xyz = (tmpvar_3.xyz * tmpvar_5);
  c_2.xyz = (c_6.xyz + (tmpvar_3.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w));
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
lowp vec3 t10_3;
void main()
{
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    t10_1.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t10_0.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    t10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    t10_2.xyz = t10_3.xyz * _Color.xyz;
    t16_0.xyz = t10_0.xxx * t10_2.xyz;
    SV_Target0.xyz = t10_2.xyz * t10_1.xyz + t16_0.xyz;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_14.xyz;
  xlv_TEXCOORD3 = ((x2_11 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )) + x1_12);
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 worldViewDir_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_6 = tmpvar_9;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _Color);
  lowp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (float((texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), _LightShadowData.x);
  tmpvar_12 = tmpvar_13;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = tmpvar_12;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_14;
  mediump vec3 viewDir_15;
  viewDir_15 = worldViewDir_6;
  lowp vec4 c_16;
  lowp vec4 c_17;
  highp float nh_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_5, normalize(
    (tmpvar_3 + viewDir_15)
  )));
  nh_18 = tmpvar_21;
  mediump float y_22;
  y_22 = (_Shininess * 128.0);
  highp float tmpvar_23;
  tmpvar_23 = (pow (nh_18, y_22) * tmpvar_10.w);
  c_17.xyz = (((tmpvar_11.xyz * tmpvar_14) * diff_19) + ((tmpvar_14 * _SpecColor.xyz) * tmpvar_23));
  c_17.w = tmpvar_11.w;
  c_16.w = c_17.w;
  c_16.xyz = (c_17.xyz + (tmpvar_11.xyz * xlv_TEXCOORD3));
  c_4.xyz = (c_16.xyz + (tmpvar_11.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w));
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform sampler2D unity_Lightmap;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec4 tmpvar_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
  lowp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = max (float((texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), _LightShadowData.x);
  tmpvar_5 = tmpvar_6;
  tmpvar_1 = tmpvar_5;
  tmpvar_2 = xlv_TEXCOORD3;
  mediump vec3 tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, tmpvar_2.xy);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  tmpvar_7 = max (min (tmpvar_9, (tmpvar_8.xyz * tmpvar_1)), (tmpvar_9 * tmpvar_1));
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4.w;
  c_10.w = c_11.w;
  c_10.xyz = (tmpvar_4.xyz * tmpvar_7);
  c_3.xyz = (c_10.xyz + (tmpvar_4.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
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
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 normal_20;
  normal_20 = worldNormal_1;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  ndotl_22 = (tmpvar_24 * normal_20.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * normal_20.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * normal_20.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(lengthSq_23)));
  ndotl_22 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (lengthSq_23 * lightAttenSq_19)
  ))));
  col_21 = (lightColor0_15 * tmpvar_28.x);
  col_21 = (col_21 + (lightColor1_16 * tmpvar_28.y));
  col_21 = (col_21 + (lightColor2_17 * tmpvar_28.z));
  col_21 = (col_21 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_4 = (((x2_12 + 
    (unity_SHC.xyz * ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y)))
  ) + x1_13) + col_21);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_5 = tmpvar_8;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  mediump vec3 viewDir_11;
  viewDir_11 = worldViewDir_5;
  lowp vec4 c_12;
  lowp vec4 c_13;
  highp float nh_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, normalize(
    (tmpvar_2 + viewDir_11)
  )));
  nh_14 = tmpvar_17;
  mediump float y_18;
  y_18 = (_Shininess * 128.0);
  highp float tmpvar_19;
  tmpvar_19 = (pow (nh_14, y_18) * tmpvar_9.w);
  c_13.xyz = (((tmpvar_10.xyz * tmpvar_1) * diff_15) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_19));
  c_13.w = tmpvar_10.w;
  c_12.w = c_13.w;
  c_12.xyz = (c_13.xyz + (tmpvar_10.xyz * xlv_TEXCOORD3));
  c_3.xyz = (c_12.xyz + (tmpvar_10.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w));
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
uniform 	lowp vec4 _Color;
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD2.xyz = t1.xyz;
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
    vs_TEXCOORD3.xyz = t0.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp float t10_0;
mediump vec3 t16_1;
lowp vec4 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
mediump vec3 t16_7;
highp float t12;
mediump float t16_13;
void main()
{
    t0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t16_1.xyz = t0.xyz * vec3(t12) + _WorldSpaceLightPos0.xyz;
    t16_13 = dot(t16_1.xyz, t16_1.xyz);
    t16_13 = inversesqrt(t16_13);
    t16_1.xyz = vec3(t16_13) * t16_1.xyz;
    t16_1.x = dot(vs_TEXCOORD1.xyz, t16_1.xyz);
    t16_1.x = max(t16_1.x, 0.0);
    t16_0.x = log2(t16_1.x);
    t16_1.x = _Shininess * 128.0;
    t16_0.x = t16_0.x * t16_1.x;
    t16_0.x = exp2(t16_0.x);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_0.x = t16_0.x * t10_1.w;
    t10_2.xyz = t10_1.xyz * _Color.xyz;
    t16_3.xyz = _LightColor0.xyz * _SpecColor.xyz;
    t16_0.xyz = t16_0.xxx * t16_3.xyz;
    t16_3.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t16_3.x = max(t16_3.x, 0.0);
    t16_7.xyz = t10_2.xyz * _LightColor0.xyz;
    t16_0.xyz = t16_7.xyz * t16_3.xxx + t16_0.xyz;
    t16_3.xyz = t10_2.xyz * vs_TEXCOORD3.xyz + t16_0.xyz;
    t10_0 = texture(_Illum, vs_TEXCOORD0.zw).w;
    SV_Target0.xyz = t10_2.xyz * vec3(t10_0) + t16_3.xyz;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex);
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
  tmpvar_3 = worldNormal_1;
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
  tmpvar_4 = (((x2_13 + 
    (unity_SHC.xyz * ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y)))
  ) + x1_14) + col_22);
  tmpvar_5 = (unity_World2Shadow[0] * tmpvar_6);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_6.xyz;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 worldViewDir_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_6 = tmpvar_9;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _Color);
  lowp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (float((texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), _LightShadowData.x);
  tmpvar_12 = tmpvar_13;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = tmpvar_12;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_14;
  mediump vec3 viewDir_15;
  viewDir_15 = worldViewDir_6;
  lowp vec4 c_16;
  lowp vec4 c_17;
  highp float nh_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_5, normalize(
    (tmpvar_3 + viewDir_15)
  )));
  nh_18 = tmpvar_21;
  mediump float y_22;
  y_22 = (_Shininess * 128.0);
  highp float tmpvar_23;
  tmpvar_23 = (pow (nh_18, y_22) * tmpvar_10.w);
  c_17.xyz = (((tmpvar_11.xyz * tmpvar_14) * diff_19) + ((tmpvar_14 * _SpecColor.xyz) * tmpvar_23));
  c_17.w = tmpvar_11.w;
  c_16.w = c_17.w;
  c_16.xyz = (c_17.xyz + (tmpvar_11.xyz * xlv_TEXCOORD3));
  c_4.xyz = (c_16.xyz + (tmpvar_11.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_14.xyz;
  xlv_TEXCOORD3 = ((x2_11 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )) + x1_12);
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 worldViewDir_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_6 = tmpvar_9;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _Color);
  lowp float shadow_12;
  shadow_12 = (_LightShadowData.x + (shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz) * (1.0 - _LightShadowData.x)));
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = shadow_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  mediump vec3 viewDir_14;
  viewDir_14 = worldViewDir_6;
  lowp vec4 c_15;
  lowp vec4 c_16;
  highp float nh_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_18 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_5, normalize(
    (tmpvar_3 + viewDir_14)
  )));
  nh_17 = tmpvar_20;
  mediump float y_21;
  y_21 = (_Shininess * 128.0);
  highp float tmpvar_22;
  tmpvar_22 = (pow (nh_17, y_21) * tmpvar_10.w);
  c_16.xyz = (((tmpvar_11.xyz * tmpvar_13) * diff_18) + ((tmpvar_13 * _SpecColor.xyz) * tmpvar_22));
  c_16.w = tmpvar_11.w;
  c_15.w = c_16.w;
  c_15.xyz = (c_16.xyz + (tmpvar_11.xyz * xlv_TEXCOORD3));
  c_4.xyz = (c_15.xyz + (tmpvar_11.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w));
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
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
    vs_TEXCOORD3.xyz = t16_2.xyz + t16_3.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1 = t0.yyyy * unity_World2Shadow[0][1];
    t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
    t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
    t0 = unity_World2Shadow[0][3] * t0.wwww + t1;
    vs_TEXCOORD4 = t0;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp float t10_0;
mediump vec3 t16_1;
lowp vec4 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
mediump vec3 t16_4;
mediump float t16_8;
highp float t15;
mediump float t16_16;
mediump float t16_18;
void main()
{
    t0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t16_1.xyz = t0.xyz * vec3(t15) + _WorldSpaceLightPos0.xyz;
    t16_16 = dot(t16_1.xyz, t16_1.xyz);
    t16_16 = inversesqrt(t16_16);
    t16_1.xyz = vec3(t16_16) * t16_1.xyz;
    t16_1.x = dot(vs_TEXCOORD1.xyz, t16_1.xyz);
    t16_1.x = max(t16_1.x, 0.0);
    t16_0.x = log2(t16_1.x);
    t16_1.x = _Shininess * 128.0;
    t16_0.x = t16_0.x * t16_1.x;
    t16_0.x = exp2(t16_0.x);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_0.x = t16_0.x * t10_1.w;
    t10_2.xyz = t10_1.xyz * _Color.xyz;
    vec3 txVec12 = vec3(vs_TEXCOORD4.xy,vs_TEXCOORD4.z);
    t16_3.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec12, 0.0);
    t16_8 = (-_LightShadowData.x) + 1.0;
    t16_3.x = t16_3.x * t16_8 + _LightShadowData.x;
    t16_3.xyz = t16_3.xxx * _LightColor0.xyz;
    t16_4.xyz = t16_3.xyz * _SpecColor.xyz;
    t16_3.xyz = t10_2.xyz * t16_3.xyz;
    t16_0.xyz = t16_0.xxx * t16_4.xyz;
    t16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t16_18 = max(t16_18, 0.0);
    t16_0.xyz = t16_3.xyz * vec3(t16_18) + t16_0.xyz;
    t16_3.xyz = t10_2.xyz * vs_TEXCOORD3.xyz + t16_0.xyz;
    t10_0 = texture(_Illum, vs_TEXCOORD0.zw).w;
    SV_Target0.xyz = t10_2.xyz * vec3(t10_0) + t16_3.xyz;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform mediump vec4 _LightShadowData;
uniform sampler2D unity_Lightmap;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec4 tmpvar_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
  lowp float shadow_5;
  shadow_5 = (_LightShadowData.x + (shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz) * (1.0 - _LightShadowData.x)));
  tmpvar_1 = shadow_5;
  tmpvar_2 = xlv_TEXCOORD3;
  mediump vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, tmpvar_2.xy);
  mediump vec3 tmpvar_8;
  tmpvar_8 = (2.0 * tmpvar_7.xyz);
  tmpvar_6 = max (min (tmpvar_8, (tmpvar_7.xyz * tmpvar_1)), (tmpvar_8 * tmpvar_1));
  lowp vec4 c_9;
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  c_10.w = tmpvar_4.w;
  c_9.w = c_10.w;
  c_9.xyz = (tmpvar_4.xyz * tmpvar_6);
  c_3.xyz = (c_9.xyz + (tmpvar_4.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w));
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
highp vec4 t0;
highp vec4 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1 = t0.yyyy * unity_World2Shadow[0][1];
    t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
    t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
    t0 = unity_World2Shadow[0][3] * t0.wwww + t1;
    vs_TEXCOORD4 = t0;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2D unity_Lightmap;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec3 t16_0;
mediump vec3 t16_1;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
mediump vec3 t16_4;
lowp vec3 t10_5;
void main()
{
    vec3 txVec7 = vec3(vs_TEXCOORD4.xy,vs_TEXCOORD4.z);
    t16_0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
    t16_4.x = (-_LightShadowData.x) + 1.0;
    t16_0.x = t16_0.x * t16_4.x + _LightShadowData.x;
    t10_1.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    t16_4.xyz = t16_0.xxx * t10_1.xyz;
    t10_2.xyz = t10_1.xyz * vec3(2.0, 2.0, 2.0);
    t16_4.xyz = min(t16_4.xyz, t10_2.xyz);
    t16_3.xyz = t16_0.xxx * t10_2.xyz;
    t16_0.xyz = max(t16_4.xyz, t16_3.xyz);
    t10_1.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    t10_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    t10_2.xyz = t10_5.xyz * _Color.xyz;
    t16_1.xyz = t10_1.xxx * t10_2.xyz;
    SV_Target0.xyz = t10_2.xyz * t16_0.xyz + t16_1.xyz;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex);
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
  tmpvar_3 = worldNormal_1;
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
  tmpvar_4 = (((x2_13 + 
    (unity_SHC.xyz * ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y)))
  ) + x1_14) + col_22);
  tmpvar_5 = (unity_World2Shadow[0] * tmpvar_6);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_6.xyz;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shadow_samplers : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 worldViewDir_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_6 = tmpvar_9;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _Color);
  lowp float shadow_12;
  shadow_12 = (_LightShadowData.x + (shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz) * (1.0 - _LightShadowData.x)));
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = shadow_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  mediump vec3 viewDir_14;
  viewDir_14 = worldViewDir_6;
  lowp vec4 c_15;
  lowp vec4 c_16;
  highp float nh_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_18 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_5, normalize(
    (tmpvar_3 + viewDir_14)
  )));
  nh_17 = tmpvar_20;
  mediump float y_21;
  y_21 = (_Shininess * 128.0);
  highp float tmpvar_22;
  tmpvar_22 = (pow (nh_17, y_21) * tmpvar_10.w);
  c_16.xyz = (((tmpvar_11.xyz * tmpvar_13) * diff_18) + ((tmpvar_13 * _SpecColor.xyz) * tmpvar_22));
  c_16.w = tmpvar_11.w;
  c_15.w = c_16.w;
  c_15.xyz = (c_16.xyz + (tmpvar_11.xyz * xlv_TEXCOORD3));
  c_4.xyz = (c_15.xyz + (tmpvar_11.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
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
uniform 	lowp vec4 _Color;
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD2.xyz = t1.xyz;
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
    vs_TEXCOORD3.xyz = t0.xyz;
    t0 = in_POSITION0.yyyy * _Object2World[1];
    t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
    t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
    t0 = _Object2World[3] * in_POSITION0.wwww + t0;
    t1 = t0.yyyy * unity_World2Shadow[0][1];
    t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
    t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
    t0 = unity_World2Shadow[0][3] * t0.wwww + t1;
    vs_TEXCOORD4 = t0;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
lowp float t10_0;
mediump vec3 t16_1;
lowp vec4 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
mediump vec3 t16_4;
mediump float t16_8;
highp float t15;
mediump float t16_16;
mediump float t16_18;
void main()
{
    t0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t16_1.xyz = t0.xyz * vec3(t15) + _WorldSpaceLightPos0.xyz;
    t16_16 = dot(t16_1.xyz, t16_1.xyz);
    t16_16 = inversesqrt(t16_16);
    t16_1.xyz = vec3(t16_16) * t16_1.xyz;
    t16_1.x = dot(vs_TEXCOORD1.xyz, t16_1.xyz);
    t16_1.x = max(t16_1.x, 0.0);
    t16_0.x = log2(t16_1.x);
    t16_1.x = _Shininess * 128.0;
    t16_0.x = t16_0.x * t16_1.x;
    t16_0.x = exp2(t16_0.x);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_0.x = t16_0.x * t10_1.w;
    t10_2.xyz = t10_1.xyz * _Color.xyz;
    vec3 txVec13 = vec3(vs_TEXCOORD4.xy,vs_TEXCOORD4.z);
    t16_3.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec13, 0.0);
    t16_8 = (-_LightShadowData.x) + 1.0;
    t16_3.x = t16_3.x * t16_8 + _LightShadowData.x;
    t16_3.xyz = t16_3.xxx * _LightColor0.xyz;
    t16_4.xyz = t16_3.xyz * _SpecColor.xyz;
    t16_3.xyz = t10_2.xyz * t16_3.xyz;
    t16_0.xyz = t16_0.xxx * t16_4.xyz;
    t16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t16_18 = max(t16_18, 0.0);
    t16_0.xyz = t16_3.xyz * vec3(t16_18) + t16_0.xyz;
    t16_3.xyz = t10_2.xyz * vs_TEXCOORD3.xyz + t16_0.xyz;
    t10_0 = texture(_Illum, vs_TEXCOORD0.zw).w;
    SV_Target0.xyz = t10_2.xyz * vec3(t10_0) + t16_3.xyz;
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
  GpuProgramID 91997
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_5 = tmpvar_8;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_12;
  tmpvar_12 = (_LightMatrix0 * tmpvar_11).xyz;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, tmpvar_12);
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_LightTexture0, vec2(tmpvar_13)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * tmpvar_14);
  mediump vec3 viewDir_15;
  viewDir_15 = worldViewDir_5;
  lowp vec4 c_16;
  lowp vec4 c_17;
  highp float nh_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_4, normalize(
    (tmpvar_2 + viewDir_15)
  )));
  nh_18 = tmpvar_21;
  mediump float y_22;
  y_22 = (_Shininess * 128.0);
  highp float tmpvar_23;
  tmpvar_23 = (pow (nh_18, y_22) * tmpvar_9.w);
  c_17.xyz = (((tmpvar_10.xyz * tmpvar_1) * diff_19) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_23));
  c_17.w = tmpvar_10.w;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  c_3.xyz = c_16.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
highp vec3 t1;
lowp vec4 t10_1;
mediump vec4 t16_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump float t16_5;
lowp float t10_5;
highp float t15;
void main()
{
    t0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t0.xyz = vec3(t15) * t0.xyz;
    t1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
    t15 = dot(t1.xyz, t1.xyz);
    t15 = inversesqrt(t15);
    t16_2.xyz = t1.xyz * vec3(t15) + t0.xyz;
    t16_2.w = dot(vs_TEXCOORD1.xyz, t0.xyz);
    t16_3.x = dot(t16_2.xyz, t16_2.xyz);
    t16_3.x = inversesqrt(t16_3.x);
    t16_2.xyz = t16_2.xyz * t16_3.xxx;
    t16_2.x = dot(vs_TEXCOORD1.xyz, t16_2.xyz);
    t16_2.xw = max(t16_2.xw, vec2(0.0, 0.0));
    t16_0.x = log2(t16_2.x);
    t16_2.x = _Shininess * 128.0;
    t16_0.x = t16_0.x * t16_2.x;
    t16_0.x = exp2(t16_0.x);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_0.x = t16_0.x * t10_1.w;
    t10_4.xyz = t10_1.xyz * _Color.xyz;
    t16_2.xyz = vs_TEXCOORD2.yyy * _LightMatrix0[1].xyz;
    t16_2.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD2.xxx + t16_2.xyz;
    t16_2.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD2.zzz + t16_2.xyz;
    t16_2.xyz = t16_2.xyz + _LightMatrix0[3].xyz;
    t16_5 = dot(t16_2.xyz, t16_2.xyz);
    t10_5 = texture(_LightTexture0, vec2(t16_5)).w;
    t16_2.xyz = vec3(t10_5) * _LightColor0.xyz;
    t16_3.xyz = t16_2.xyz * _SpecColor.xyz;
    t16_2.xyz = t16_2.xyz * t10_4.xyz;
    t16_0.xyz = t16_0.xxx * t16_3.xyz;
    t16_0.xyz = t16_2.xyz * t16_2.www + t16_0.xyz;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_5 = tmpvar_8;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  mediump vec3 viewDir_11;
  viewDir_11 = worldViewDir_5;
  lowp vec4 c_12;
  lowp vec4 c_13;
  highp float nh_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, normalize(
    (tmpvar_2 + viewDir_11)
  )));
  nh_14 = tmpvar_17;
  mediump float y_18;
  y_18 = (_Shininess * 128.0);
  highp float tmpvar_19;
  tmpvar_19 = (pow (nh_14, y_18) * tmpvar_9.w);
  c_13.xyz = (((tmpvar_10.xyz * tmpvar_1) * diff_15) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_19));
  c_13.w = tmpvar_10.w;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
mediump vec3 t16_1;
lowp vec4 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
mediump vec3 t16_4;
highp float t15;
mediump float t16_16;
mediump float t16_18;
void main()
{
    t0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t16_1.xyz = t0.xyz * vec3(t15) + _WorldSpaceLightPos0.xyz;
    t16_16 = dot(t16_1.xyz, t16_1.xyz);
    t16_16 = inversesqrt(t16_16);
    t16_1.xyz = vec3(t16_16) * t16_1.xyz;
    t16_1.x = dot(vs_TEXCOORD1.xyz, t16_1.xyz);
    t16_1.x = max(t16_1.x, 0.0);
    t16_0.x = log2(t16_1.x);
    t16_1.x = _Shininess * 128.0;
    t16_0.x = t16_0.x * t16_1.x;
    t16_0.x = exp2(t16_0.x);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_0.x = t16_0.x * t10_1.w;
    t10_2.xyz = t10_1.xyz * _Color.xyz;
    t16_3.xyz = t10_2.xyz * _LightColor0.xyz;
    t16_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
    t16_0.xyz = t16_0.xxx * t16_4.xyz;
    t16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t16_18 = max(t16_18, 0.0);
    t16_0.xyz = t16_3.xyz * vec3(t16_18) + t16_0.xyz;
    SV_Target0.xyz = t16_0.xyz;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  mediump vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 worldViewDir_7;
  lowp vec3 lightDir_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_7 = tmpvar_10;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * _Color);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_LightMatrix0 * tmpvar_13);
  lightCoord_5 = tmpvar_14;
  lowp vec4 tmpvar_15;
  mediump vec2 P_16;
  P_16 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
  tmpvar_15 = texture2D (_LightTexture0, P_16);
  highp vec3 LightCoord_17;
  LightCoord_17 = lightCoord_5.xyz;
  highp float tmpvar_18;
  tmpvar_18 = dot (LightCoord_17, LightCoord_17);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_LightTextureB0, vec2(tmpvar_18));
  mediump float tmpvar_20;
  tmpvar_20 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_15.w) * tmpvar_19.w);
  atten_4 = tmpvar_20;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_4);
  mediump vec3 viewDir_21;
  viewDir_21 = worldViewDir_7;
  lowp vec4 c_22;
  lowp vec4 c_23;
  highp float nh_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_25 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_6, normalize(
    (tmpvar_2 + viewDir_21)
  )));
  nh_24 = tmpvar_27;
  mediump float y_28;
  y_28 = (_Shininess * 128.0);
  highp float tmpvar_29;
  tmpvar_29 = (pow (nh_24, y_28) * tmpvar_11.w);
  c_23.xyz = (((tmpvar_12.xyz * tmpvar_1) * diff_25) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_29));
  c_23.w = tmpvar_12.w;
  c_22.w = c_23.w;
  c_22.xyz = c_23.xyz;
  c_3.xyz = c_22.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightTexture0;
uniform lowp sampler2D _LightTextureB0;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out lowp vec4 SV_Target0;
mediump vec4 t16_0;
mediump vec3 t16_1;
highp vec3 t2;
mediump vec3 t16_2;
lowp float t10_2;
lowp vec4 t10_3;
highp vec3 t4;
mediump vec3 t16_5;
lowp vec3 t10_6;
bool tb9;
mediump float t16_16;
lowp float t10_16;
mediump float t16_21;
mediump float t16_22;
highp float t23;
void main()
{
    t16_0 = vs_TEXCOORD2.yyyy * _LightMatrix0[1];
    t16_0 = _LightMatrix0[0] * vs_TEXCOORD2.xxxx + t16_0;
    t16_0 = _LightMatrix0[2] * vs_TEXCOORD2.zzzz + t16_0;
    t16_0 = t16_0 + _LightMatrix0[3];
    t16_1.xy = t16_0.xy / t16_0.ww;
    t16_1.xy = t16_1.xy + vec2(0.5, 0.5);
    t10_2 = texture(_LightTexture0, t16_1.xy).w;
    tb9 = 0.0<t16_0.z;
    t16_16 = dot(t16_0.xyz, t16_0.xyz);
    t10_16 = texture(_LightTextureB0, vec2(t16_16)).w;
    t10_3.x = (tb9) ? 1.0 : 0.0;
    t10_3.x = t10_2 * t10_3.x;
    t10_3.x = t10_16 * t10_3.x;
    t16_0.xyz = t10_3.xxx * _LightColor0.xyz;
    t16_1.xyz = t16_0.xyz * _SpecColor.xyz;
    t2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    t23 = dot(t2.xyz, t2.xyz);
    t23 = inversesqrt(t23);
    t2.xyz = vec3(t23) * t2.xyz;
    t4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
    t23 = dot(t4.xyz, t4.xyz);
    t23 = inversesqrt(t23);
    t16_5.xyz = t4.xyz * vec3(t23) + t2.xyz;
    t16_21 = dot(vs_TEXCOORD1.xyz, t2.xyz);
    t16_21 = max(t16_21, 0.0);
    t16_22 = dot(t16_5.xyz, t16_5.xyz);
    t16_22 = inversesqrt(t16_22);
    t16_5.xyz = vec3(t16_22) * t16_5.xyz;
    t16_22 = dot(vs_TEXCOORD1.xyz, t16_5.xyz);
    t16_22 = max(t16_22, 0.0);
    t16_2.x = log2(t16_22);
    t16_22 = _Shininess * 128.0;
    t16_2.x = t16_2.x * t16_22;
    t16_2.x = exp2(t16_2.x);
    t10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_2.x = t16_2.x * t10_3.w;
    t10_6.xyz = t10_3.xyz * _Color.xyz;
    t16_0.xyz = t16_0.xyz * t10_6.xyz;
    t16_2.xyz = t16_1.xyz * t16_2.xxx;
    t16_2.xyz = t16_0.xyz * vec3(t16_21) + t16_2.xyz;
    SV_Target0.xyz = t16_2.xyz;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp samplerCube _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_5 = tmpvar_8;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_12;
  tmpvar_12 = (_LightMatrix0 * tmpvar_11).xyz;
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_12, tmpvar_12);
  lowp float tmpvar_14;
  tmpvar_14 = (texture2D (_LightTextureB0, vec2(tmpvar_13)).w * textureCube (_LightTexture0, tmpvar_12).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * tmpvar_14);
  mediump vec3 viewDir_15;
  viewDir_15 = worldViewDir_5;
  lowp vec4 c_16;
  lowp vec4 c_17;
  highp float nh_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_4, normalize(
    (tmpvar_2 + viewDir_15)
  )));
  nh_18 = tmpvar_21;
  mediump float y_22;
  y_22 = (_Shininess * 128.0);
  highp float tmpvar_23;
  tmpvar_23 = (pow (nh_18, y_22) * tmpvar_9.w);
  c_17.xyz = (((tmpvar_10.xyz * tmpvar_1) * diff_19) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_23));
  c_17.w = tmpvar_10.w;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  c_3.xyz = c_16.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightTextureB0;
uniform lowp samplerCube _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
highp vec3 t1;
lowp vec4 t10_1;
mediump vec4 t16_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump float t16_5;
lowp float t10_5;
lowp float t10_10;
highp float t15;
void main()
{
    t0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t0.xyz = vec3(t15) * t0.xyz;
    t1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
    t15 = dot(t1.xyz, t1.xyz);
    t15 = inversesqrt(t15);
    t16_2.xyz = t1.xyz * vec3(t15) + t0.xyz;
    t16_2.w = dot(vs_TEXCOORD1.xyz, t0.xyz);
    t16_3.x = dot(t16_2.xyz, t16_2.xyz);
    t16_3.x = inversesqrt(t16_3.x);
    t16_2.xyz = t16_2.xyz * t16_3.xxx;
    t16_2.x = dot(vs_TEXCOORD1.xyz, t16_2.xyz);
    t16_2.xw = max(t16_2.xw, vec2(0.0, 0.0));
    t16_0.x = log2(t16_2.x);
    t16_2.x = _Shininess * 128.0;
    t16_0.x = t16_0.x * t16_2.x;
    t16_0.x = exp2(t16_0.x);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_0.x = t16_0.x * t10_1.w;
    t10_4.xyz = t10_1.xyz * _Color.xyz;
    t16_2.xyz = vs_TEXCOORD2.yyy * _LightMatrix0[1].xyz;
    t16_2.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD2.xxx + t16_2.xyz;
    t16_2.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD2.zzz + t16_2.xyz;
    t16_2.xyz = t16_2.xyz + _LightMatrix0[3].xyz;
    t16_5 = dot(t16_2.xyz, t16_2.xyz);
    t10_10 = texture(_LightTexture0, t16_2.xyz).w;
    t10_5 = texture(_LightTextureB0, vec2(t16_5)).w;
    t16_5 = t10_10 * t10_5;
    t16_2.xyz = vec3(t16_5) * _LightColor0.xyz;
    t16_3.xyz = t16_2.xyz * _SpecColor.xyz;
    t16_2.xyz = t16_2.xyz * t10_4.xyz;
    t16_0.xyz = t16_0.xxx * t16_3.xyz;
    t16_0.xyz = t16_2.xyz * t16_2.www + t16_0.xyz;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_Object2World * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mediump mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_5 = tmpvar_8;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD2;
  highp vec2 tmpvar_12;
  tmpvar_12 = (_LightMatrix0 * tmpvar_11).xy;
  lowp float tmpvar_13;
  tmpvar_13 = texture2D (_LightTexture0, tmpvar_12).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * tmpvar_13);
  mediump vec3 viewDir_14;
  viewDir_14 = worldViewDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  highp float nh_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_18 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, normalize(
    (tmpvar_2 + viewDir_14)
  )));
  nh_17 = tmpvar_20;
  mediump float y_21;
  y_21 = (_Shininess * 128.0);
  highp float tmpvar_22;
  tmpvar_22 = (pow (nh_17, y_21) * tmpvar_9.w);
  c_16.xyz = (((tmpvar_10.xyz * tmpvar_1) * diff_18) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_22));
  c_16.w = tmpvar_10.w;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.xyz = c_15.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
highp vec4 t0;
highp vec3 t1;
highp float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec3 t0;
mediump vec3 t16_0;
mediump vec3 t16_1;
lowp vec4 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
mediump vec3 t16_4;
lowp float t10_5;
highp float t15;
mediump float t16_16;
mediump float t16_18;
void main()
{
    t0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t16_1.xyz = t0.xyz * vec3(t15) + _WorldSpaceLightPos0.xyz;
    t16_16 = dot(t16_1.xyz, t16_1.xyz);
    t16_16 = inversesqrt(t16_16);
    t16_1.xyz = vec3(t16_16) * t16_1.xyz;
    t16_1.x = dot(vs_TEXCOORD1.xyz, t16_1.xyz);
    t16_1.x = max(t16_1.x, 0.0);
    t16_0.x = log2(t16_1.x);
    t16_1.x = _Shininess * 128.0;
    t16_0.x = t16_0.x * t16_1.x;
    t16_0.x = exp2(t16_0.x);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_0.x = t16_0.x * t10_1.w;
    t10_2.xyz = t10_1.xyz * _Color.xyz;
    t16_3.xy = vs_TEXCOORD2.yy * _LightMatrix0[1].xy;
    t16_3.xy = _LightMatrix0[0].xy * vs_TEXCOORD2.xx + t16_3.xy;
    t16_3.xy = _LightMatrix0[2].xy * vs_TEXCOORD2.zz + t16_3.xy;
    t16_3.xy = t16_3.xy + _LightMatrix0[3].xy;
    t10_5 = texture(_LightTexture0, t16_3.xy).w;
    t16_3.xyz = vec3(t10_5) * _LightColor0.xyz;
    t16_4.xyz = t16_3.xyz * _SpecColor.xyz;
    t16_3.xyz = t10_2.xyz * t16_3.xyz;
    t16_0.xyz = t16_0.xxx * t16_4.xyz;
    t16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t16_18 = max(t16_18, 0.0);
    t16_0.xyz = t16_3.xyz * vec3(t16_18) + t16_0.xyz;
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
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 142055
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
uniform mediump float _Shininess;
varying mediump vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = _Shininess;
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
uniform 	lowp vec4 _Color;
uniform 	mediump float _Shininess;
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
uniform 	mediump float _Shininess;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = _Shininess;
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
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 221182
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
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
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec3 tmpvar_12;
  mediump vec4 normal_13;
  normal_13 = tmpvar_11;
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
  tmpvar_12 = ((x2_14 + (unity_SHC.xyz * 
    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
  )) + x1_15);
  tmpvar_4 = tmpvar_12;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Color);
  tmpvar_4 = (tmpvar_6.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_7;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_8;
  lowp float spec_9;
  mediump float tmpvar_10;
  tmpvar_10 = (light_3.w * tmpvar_5.w);
  spec_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_6.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_9));
  c_8.w = tmpvar_6.w;
  c_2 = c_8;
  c_2.xyz = (c_2.xyz + tmpvar_4);
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
uniform 	lowp vec4 _Color;
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = t0.zw;
    vs_TEXCOORD2.xy = t1.zz + t1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
    vs_TEXCOORD4.xyz = t16_2.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2D _LightBuffer;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec2 t0;
mediump vec4 t16_0;
lowp vec4 t10_0;
lowp vec4 t10_1;
mediump vec3 t16_2;
highp vec3 t3;
lowp vec3 t10_4;
mediump vec3 t16_7;
void main()
{
    t0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t10_0 = texture(_LightBuffer, t0.xy);
    t16_0 = max(t10_0, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
    t16_0 = log2(t16_0);
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_2.x = (-t16_0.w) * t10_1.w;
    t3.xyz = (-t16_0.xyz) + vs_TEXCOORD4.xyz;
    t10_4.xyz = t10_1.xyz * _Color.xyz;
    t16_7.xyz = t3.xyz * _SpecColor.xyz;
    t16_2.xyz = t16_2.xxx * t16_7.xyz;
    t16_2.xyz = t10_4.xyz * t3.xyz + t16_2.xyz;
    t10_1.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    t16_2.xyz = t10_4.xyz * t10_1.xxx + t16_2.xyz;
    SV_Target0.xyz = t16_2.xyz;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * _glesVertex);
  tmpvar_4.xyz = ((tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_4.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  lowp vec3 lm_3;
  mediump vec4 light_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _Color);
  tmpvar_5 = (tmpvar_7.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_4 = tmpvar_8;
  light_4 = -(log2(max (light_4, vec4(0.001, 0.001, 0.001, 0.001))));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  mediump vec3 tmpvar_10;
  tmpvar_10 = (2.0 * tmpvar_9.xyz);
  lm_3 = tmpvar_10;
  light_4.xyz = (light_4.xyz + lm_3);
  lowp vec4 c_11;
  lowp float spec_12;
  mediump float tmpvar_13;
  tmpvar_13 = (light_4.w * tmpvar_6.w);
  spec_12 = tmpvar_13;
  c_11.xyz = ((tmpvar_7.xyz * light_4.xyz) + ((light_4.xyz * _SpecColor.xyz) * spec_12));
  c_11.w = tmpvar_7.w;
  c_2 = c_11;
  c_2.xyz = (c_2.xyz + tmpvar_5);
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
uniform 	lowp vec4 _Color;
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD1.xyz = t1.xyz;
    t1.xyz = t1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = t1.xyz * unity_ShadowFadeCenterAndType.www;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = t0.zw;
    vs_TEXCOORD2.xy = t1.zz + t1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = t2 * (-t0.x);
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2D _LightBuffer;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec2 t0;
mediump vec4 t16_0;
lowp vec4 t10_0;
lowp vec4 t10_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump float t16_17;
void main()
{
    t0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t10_0 = texture(_LightBuffer, t0.xy);
    t16_0 = max(t10_0, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
    t16_0 = log2(t16_0);
    t10_1.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    t16_2.xyz = vec3(2.0, 2.0, 2.0) * t10_1.xyz + (-t16_0.xyz);
    t16_3.xyz = t16_2.xyz * _SpecColor.xyz;
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_17 = (-t16_0.w) * t10_1.w;
    t10_4.xyz = t10_1.xyz * _Color.xyz;
    t16_3.xyz = vec3(t16_17) * t16_3.xyz;
    t16_2.xyz = t10_4.xyz * t16_2.xyz + t16_3.xyz;
    t10_1.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    t16_2.xyz = t10_4.xyz * t10_1.xxx + t16_2.xyz;
    SV_Target0.xyz = t16_2.xyz;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
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
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec3 tmpvar_12;
  mediump vec4 normal_13;
  normal_13 = tmpvar_11;
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
  tmpvar_12 = ((x2_14 + (unity_SHC.xyz * 
    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
  )) + x1_15);
  tmpvar_4 = tmpvar_12;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Color);
  tmpvar_4 = (tmpvar_6.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_8.w;
  light_3.xyz = (tmpvar_8.xyz + xlv_TEXCOORD4);
  lowp vec4 c_9;
  lowp float spec_10;
  mediump float tmpvar_11;
  tmpvar_11 = (tmpvar_8.w * tmpvar_5.w);
  spec_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_6.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_10));
  c_9.w = tmpvar_6.w;
  c_2 = c_9;
  c_2.xyz = (c_2.xyz + tmpvar_4);
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
uniform 	lowp vec4 _Color;
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = t0.zw;
    vs_TEXCOORD2.xy = t1.zz + t1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
    vs_TEXCOORD4.xyz = t16_2.xyz;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2D _LightBuffer;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec2 t0;
mediump vec4 t16_0;
lowp vec4 t10_0;
lowp vec4 t10_1;
mediump vec3 t16_2;
highp vec3 t3;
lowp vec3 t10_4;
mediump vec3 t16_7;
void main()
{
    t0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t10_0 = texture(_LightBuffer, t0.xy);
    t16_0 = max(t10_0, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_2.x = t16_0.w * t10_1.w;
    t3.xyz = t16_0.xyz + vs_TEXCOORD4.xyz;
    t10_4.xyz = t10_1.xyz * _Color.xyz;
    t16_7.xyz = t3.xyz * _SpecColor.xyz;
    t16_2.xyz = t16_2.xxx * t16_7.xyz;
    t16_2.xyz = t10_4.xyz * t3.xyz + t16_2.xyz;
    t10_1.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    t16_2.xyz = t10_4.xyz * t10_1.xxx + t16_2.xyz;
    SV_Target0.xyz = t16_2.xyz;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * _glesVertex);
  tmpvar_4.xyz = ((tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_4.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  lowp vec3 lm_3;
  mediump vec4 light_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _Color);
  tmpvar_5 = (tmpvar_7.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_4 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = max (light_4, vec4(0.001, 0.001, 0.001, 0.001));
  light_4.w = tmpvar_9.w;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD3.xy);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (2.0 * tmpvar_10.xyz);
  lm_3 = tmpvar_11;
  light_4.xyz = (tmpvar_9.xyz + lm_3);
  lowp vec4 c_12;
  lowp float spec_13;
  mediump float tmpvar_14;
  tmpvar_14 = (tmpvar_9.w * tmpvar_6.w);
  spec_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * light_4.xyz) + ((light_4.xyz * _SpecColor.xyz) * spec_13));
  c_12.w = tmpvar_7.w;
  c_2 = c_12;
  c_2.xyz = (c_2.xyz + tmpvar_5);
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
uniform 	lowp vec4 _Color;
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD1.xyz = t1.xyz;
    t1.xyz = t1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = t1.xyz * unity_ShadowFadeCenterAndType.www;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = t0.zw;
    vs_TEXCOORD2.xy = t1.zz + t1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = t2 * (-t0.x);
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2D _LightBuffer;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec2 t0;
mediump vec4 t16_0;
lowp vec4 t10_0;
lowp vec4 t10_1;
mediump vec3 t16_2;
mediump vec3 t16_3;
lowp vec3 t10_4;
mediump float t16_17;
void main()
{
    t0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    t10_0 = texture(_LightBuffer, t0.xy);
    t16_0 = max(t10_0, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
    t10_1.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    t16_2.xyz = vec3(2.0, 2.0, 2.0) * t10_1.xyz + t16_0.xyz;
    t16_3.xyz = t16_2.xyz * _SpecColor.xyz;
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_17 = t16_0.w * t10_1.w;
    t10_4.xyz = t10_1.xyz * _Color.xyz;
    t16_3.xyz = vec3(t16_17) * t16_3.xyz;
    t16_2.xyz = t10_4.xyz * t16_2.xyz + t16_3.xyz;
    t10_1.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    t16_2.xyz = t10_4.xyz * t10_1.xxx + t16_2.xyz;
    SV_Target0.xyz = t16_2.xyz;
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
}
 }
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 265457
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )) + x1_12);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outDiffuse_1;
  mediump vec4 outEmission_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
  mediump vec4 outDiffuseOcclusion_5;
  mediump vec4 outNormal_6;
  mediump vec4 emission_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_4.xyz;
  outDiffuseOcclusion_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = _SpecColor.xyz;
  tmpvar_9.w = _Shininess;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_3 * 0.5) + 0.5);
  outNormal_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (tmpvar_4.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w);
  emission_7 = tmpvar_11;
  emission_7.xyz = (emission_7.xyz + (tmpvar_4.xyz * xlv_TEXCOORD4));
  outDiffuse_1.xyz = outDiffuseOcclusion_5.xyz;
  outEmission_2.w = emission_7.w;
  outEmission_2.xyz = exp2(-(emission_7.xyz));
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outNormal_6;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
void main()
{
    SV_Target0.w = 1.0;
    t10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = t10_0.xyz * _Color.xyz;
    SV_Target0.xyz = t10_1.xyz;
    SV_Target1.xyz = _SpecColor.xyz;
    SV_Target1.w = _Shininess;
    t10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_2.xyz;
    SV_Target2.w = 1.0;
    t16_3.xyz = t10_1.xyz * vs_TEXCOORD4.xyz;
    t10_0.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    t16_3.xyz = t10_1.xyz * t10_0.xxx + t16_3.xyz;
    SV_Target3.xyz = exp2((-t16_3.xyz));
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D unity_Lightmap;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outDiffuse_1;
  mediump vec4 outEmission_2;
  mediump vec4 tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
  tmpvar_3 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, tmpvar_3.xy);
  mediump vec3 tmpvar_7;
  tmpvar_7 = (2.0 * tmpvar_6.xyz);
  mediump vec4 outDiffuseOcclusion_8;
  mediump vec4 outNormal_9;
  mediump vec4 emission_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_5.xyz;
  outDiffuseOcclusion_8 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = _SpecColor.xyz;
  tmpvar_12.w = _Shininess;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((tmpvar_4 * 0.5) + 0.5);
  outNormal_9 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (tmpvar_5.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w);
  emission_10 = tmpvar_14;
  emission_10.xyz = (emission_10.xyz + (tmpvar_5.xyz * tmpvar_7));
  outDiffuse_1.xyz = outDiffuseOcclusion_8.xyz;
  outEmission_2.w = emission_10.w;
  outEmission_2.xyz = exp2(-(emission_10.xyz));
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = tmpvar_12;
  gl_FragData[2] = outNormal_9;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = t0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD5.xyz = t0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD5.w = t2 * (-t0.x);
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
void main()
{
    SV_Target0.w = 1.0;
    t10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = t10_0.xyz * _Color.xyz;
    SV_Target0.xyz = t10_1.xyz;
    SV_Target1.xyz = _SpecColor.xyz;
    SV_Target1.w = _Shininess;
    t10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_2.xyz;
    SV_Target2.w = 1.0;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    t10_2.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t16_3.xyz = t10_1.xyz * t10_2.xyz;
    t10_0.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    t16_3.xyz = t10_1.xyz * t10_0.xxx + t16_3.xyz;
    SV_Target3.xyz = exp2((-t16_3.xyz));
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )) + x1_12);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outDiffuse_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
  mediump vec4 outDiffuseOcclusion_4;
  mediump vec4 outNormal_5;
  mediump vec4 emission_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  outDiffuseOcclusion_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = _SpecColor.xyz;
  tmpvar_8.w = _Shininess;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((tmpvar_2 * 0.5) + 0.5);
  outNormal_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_3.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w);
  emission_6 = tmpvar_10;
  emission_6.xyz = (emission_6.xyz + (tmpvar_3.xyz * xlv_TEXCOORD4));
  outDiffuse_1.xyz = outDiffuseOcclusion_4.xyz;
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = tmpvar_8;
  gl_FragData[2] = outNormal_5;
  gl_FragData[3] = emission_6;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
void main()
{
    SV_Target0.w = 1.0;
    t10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = t10_0.xyz * _Color.xyz;
    SV_Target0.xyz = t10_1.xyz;
    SV_Target1.xyz = _SpecColor.xyz;
    SV_Target1.w = _Shininess;
    t10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_2.xyz;
    SV_Target2.w = 1.0;
    t16_3.xyz = t10_1.xyz * vs_TEXCOORD4.xyz;
    t10_0.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    SV_Target3.xyz = t10_1.xyz * t10_0.xxx + t16_3.xyz;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D unity_Lightmap;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform lowp vec4 _Color;
uniform mediump float _Shininess;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outDiffuse_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
  tmpvar_2 = xlv_TEXCOORD3;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, tmpvar_2.xy);
  mediump vec3 tmpvar_6;
  tmpvar_6 = (2.0 * tmpvar_5.xyz);
  mediump vec4 outDiffuseOcclusion_7;
  mediump vec4 outNormal_8;
  mediump vec4 emission_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_4.xyz;
  outDiffuseOcclusion_7 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = _SpecColor.xyz;
  tmpvar_11.w = _Shininess;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((tmpvar_3 * 0.5) + 0.5);
  outNormal_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_4.xyz * texture2D (_Illum, xlv_TEXCOORD0.zw).w);
  emission_9 = tmpvar_13;
  emission_9.xyz = (emission_9.xyz + (tmpvar_4.xyz * tmpvar_6));
  outDiffuse_1.xyz = outDiffuseOcclusion_7.xyz;
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = tmpvar_11;
  gl_FragData[2] = outNormal_8;
  gl_FragData[3] = emission_9;
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Illum_ST.xy + _Illum_ST.zw;
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
    vs_TEXCOORD1.xyz = t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD2.xyz = t0.xyz;
    t0.xyz = t0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD5.xyz = t0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    t0.x = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t0.x = glstate_matrix_modelview0[0].z * in_POSITION0.x + t0.x;
    t0.x = glstate_matrix_modelview0[2].z * in_POSITION0.z + t0.x;
    t0.x = glstate_matrix_modelview0[3].z * in_POSITION0.w + t0.x;
    t2 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD5.w = t2 * (-t0.x);
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
uniform 	mediump float _Shininess;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Illum_ST;
uniform 	vec4 unity_LightmapFade;
uniform 	lowp vec4 unity_Ambient;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Illum;
uniform lowp sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
lowp vec3 t10_0;
lowp vec3 t10_1;
lowp vec3 t10_2;
mediump vec3 t16_3;
void main()
{
    SV_Target0.w = 1.0;
    t10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    t10_1.xyz = t10_0.xyz * _Color.xyz;
    SV_Target0.xyz = t10_1.xyz;
    SV_Target1.xyz = _SpecColor.xyz;
    SV_Target1.w = _Shininess;
    t10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = t10_2.xyz;
    SV_Target2.w = 1.0;
    t10_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    t10_2.xyz = t10_0.xyz * vec3(2.0, 2.0, 2.0);
    t16_3.xyz = t10_1.xyz * t10_2.xyz;
    t10_0.x = texture(_Illum, vs_TEXCOORD0.zw).w;
    SV_Target3.xyz = t10_1.xyz * t10_0.xxx + t16_3.xyz;
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
Fallback "Self-Illumin/Diffuse"
}