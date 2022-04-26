Shader "Hidden/ColorCorrectionCurves" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "" { }
 _RgbTex ("_RgbTex (RGB)", 2D) = "" { }
 _ZCurve ("_ZCurve (RGB)", 2D) = "" { }
 _RgbDepthTex ("_RgbDepthTex (RGB)", 2D) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 50618
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _CameraDepthTexture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _CameraDepthTexture_ST.xy) + _CameraDepthTexture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 unity_ColorSpaceLuminance;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform sampler2D _RgbTex;
uniform sampler2D _ZCurve;
uniform sampler2D _RgbDepthTex;
uniform lowp float _Saturation;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 depthBlue_1;
  mediump vec3 depthGreen_2;
  mediump vec3 depthRed_3;
  mediump float zval_4;
  mediump float theDepth_5;
  mediump vec3 blue_6;
  mediump vec3 green_7;
  mediump vec3 red_8;
  mediump vec4 color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_9 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = color_9.x;
  tmpvar_11.y = 0.125;
  lowp vec3 tmpvar_12;
  tmpvar_12 = (texture2D (_RgbTex, tmpvar_11).xyz * vec3(1.0, 0.0, 0.0));
  red_8 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = color_9.y;
  tmpvar_13.y = 0.375;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (texture2D (_RgbTex, tmpvar_13).xyz * vec3(0.0, 1.0, 0.0));
  green_7 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = color_9.z;
  tmpvar_15.y = 0.625;
  lowp vec3 tmpvar_16;
  tmpvar_16 = (texture2D (_RgbTex, tmpvar_15).xyz * vec3(0.0, 0.0, 1.0));
  blue_6 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x;
  theDepth_5 = tmpvar_17;
  highp float z_18;
  z_18 = theDepth_5;
  highp vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = (1.0/(((_ZBufferParams.x * z_18) + _ZBufferParams.y)));
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_ZCurve, tmpvar_19).x;
  zval_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = color_9.x;
  tmpvar_21.y = 0.125;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (texture2D (_RgbDepthTex, tmpvar_21).xyz * vec3(1.0, 0.0, 0.0));
  depthRed_3 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23.x = color_9.y;
  tmpvar_23.y = 0.375;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (texture2D (_RgbDepthTex, tmpvar_23).xyz * vec3(0.0, 1.0, 0.0));
  depthGreen_2 = tmpvar_24;
  mediump vec2 tmpvar_25;
  tmpvar_25.x = color_9.z;
  tmpvar_25.y = 0.625;
  lowp vec3 tmpvar_26;
  tmpvar_26 = (texture2D (_RgbDepthTex, tmpvar_25).xyz * vec3(0.0, 0.0, 1.0));
  depthBlue_1 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.xyz = mix (((red_8 + green_7) + blue_6), ((depthRed_3 + depthBlue_1) + depthGreen_2), vec3(zval_4));
  tmpvar_27.w = color_9.w;
  color_9.w = tmpvar_27.w;
  color_9.xyz = mix (vec3(dot (tmpvar_27.xyz, unity_ColorSpaceLuminance.xyz)), tmpvar_27.xyz, vec3(_Saturation));
  gl_FragData[0] = color_9;
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
uniform 	vec4 _CameraDepthTexture_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	lowp float _Saturation;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _CameraDepthTexture_ST.xy + _CameraDepthTexture_ST.zw;
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
uniform 	vec4 _CameraDepthTexture_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	lowp float _Saturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RgbTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _ZCurve;
uniform lowp sampler2D _RgbDepthTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
highp vec4 t0;
lowp vec3 t10_0;
highp vec4 t1;
mediump vec3 t16_2;
lowp vec3 t10_2;
lowp vec3 t10_3;
lowp vec3 t10_4;
mediump vec3 t16_5;
mediump vec3 t16_6;
mediump float t16_26;
void main()
{
    t0 = texture(_MainTex, vs_TEXCOORD0.xy).xzyw;
    t1.x = t0.y;
    t1.yw = vec2(0.625, 0.5);
    t10_2.xyz = texture(_RgbDepthTex, t1.xy).xyz;
    t10_3.xyz = texture(_RgbTex, t1.xy).xyz;
    t16_2.xyz = t10_2.xyz * vec3(0.0, 0.0, 1.0);
    SV_Target0.w = t0.w;
    t0.yw = vec2(0.125, 0.375);
    t10_4.xyz = texture(_RgbDepthTex, t0.xy).xyz;
    t16_5.xyz = t10_4.xyz * vec3(1.0, 0.0, 0.0) + t16_2.xyz;
    t10_2.xyz = texture(_RgbDepthTex, t0.zw).xyz;
    t16_5.xyz = t10_2.xyz * vec3(0.0, 1.0, 0.0) + t16_5.xyz;
    t10_2.xyz = texture(_RgbTex, t0.zw).xyz;
    t10_0.xyz = texture(_RgbTex, t0.xy).xyz;
    t16_2.xyz = t10_2.xyz * vec3(0.0, 1.0, 0.0);
    t16_6.xyz = t10_0.xyz * vec3(1.0, 0.0, 0.0) + t16_2.xyz;
    t16_6.xyz = t10_3.xyz * vec3(0.0, 0.0, 1.0) + t16_6.xyz;
    t16_5.xyz = t16_5.xyz + (-t16_6.xyz);
    t0.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    t0.x = _ZBufferParams.x * t0.x + _ZBufferParams.y;
    t1.z = float(1.0) / t0.x;
    t10_0.x = texture(_ZCurve, t1.zw).x;
    t16_5.xyz = t10_0.xxx * t16_5.xyz + t16_6.xyz;
    t16_26 = dot(t16_5.xyz, unity_ColorSpaceLuminance.xyz);
    t16_5.xyz = (-vec3(t16_26)) + t16_5.xyz;
    SV_Target0.xyz = vec3(_Saturation) * t16_5.xyz + vec3(t16_26);
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