shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest_mipmap, repeat_enable;

group_uniforms Contrast;
// Modify other settings such as brightness, contrast, and invert.
uniform float contrast : hint_range(-1.0, 1.0, 0.1) = 0.0;

void fragment() {
	// Get the color from our sprite texture.
	vec4 input_color = texture(screen_texture, SCREEN_UV);
	
	// Drop the alpha value so modulate transparency effects still work on the sprite.
	vec3 color_rgb = input_color.rgb;

	// Adjust color contrast around 0.5.
	color_rgb = (color_rgb - 0.5) * (1.0 + contrast) + 0.5;
	
	// Update the sprite texture color.
	COLOR.rgb = color_rgb;
}