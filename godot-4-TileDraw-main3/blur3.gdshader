shader_type canvas_item;
render_mode blend_mix;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float amount = 0.001;
uniform vec4 color_over : source_color;
uniform float mix_amount : hint_range(0.0, 1.0);

void fragment() {
	vec4 new_color = texture(TEXTURE, UV);
	vec2 pixel_size = TEXTURE_PIXEL_SIZE;

	new_color += texture(TEXTURE, UV + vec2(0, -amount) * pixel_size);
	new_color += texture(TEXTURE, UV + vec2(0, amount) * pixel_size);
	new_color += texture(TEXTURE, UV + vec2(-amount, 0) * pixel_size);
	new_color += texture(TEXTURE, UV + vec2(amount, 0) * pixel_size);

	new_color += texture(TEXTURE, UV + vec2(-amount, amount) * pixel_size);
	new_color += texture(TEXTURE, UV + vec2(amount, amount) * pixel_size);

	new_color += texture(TEXTURE, UV + vec2(-amount, -amount) * pixel_size);
	new_color += texture(TEXTURE, UV + vec2(amount, -amount) * pixel_size);

	//COLOR = new_color / 7.0 * color_over;
	COLOR = mix( new_color / 7.0, color_over, mix_amount );
}
