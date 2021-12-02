#version 330

in vec4 color;
out vec4 outColor;
uniform sampler2D text;

in vec2 uv;

void main() {
   outColor = texture(text, uv);
}