#version 450 core

// tessellation control shader: runs once per patch vertex, sets how finely the patch is subdivided
layout (vertices = 3) out;

uniform float uLevel;

void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = uLevel;
        gl_TessLevelOuter[0] = uLevel;
        gl_TessLevelOuter[1] = uLevel;
        gl_TessLevelOuter[2] = uLevel;
    }
}
