shader_type canvas_item;

uniform float progress : hint_range(0, 1) = 0.5;           // Progress (0..1)
uniform int segments : hint_range(1, 32) = 10;             // Number of segments
uniform float segment_spacing : hint_range(0.0, 0.2) = 0.05;// Spacing between segments (fraction)
uniform vec4 filled_color: source_color = vec4(0.2, 0.8, 0.6, 1); // Filled segment color
uniform vec4 empty_color : source_color = vec4(0.2, 0.2, 0.2, 1);  // Empty segment color
uniform float corner_radius : hint_range(0.0, 0.5) = 0.1;  // Rounded corners (fraction of height)

void fragment() {
    // UVs: x from 0..1 left to right, y from 0..1 top to bottom
    float seg_w = (1.0 - segment_spacing * float(segments - 1)) / float(segments);
    float seg_total_w = seg_w + segment_spacing;

    int seg_idx = int(UV.x / seg_total_w);
    float seg_start = float(seg_idx) * seg_total_w;
    float seg_end = seg_start + seg_w;

    // Is this pixel inside the current segment's area?
    bool in_segment = UV.x >= seg_start && UV.x <= seg_end;

    // Rounded corners inside each segment
    float local_x = (UV.x - seg_start) / seg_w; // 0..1 inside segment
    float local_y = UV.y;
    float rad = corner_radius;

    bool inside_round = true;
    if (rad > 0.0) {
        // Left edge
        if (local_x < rad && local_y < rad) {
            inside_round = distance(vec2(local_x, local_y), vec2(rad, rad)) <= rad;
        }
        // Right edge
        if (local_x > 1.0 - rad && local_y < rad) {
            inside_round = distance(vec2(local_x, local_y), vec2(1.0 - rad, rad)) <= rad;
        }
        // Left bottom
        if (local_x < rad && local_y > 1.0 - rad) {
            inside_round = distance(vec2(local_x, local_y), vec2(rad, 1.0 - rad)) <= rad;
        }
        // Right bottom
        if (local_x > 1.0 - rad && local_y > 1.0 - rad) {
            inside_round = distance(vec2(local_x, local_y), vec2(1.0 - rad, 1.0 - rad)) <= rad;
        }
    }

    // Progress threshold: how many segments should be filled?
    float seg_fill = progress * float(segments);
    bool filled = float(seg_idx) < seg_fill;

    // Only draw inside segment + rounded corner
    if (in_segment && inside_round) {
        COLOR = filled ? filled_color : empty_color;
    } else {
        COLOR = vec4(0.0);
    }
}