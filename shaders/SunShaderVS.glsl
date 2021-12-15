#version 330
// Credit: OpenGL Programming Superbible Seventh Edition

layout (location = 0) in vec3 position;

uniform mat4 matVP;
uniform float time;

out vec4 color;

const float SPEED = 0.75;
const float RADIUS = 1.15;
const float SCALE_FACTOR = 0.15;
const vec3 COLOR = vec3(255, 228, 105) / vec3(255);

mat4 translate(vec3 translation) {
	return mat4(
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		translation.x, translation.y, translation.z, 1
	);
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
	float sunX = RADIUS * cos(time * SPEED);
	float sunY = RADIUS * sin(time * SPEED);
	
	mat4 myMatGeo = translate(vec3(sunX, sunY, 0)) * matScale(vec3(SCALE_FACTOR));
    gl_Position = matVP * myMatGeo * vec4(position, 1);
    color = vec4(COLOR, 1.0);
}