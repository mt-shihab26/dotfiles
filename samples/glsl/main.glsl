// shared helpers, no stage of its own: meant to be included by the other shaders

float luminance(vec3 color) {
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

vec3 gammaCorrect(vec3 color) {
    return pow(color, vec3(1.0 / 2.2));
}
