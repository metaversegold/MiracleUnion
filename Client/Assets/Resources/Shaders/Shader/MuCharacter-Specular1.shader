Shader "MuCharacter/Specular1" {
Properties {
 _MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" { }
 _Color ("Main Color", Color) = (1,1,1,1)
 _Cube ("Reflection Cubemap", CUBE) = "_Skybox" { }
 _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
 _SpecPow ("SpecularPower", Range(0.1,30)) = 15
 _SpecColor1 ("Spec Light Color 1", Color) = (1,1,1,1)
 _TimeScale1 ("Time Scale for Animation 1", Float) = 8
 _ViewDirTex1 ("View Direction Animation 1", 2D) = "white" { }
}
SubShader { 
 LOD 2000
 Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
 Pass {
  Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
  Cull Off
  GpuProgramID 58415
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform mediump mat4 _RotateMatrix;
uniform mediump mat4 _Wolrd2HV;
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
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  tmpvar_4 = ((_Wolrd2HV * _Object2World) * tmpvar_10).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp vec4 _ReflectColor;
uniform sampler2D _MainTex;
uniform lowp samplerCube _Cube;
uniform mediump float _SpecPow;
uniform lowp vec4 _SpecColor1;
uniform mediump float _TimeScale1;
uniform sampler2D _ViewDirTex1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp float specPow_1;
  lowp vec3 viewDirInViewSpace_2;
  lowp vec3 normalV_3;
  lowp vec4 baseColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  baseColor_4.w = tmpvar_5.w;
  baseColor_4.xyz = (tmpvar_5.xyz + (textureCube (_Cube, xlv_TEXCOORD1).xyz * _ReflectColor.xyz));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2);
  normalV_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.y = 0.0;
  tmpvar_7.x = (_Time.x * _TimeScale1);
  viewDirInViewSpace_2.xz = ((texture2D (_ViewDirTex1, tmpvar_7).xyz * 2.0) - 1.0).xz;
  viewDirInViewSpace_2.y = 0.0;
  lowp float tmpvar_8;
  tmpvar_8 = dot (normalize(viewDirInViewSpace_2), normalV_3);
  specPow_1 = 0.0;
  if ((tmpvar_8 > 0.0)) {
    mediump float tmpvar_9;
    tmpvar_9 = pow (tmpvar_8, _SpecPow);
    specPow_1 = tmpvar_9;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = (baseColor_4 + (_SpecColor1 * specPow_1)).xyz;
  tmpvar_10.w = baseColor_4.w;
  gl_FragData[0] = tmpvar_10;
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
mediump vec4 t16_0;
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
    t16_0.x = _Wolrd2HV[0].x;
    t16_0.y = _Wolrd2HV[1].x;
    t16_0.z = _Wolrd2HV[2].x;
    t16_0.w = _Wolrd2HV[3].x;
    t2.x = dot(t16_0, _Object2World[0]);
    t2.y = dot(t16_0, _Object2World[1]);
    t2.z = dot(t16_0, _Object2World[2]);
    t2.x = dot(t2.xyz, in_NORMAL0.xyz);
    t16_0.x = _Wolrd2HV[0].y;
    t16_0.y = _Wolrd2HV[1].y;
    t16_0.z = _Wolrd2HV[2].y;
    t16_0.w = _Wolrd2HV[3].y;
    t3.x = dot(t16_0, _Object2World[0]);
    t3.y = dot(t16_0, _Object2World[1]);
    t3.z = dot(t16_0, _Object2World[2]);
    t2.y = dot(t3.xyz, in_NORMAL0.xyz);
    t16_0.x = _Wolrd2HV[0].z;
    t16_0.y = _Wolrd2HV[1].z;
    t16_0.z = _Wolrd2HV[2].z;
    t16_0.w = _Wolrd2HV[3].z;
    t3.x = dot(t16_0, _Object2World[0]);
    t3.y = dot(t16_0, _Object2World[1]);
    t3.z = dot(t16_0, _Object2World[2]);
    t2.z = dot(t3.xyz, in_NORMAL0.xyz);
    vs_TEXCOORD2.xyz = t2.xyz;
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
uniform lowp sampler2D _ViewDirTex1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out lowp vec4 SV_Target0;
highp vec2 t0;
mediump vec2 t16_0;
lowp vec3 t10_0;
bool tb0;
lowp vec3 t10_1;
mediump vec4 t16_2;
lowp vec4 t10_2;
lowp vec3 t10_3;
mediump vec3 t16_4;
void main()
{
    t0.x = _Time.x * _TimeScale1;
    t0.y = 0.0;
    t10_0.xy = texture(_ViewDirTex1, t0.xy).xz;
    t16_0.xy = t10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    t10_1.x = dot(t16_0.xy, t16_0.xy);
    t10_1.x = inversesqrt(t10_1.x);
    t10_1.xy = t16_0.xy * t10_1.xx;
    t16_2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    t16_2.x = inversesqrt(t16_2.x);
    t16_2.xy = t16_2.xx * vs_TEXCOORD2.xz;
    t10_1.x = dot(t10_1.xy, t16_2.xy);
    t16_2.x = log2(t10_1.x);
    tb0 = 0.0<t10_1.x;
    t16_2.x = t16_2.x * _SpecPow;
    t16_2.x = exp2(t16_2.x);
    t16_4.xyz = t16_2.xxx * _SpecColor1.xyz;
    t10_1.xyz = (bool(tb0)) ? t16_4.xyz : vec3(0.0, 0.0, 0.0);
    t10_0.xyz = texture(_Cube, vs_TEXCOORD1.xyz).xyz;
    t10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    t16_2 = t10_2 * _Color;
    t10_3.xyz = t10_0.xyz * _ReflectColor.xyz + t16_2.xyz;
    SV_Target0.w = t16_2.w;
    SV_Target0.xyz = t10_1.xyz + t10_3.xyz;
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
Fallback "MuCharacter/Base"
}