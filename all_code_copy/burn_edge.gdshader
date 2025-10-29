shader_type canvas_item;

// Uniform to control the tint of the shader's output
uniform vec4 modulate : source_color = vec4(1.0, 1.0, 1.0, 1.0);

uniform sampler2D dissolve_texture : source_color;
uniform float dissolve_value : hint_range(0, 1.0);
uniform float burn_size: hint_range(0.0, 1.0, 0.01);
uniform vec4 burn_color: source_color;

void fragment(){
    vec4 main_texture = texture(TEXTURE, UV);
    vec4 noise_texture = texture(dissolve_texture, UV);
    
    // This is needed to avoid keeping a small burn_color dot with dissolve being 0 or 1
    float burn_size_step = burn_size * step(0.001, dissolve_value) * step(dissolve_value, 0.999);
    float threshold = smoothstep(noise_texture.x - burn_size_step, noise_texture.x, dissolve_value);
    float border = smoothstep(noise_texture.x, noise_texture.x + burn_size_step, dissolve_value);
    
    // The initial COLOR value is the sprite's texture color
    // We modify its alpha based on the dissolve threshold
    COLOR.a *= threshold;
    // We set its color based on the dissolve border
    COLOR.rgb = mix(burn_color.rgb, main_texture.rgb, border);
    
    // Finally, multiply the result by the modulate color to apply the tint
    COLOR *= modulate;
}