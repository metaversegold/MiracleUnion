Shader "Hidden/GrabPass" 
{
	SubShader {
		Tags { "Queue"="Transparent+10" "RenderType"="Opaque" }
		LOD 200
		
		GrabPass {							
			Name "BASE"
			Tags { "LightMode" = "Always" }
 		}
	}
}