#version 410

layout(location=0) 
in vec3 color; 
out vec4 vFragColor;

void main() {
    vFragColor = vec4(color, 1.0);
}
