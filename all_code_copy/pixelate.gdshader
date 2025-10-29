/*
Shader from Godot Shaders - the free shader library.
godotshaders.com/shader/pixelate

This shader is under CC0 license. Feel free to use, improve and
change this shader according to your needs and consider sharing
the modified result to godotshaders.com.
*/

shader_type canvas_item;

const int x_pixel_size = 240;
const int y_pixel_size = 135;
//uniform float screen_pixel_correction = 1.77778;
uniform sampler2D screen_texture:hint_screen_texture,filter_linear;

void fragment()
{
	//int corrected_pixel_size = floor(pixel_size/screen_pixel_correction);
	float grid_uv_x = round(UV.x * float(x_pixel_size)) / float(x_pixel_size);
	float grid_uv_y = round(UV.y * float(y_pixel_size)) / float(y_pixel_size);
	vec2 grid_uv = vec2(grid_uv_x,grid_uv_y);

	vec4 text = texture(screen_texture, grid_uv);

	COLOR = text;
}