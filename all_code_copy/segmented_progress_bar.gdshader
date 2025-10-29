shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.5; // Fill percent (0–1)
uniform int segments : hint_range(1, 100) = 10;      // Number of segments
uniform vec4 filled_color : source_color = vec4(0.2, 0.8, 0.2, 1.0); // Green
uniform vec4 empty_color : source_color = vec4(0.2, 0.2, 0.2, 1.0);  // Gray
uniform float gap : hint_range(0.0, 0.1) = 0.02;     // Gap between segments (percent of segment width)

void fragment() {
    // Normalized UV across the rect
    float x = UV.x;

    // Determine which segment we are in
    float seg_width = 1.0 / float(segments);
    int seg_index = int(floor(x / seg_width));

    // Progress in terms of filled segments
    float filled_segments = progress * float(segments);

    // Fraction inside this segment (0 → left edge, 1 → right edge)
    float local_x = (x - float(seg_index) * seg_width) / seg_width;

    // Check if this segment is "filled"
    vec4 color = empty_color;

    if (float(seg_index) + local_x < filled_segments) {
        color = filled_color;
    }

    // Add gap between segments
    if (local_x < gap * 0.5 || local_x > 1.0 - gap * 0.5) {
        color = vec4(0.0, 0.0, 0.0, 0.0); // Transparent gap
    }

    COLOR = color;
}
