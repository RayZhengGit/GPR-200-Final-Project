#version 330

uniform mat4 matVP;
uniform float time;
uniform float sunSpeed;

layout (location = 0) in vec3 pos;

out vec4 color;

const float RADIUS = 3;
const float SCALE_FACTOR = 0.75;
const vec3 SUN_COLOR = vec3(255, 228, 105) / vec3(255);

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
	float sunX = RADIUS * cos(time * sunSpeed);
	float sunY = RADIUS * sin(time * sunSpeed);
	
	mat4 myGeo = translate(vec3(sunX, sunY, 0)) * matScale(vec3(SCALE_FACTOR));
    gl_Position = matVP * myGeo * vec4(pos, 1);
    color = vec4(SUN_COLOR, 1.0);
}