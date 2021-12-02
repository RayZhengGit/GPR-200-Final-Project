#version 330

uniform mat4 matVP;
uniform mat4 matGeo;
uniform float time;

layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 normal;

out vec4 color;

mat4 translation(vec3 loc) {


	return mat4(
	1,0,0,0,
	0,1,0,0,
	0,0,1,0,
	loc.x,loc.y,loc.z,1);
}


void main() {

	float speed = 0.25;
	float radius = 3;
	float x = radius * cos(time * speed);
	float y = radius * sin(time * speed);


	mat4 myGeo = translation(vec3(x,y,0));

    color = vec4(1, 1, 190 / 255.0, 1.0);
    gl_Position = matVP * myGeo * matGeo * vec4(pos, 1);
}