#version 450 core

// geometry shader: runs once per primitive, can emit new primitives
layout (triangles) in;
layout (line_strip, max_vertices = 4) out;

void main() {
    // turn each triangle into its outline
    for (int i = 0; i < 4; i++) {
        gl_Position = gl_in[i % 3].gl_Position;
        EmitVertex();
    }
    EndPrimitive();
}
