#version 450 core

// tessellation evaluation shader: runs once per generated vertex, places it on the patch
layout(triangles, equal_spacing, ccw) in;

void main() {
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position
            + gl_TessCoord.y * gl_in[1].gl_Position
            + gl_TessCoord.z * gl_in[2].gl_Position;
}
