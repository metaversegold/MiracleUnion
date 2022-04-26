sampler2D _DissolveTex;
half _Dissolve;

fixed4 calcDissolve(fixed4 color, half2 uv)
{
	half dissolve = tex2D (_DissolveTex, uv).a;
	clip(dissolve - _Dissolve);
	return color;
}