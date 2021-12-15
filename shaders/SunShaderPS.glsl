#version 330
// Credit: OpenGL Programming Superbible Seventh Edition

in vec4 color;
out vec4 outColor;

void main() {
	outColor = vec4(color);
}