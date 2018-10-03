shader_type spatial;
render_mode unshaded;
uniform sampler2D viewport_texture : hint_albedo;

void fragment()
{
	//highp vec3 col = texture(viewport_texture, SCREEN_UV).rgb;
	//ALBEDO = col;
	ALBEDO = texture(viewport_texture, SCREEN_UV).rgb;
}