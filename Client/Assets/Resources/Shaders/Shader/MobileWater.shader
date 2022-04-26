Shader "MobileWater/MobileWater" {
Properties {
 _Color ("Water Colour", Color) = (1,1,1,1)
 _MainTex ("Water Texture", 2D) = "" { }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 69273
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100
precision highp float;
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_NO_LINEAR_COLORSPACE 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

        varying mediump vec2 uv;
                     
        

#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform highp mat4 glstate_matrix_mvp;
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;

        uniform mediump vec4 _MainTex_ST;
        void main() {
   gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            uv = gl_MultiTexCoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        }
  
#endif
#ifdef FRAGMENT

        uniform lowp sampler2D _MainTex;
        uniform lowp vec4 _Color;
        void main() {
            gl_FragColor = texture2D(_MainTex, uv) * _Color;
        }

        
#endif"
}
SubProgram "gles3 " {
"!!GLES3
#version 300 es
precision highp float;
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_NO_LINEAR_COLORSPACE 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

        varying mediump vec2 uv;
                     
        

#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform highp mat4 glstate_matrix_mvp;
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

        uniform mediump vec4 _MainTex_ST;
        void main() {
   gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            uv = gl_MultiTexCoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        }
  
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

        uniform lowp sampler2D _MainTex;
        uniform lowp vec4 _Color;
        void main() {
            gl_FragColor = texture(_MainTex, uv) * _Color;
        }

        
#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES
#version 100
precision highp float;
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_NO_LINEAR_COLORSPACE 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

        varying mediump vec2 uv;
                     
        

#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform highp mat4 glstate_matrix_mvp;
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;

        uniform mediump vec4 _MainTex_ST;
        void main() {
   gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            uv = gl_MultiTexCoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        }
  
#endif
#ifdef FRAGMENT

        uniform lowp sampler2D _MainTex;
        uniform lowp vec4 _Color;
        void main() {
            gl_FragColor = texture2D(_MainTex, uv) * _Color;
        }

        
#endif"
}
SubProgram "gles3 " {
"!!GLES3
#version 300 es
precision highp float;
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_NO_LINEAR_COLORSPACE 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

        varying mediump vec2 uv;
                     
        

#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform highp mat4 glstate_matrix_mvp;
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

        uniform mediump vec4 _MainTex_ST;
        void main() {
   gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            uv = gl_MultiTexCoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        }
  
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

        uniform lowp sampler2D _MainTex;
        uniform lowp vec4 _Color;
        void main() {
            gl_FragColor = texture(_MainTex, uv) * _Color;
        }

        
#endif"
}
}
 }
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha One
  ColorMask RGB
  GpuProgramID 35413
Program "vp" {
SubProgram "gles " {
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_TEXCOORD1;
void main ()
{
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD1 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  color_1 = _Color;
  color_1 = (color_1 * texture2D (_MainTex, xlv_TEXCOORD0));
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in lowp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out lowp vec4 vs_TEXCOORD1;
highp vec4 t0;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD1 = in_COLOR0;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out lowp vec4 SV_Target0;
lowp vec4 t10_0;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = t10_0 * _Color;
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
}