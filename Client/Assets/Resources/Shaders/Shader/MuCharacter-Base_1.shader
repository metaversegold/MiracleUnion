Shader "MuCharacter/Base" {
Properties {
 _MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" { }
 _Color ("Main Color", Color) = (1,1,1,1)
 _Cube ("Reflection Cubemap", CUBE) = "_Skybox" { }
 _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
 Pass {
  Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
  Cull Off
  GpuProgramID 62678
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _World2Object;
uniform mediump mat4 _RotateMatrix;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 reflectDir_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((_World2Object * tmpvar_6).xyz - _glesVertex.xyz));
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 - (2.0 * (
    dot (_glesNormal, tmpvar_7)
   * _glesNormal)));
  reflectDir_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = reflectDir_1;
  tmpvar_3 = ((_RotateMatrix * glstate_matrix_modelview0) * tmpvar_9).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform lowp vec4 _ReflectColor;
uniform sampler2D _MainTex;
uniform lowp samplerCube _Cube;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = (tmpvar_1.xyz + (textureCube (_Cube, xlv_TEXCOORD1).xyz * _ReflectColor.xyz));
  tmpvar_2.w = tmpvar_1.w;
  gl_FragData[0] = tmpvar_2;
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
uniform 	lowp vec4 _Color;
uniform 	lowp vec4 _ReflectColor;
uniform 	mediump float _SpecPow;
uniform 	lowp vec4 _SpecColor1;
uniform 	mediump float _TimeScale1;
uniform 	mediump float _LightScale;
uniform 	lowp vec4 _SpecColor2;
uniform 	mediump float _TimeScale2;
uniform 	mediump mat4 _RotateMatrix;
uniform 	mediump mat4 _Wolrd2HV;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
highp vec4 t0;
mediump vec4 t16_1;
highp vec3 t2;
highp vec3 t3;
highp float t12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    t0.xyz = _WorldSpaceCameraPos.xyzx.yyy * _World2Object[1].xyz;
    t0.xyz = _World2Object[0].xyz * _WorldSpaceCameraPos.xyzx.xxx + t0.xyz;
    t0.xyz = _World2Object[2].xyz * _WorldSpaceCameraPos.xyzx.zzz + t0.xyz;
    t0.xyz = t0.xyz + _World2Object[3].xyz;
    t0.xyz = t0.xyz + (-in_POSITION0.xyz);
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t12 = dot(t0.xyz, in_NORMAL0.xyz);
    t12 = t12 + t12;
    t0.xyz = in_NORMAL0.xyz * (-vec3(t12)) + t0.xyz;
    t16_1.x = _RotateMatrix[0].x;
    t16_1.y = _RotateMatrix[1].x;
    t16_1.z = _RotateMatrix[2].x;
    t16_1.w = _RotateMatrix[3].x;
    t2.x = dot(t16_1, glstate_matrix_modelview0[0]);
    t2.y = dot(t16_1, glstate_matrix_modelview0[1]);
    t2.z = dot(t16_1, glstate_matrix_modelview0[2]);
    t2.x = dot(t2.xyz, t0.xyz);
    t16_1.x = _RotateMatrix[0].y;
    t16_1.y = _RotateMatrix[1].y;
    t16_1.z = _RotateMatrix[2].y;
    t16_1.w = _RotateMatrix[3].y;
    t3.x = dot(t16_1, glstate_matrix_modelview0[0]);
    t3.y = dot(t16_1, glstate_matrix_modelview0[1]);
    t3.z = dot(t16_1, glstate_matrix_modelview0[2]);
    t2.y = dot(t3.xyz, t0.xyz);
    t16_1.x = _RotateMatrix[0].z;
    t16_1.y = _RotateMatrix[1].z;
    t16_1.z = _RotateMatrix[2].z;
    t16_1.w = _RotateMatrix[3].z;
    t3.x = dot(t16_1, glstate_matrix_modelview0[0]);
    t3.y = dot(t16_1, glstate_matrix_modelview0[1]);
    t3.z = dot(t16_1, glstate_matrix_modelview0[2]);
    t2.z = dot(t3.xyz, t0.xyz);
    vs_TEXCOORD1.xyz = t2.xyz;
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	lowp vec4 _Color;
uniform 	lowp vec4 _ReflectColor;
uniform 	mediump float _SpecPow;
uniform 	lowp vec4 _SpecColor1;
uniform 	mediump float _TimeScale1;
uniform 	mediump float _LightScale;
uniform 	lowp vec4 _SpecColor2;
uniform 	mediump float _TimeScale2;
uniform 	mediump mat4 _RotateMatrix;
uniform 	mediump mat4 _Wolrd2HV;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _Cube;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out lowp vec4 SV_Target0;
lowp vec3 t10_0;
mediump vec4 t16_1;
lowp vec4 t10_1;
void main()
{
    t10_0.xyz = texture(_Cube, vs_TEXCOORD1.xyz).xyz;
    t10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_1 = t10_1 * _Color;
    SV_Target0.xyz = t10_0.xyz * _ReflectColor.xyz + t16_1.xyz;
    SV_Target0.w = t16_1.w;
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
Fallback "Mobile/Diffuse"
}