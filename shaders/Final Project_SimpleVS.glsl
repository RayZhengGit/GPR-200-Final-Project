#version 330

uniform mat4 matVP;
uniform mat4 matGeo;

uniform vec3 translation;
uniform vec3 rotation;
uniform vec3 scale;

layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 normal;

out vec4 color;

mat4 translate(vec3 translation) {
	return mat4(
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		translation.x, translation.y, translation.z, 1
	);
}

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

mat4 matScale(vec3 factor) {
	return mat4(
		factor.x, 0, 0, 0,
		0, factor.y, 0, 0,
		0, 0, factor.z, 0,
		0, 0, 0, 1
	);
}

void main() {
   color = vec4(abs(normal), 1.0);
   
   mat4 matModel = translate(translation) * rotate(rotation) * matScale(scale);
   gl_Position = matVP * matModel * vec4(pos, 1);
}
