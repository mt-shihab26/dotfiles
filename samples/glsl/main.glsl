#type vertex
#version 450 core

// vertex shader: runs once per vertex, outputs its clip-space position
layout(location = 0) in vec3 aPos;
layout(location = 1) in vec3 aColor;

uniform mat4 uMvp;

out vec3 vColor;

void main() {
    vColor = aColor;
    gl_Position = uMvp * vec4(aPos, 1.0);
}


#type fragment
#version 450 core

// fragment shader: runs once per fragment, outputs its color
in vec3 vColor;

out vec4 FragColor;

void main() {
    FragColor = vec4(vColor, 1.0);
}
