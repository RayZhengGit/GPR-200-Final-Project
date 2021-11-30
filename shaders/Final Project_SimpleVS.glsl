#version 330

uniform mat4 matVP;
uniform float time;

layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 normal;

out vec4 color;

mat4 rotate(vec3 rotation) {
	mat4 matRotationX = mat4(
		1, 0, 0, 0,
		0, cos(rotation.x), -sin(rotation.x), 0,
		0, sin(rotation.x), cos(rotation.x), 0,
		0, 0, 0, 1
	);
	mat4 matRotationY = mat4(
		cos(rotation.y), 0, sin(rotation.y), 0,
		0, 1, 0, 0,
		-sin(rotation.y), 0, cos(rotation.y), 0,
		0, 0, 0, 1
	);
	mat4 matRotationZ = mat4(
		cos(rotation.z), sin(rotation.z), 0, 0,
		-sin(rotation.z), cos(rotation.z), 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1
	);
	return matRotationZ * matRotationY * matRotationX;
}

void main() {
	// ToDo: apply metal texture
	// This might be helpful... https://www.lighthouse3d.com/tutorials/glsl-tutorial/texturing-with-images/
	color = vec4(abs(normal), 1.0);
	
	// Rotating Cube Animation
	vec3 speed = vec3(0.25, 0.25, 0.25);
	vec3 animation = vec3(time * speed);
	gl_Position = matVP * rotate(animation) * vec4(pos, 1);
}
