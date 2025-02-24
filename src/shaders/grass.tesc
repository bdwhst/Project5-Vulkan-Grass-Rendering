#version 450
#extension GL_ARB_separate_shader_objects : enable


layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(vertices = 1) out;

layout (location = 0) in vec3 inV0[];
layout (location = 1) in vec3 inV1[];
layout (location = 2) in vec3 inV2[];
layout (location = 3) in vec3 in_dir_height_width[];

layout (location = 0) out vec3 outV0[];
layout (location = 1) out vec3 outV1[];
layout (location = 2) out vec3 outV2[];
layout (location = 3) out vec3 out_dir_height_width[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    outV0[gl_InvocationID] = inV0[gl_InvocationID];
    outV1[gl_InvocationID] = inV1[gl_InvocationID];
    outV2[gl_InvocationID] = inV2[gl_InvocationID];
    out_dir_height_width[gl_InvocationID] = in_dir_height_width[gl_InvocationID];

    const float min_dist=2.0f;
    const float max_dist=20.0f;
    float dist = length(vec3(camera.view*vec4(inV0[gl_InvocationID],1.0f)));
    int levels = int(mix(10.0,3.0,clamp((dist-min_dist)/(max_dist-min_dist),0.0,1.0)));
	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = levels;
    gl_TessLevelInner[1] = levels;
    gl_TessLevelOuter[0] = levels;
    gl_TessLevelOuter[1] = levels;
    gl_TessLevelOuter[2] = levels;
    gl_TessLevelOuter[3] = levels;
}
