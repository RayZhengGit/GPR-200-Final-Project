#version 330
// Credit: OpenGL Programming Superbible Seventh Edition

layout (location = 0) in vec4 position;
layout (location = 1) in vec2 texCoord;
layout (location = 2) in vec3 normal;

uniform mat4 matVP;
uniform float time;
uniform vec3 boxSpeed;

uniform vec3 diffuse_albedo;
uniform vec3 specular_albedo;
uniform float specular_power;
uniform vec3 ambient; // Gouraud only

out vec3 N;
out vec3 L;
out vec3 V;
out vec2 uv;
out vec3 gouraudLighting;

const float SUN_SPEED = 0.75;
const float SUN_RADIUS = 1.15;

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
	vec3 animation = vec3(time * boxSpeed);
	mat4 myMatGeo = rotate(animation);
	gl_Position = matVP * myMatGeo * vec4(position);
	uv = texCoord;
	
	float sunX = SUN_RADIUS * cos(time * SUN_SPEED);
	float sunY = SUN_RADIUS * sin(time * SUN_SPEED);
	vec3 light_pos = vec3(sunX, sunY, 0);
	
	vec4 P = myMatGeo * position;
    N = mat3(myMatGeo) * normal;
    L = light_pos - P.xyz;
    V = -P.xyz;
	
	// Gouraud Lighting
	vec3 gouraudN = normalize(mat3(myMatGeo) * normal);
    vec3 gouraudL = normalize(light_pos - P.xyz);
    vec3 gouraudV = normalize(-P.xyz);
      
    vec3 R = reflect(-gouraudL, gouraudN);
    vec3 diffuse = max(dot(gouraudN, gouraudL), 0.0) * diffuse_albedo;
    vec3 specular = pow(max(dot(R, gouraudV), 0.0), specular_power) * specular_albedo;
	gouraudLighting = ambient + diffuse + specular;
}