// Shared variable passed to the fragment shader
varying vec3 color;
uniform float angle;
// Constant set via your javascript code
uniform vec3 lightPosition;

void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);

	// Identifying the head
	mat4 rotation_x = mat4(
						   vec4(1.0, 0.0 , 0.0 , 0.0),
						   vec4(0.0 ,cos(angle),sin(angle), 0.0),
						   vec4(0.0 ,-sin(angle),cos(angle), 0.0),
						   vec4(0.0 , 0.0 , 0.0 ,1.0));

	mat4 backToOrigin = mat4(1.0, 0.0, 0.0, 0.0,
							 0.0, 1.0, 0.0, 0.0,
							 0.0, 0.0, 1.0, 0.0,
							 0.0, -2.48, 0.37, 1.0);
	
	mat4 backToPoint = mat4(1.0, 0.0, 0.0, 0.0,
							 0.0, 1.0, 0.0, 0.0,
							 0.0, 0.0, 1.0, 0.0,
							 0.0, 2.48, -0.37, 1.0);
	
	if (position.z < -0.33 && abs(position.x) < 0.46){
		gl_Position = projectionMatrix * modelViewMatrix * backToPoint * rotation_x * backToOrigin * vec4(position, 1.0);
		}else{

		
	
	
	

	// Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}}
