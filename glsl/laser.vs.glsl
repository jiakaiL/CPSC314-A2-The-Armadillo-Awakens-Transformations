// Shared variable passed to the fragment shader

uniform vec3 lightPosition;
uniform vec3 LOrR;


void main() {

  
   mat4 rotation_x = mat4(1.0, 0.0, 0.0, 0.0,
                       0.0, 0.0, -1.0, 0.0,
                       0.0, 1.0, 0.0, 0.0,
                       0.0, 0.0, 0.0,1.0);
                       
  mat4 translation = mat4(1.0, 0.0, 0.0, 0.0,
                          0.0, 1.0, 0.0, 0.0,
                          0.0, 0.0, 1.0, 0.0,
                          0.04,4.1, -1.1,1.0);
  
  mat4 translation_LorR = mat4(
                          1.0, 0.0, 0.0, 0.0,
                          0.0, 1.0, 0.0, 0.0,
                          0.0, 0.0, 1.0, 0.0,
                          LOrR.x,LOrR.y,LOrR.z,1.0);
  
 vec3 laserPoint = vec3(0.04,4.1,-1.1);
 vec4 laserWorld = modelMatrix * vec4(laserPoint,1.0);
 vec3 laserWorldPoint = vec3(laserWorld.x,laserWorld.y,laserWorld.z);

 float scale = 0.82*distance(laserWorldPoint,lightPosition);

 mat4 scaleMatrix = mat4(1.0,  0.0,   0.0, 0.0,
                         0.0,  scale, 0.0, 0.0,
                         0.0,  0.0,   1.0, 0.0,
                         0.0,  0.0,   0.0, 1.0);
//lookAt Matrix 

vec3 up = vec3(0.0, 1.0, 0.0);
vec3 zaxis = normalize((laserWorldPoint+0.5*LOrR)-lightPosition);
vec3 xaxis = normalize(cross(up,zaxis));
vec3 yaxis = cross(zaxis,xaxis);

mat4 lookAt = mat4(
    vec4(xaxis, 0.0),
    vec4(yaxis, 0.0),
    vec4(zaxis, 0.0),
    vec4(0.0,       0.0,       0.0,       1.0)
  );





 gl_Position = projectionMatrix * modelViewMatrix * translation_LorR * translation * lookAt * rotation_x * scaleMatrix * vec4(position, 1.0);
 
  
  

  
}


