shader_type canvas_item;

uniform vec4 top_color : source_color = vec4(0.15, 0.18, 0.21, 1.0);   // gradient top
uniform vec4 bottom_color : source_color = vec4(0.08, 0.09, 0.11, 1.0); // gradient bottom
uniform vec4 border_color : source_color = vec4(0.3, 0.35, 0.38, 1.0);  // border color
uniform float border_thickness : hint_range(0.0, 10.0) = 2.0;
uniform float corner_radius : hint_range(0.0, 50.0) = 16.0;

void fragment() {
    // Gradient fill
    float t = UV.y;
    vec4 fill = mix(top_color, bottom_color, t);

    // Distance to panel edges (for rounded corners)
    vec2 size = vec2(SCREEN_PIXEL_SIZE.x * vec2(1920.0,1080.0).x, SCREEN_PIXEL_SIZE.y * vec2(1920.0,1080.0).y);
    vec2 pos = FRAGCOORD.xy / size;
    vec2 rect_size = vec2(1.0, 1.0);

    // Rounded corner mask
    vec2 dist = min(pos, rect_size - pos);
    float corner_dist = min(dist.x, dist.y) * min(size.x, size.y);
    float inside = smoothstep(corner_radius - 1.0, corner_radius + 1.0, corner_dist);

    // Border mask
    float border = step(corner_radius, corner_dist + border_thickness);

    // Mix fill + border
    COLOR = mix(border_color, fill, border) * inside;
}
