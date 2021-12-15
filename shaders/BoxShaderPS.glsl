#version 330
// Credit: OpenGL Programming Superbible Seventh Edition

uniform sampler2D tex;

uniform vec3 diffuse_albedo;
uniform vec3 specular_albedo;
uniform float specular_power;

uniform bool isPhongLighting;
uniform bool isGouraudLighting;
uniform bool isBlinnPhongLighting;

in vec3 N;
in vec3 L;
in vec3 V;
in vec2 uv;
in vec3 gouraudLighting;

out vec4 outColor;

vec3 getPhongLighting() {
	vec3 N = normalize(N);
	vec3 L = normalize(L);
	vec3 V = normalize(V);

    vec3 R = reflect(-L, N);
    float diffuseValue = dot(N, L);
    vec3 diffuse = max(diffuseValue, 0.0) * diffuse_albedo;
    
    vec3 specular = vec3(0.0);
    if (diffuseValue > 0.0) {
    	specular = pow(max(dot(R, V), 0.0), specular_power) * specular_albedo;
    }
    
	return diffuse + specular;
}

vec3 getBlinnPhongLighting() {
	vec3 N = normalize(N);
	vec3 L = normalize(L);
	vec3 V = normalize(V);
	
    vec3 H = normalize(L + V);
    vec3 diffuse = max(dot(N, L), 0.0) * diffuse_albedo;
    vec3 specular = pow(max(dot(N, H), 0.0), specular_power) * specular_albedo;
    
	return diffuse + specular;
}

void main() {
	vec3 lighting = vec3(1.0);
	if (isPhongLighting) {
		lighting = getPhongLighting();
	} else if (isGouraudLighting) {
		lighting = gouraudLighting;
	} else if (isBlinnPhongLighting) {
		lighting = getBlinnPhongLighting();
	}	
	outColor = texture(tex, uv) * vec4(lighting, 1.0);
} 