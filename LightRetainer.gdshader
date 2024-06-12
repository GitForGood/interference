shader_type canvas_item;

uniform vec2 light_position;
uniform float light_radius;
uniform float update_threshold;

void fragment() {
    vec2 uv = SCREEN_UV * SCREEN_PIXEL_SIZE;
    float distance = length(uv - light_position);
    
    // Initial blacked out state
    vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
    
    // Update to gray based on distance to light
    if (distance < light_radius) {
        color = mix(vec4(0.5, 0.5, 0.5, 1.0), color, distance / light_radius);
    }
    
    COLOR = color;
}
