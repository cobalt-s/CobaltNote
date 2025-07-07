#include <metal_stdlib>

using namespace metal;

// This shader calculates a new coordinate for each pixel, creating the distortion.
[[visible]] float2 waterEffect(float2 position, float time) {
    // We create an offset based on time and the pixel's position
    float2 offset;
    offset.y = sin(position.x * 0.05 + time) * 10.0;
    offset.x = cos(position.y * 0.05 + time * 0.7) * 10.0;
    
    // Return the original position plus the offset
    return position + offset;
}
