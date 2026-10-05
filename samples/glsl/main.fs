#version 450 core

// fragment shader: runs once per fragment, outputs its color
in vec3 vColor;

out vec4 FragColor;

void main() {
    FragColor = vec4(vColor, 1.0);
}
