// Shared variable passed to the fragment shader
varying vec3 color;
uniform vec3 lightPosition;
uniform vec3 LeftOrRight;
#define MAX_EYE_DEPTH 0.15

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  // position is in local space, assuming radius 1
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);
  
  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position

  
  mat4 translation_eye = mat4(
                          1.0, 0.0, 0.0, 0.0,
                          0.0, 1.0, 0.0, 0.0,
                          0.0, 0.0, 1.0, 0.0,
                          LeftOrRight.x,LeftOrRight.y,LeftOrRight.z,1.0);


  mat4 translation = mat4(1.0, 0.0, 0.0, 0.0,
                          0.0, 1.0, 0.0, 0.0,
                          0.0, 0.0, 1.0, 0.0,
                          0.02,4.85,-1.25,1.0);
  
  // move eyes to appropriate position              
  mat4 scale = mat4(0.12, 0.0, 0.0, 0.0,
                   0.0, 0.12, 0.0, 0.0,
                   0.0, 0.0, 0.12, 0.0,
                   0.0,  0.0, 0.0, 1.0);

  mat4 rotation_x = mat4(1.0, 0.0, 0.0, 0.0,
                       0.0, 0.0, -1.0, 0.0,
                       0.0, 1.0, 0.0, 0.0,
                       0.0, 0.0, 0.0,1.0);

  
  mat4 rotation_z = mat4(0.0, 1.0, 0.0, 0.0,
                       -1.0, 0.0, 0.0, 0.0,
                       0.0, 0.0, 1.0, 0.0,
                       0.0, 0.0, 0.0,1.0);
  
  vec4 a = modelMatrix * translation * rotation_z * rotation_x * scale  * vec4(position, 1.0);
  vec3 eye = vec3(a.x, a.y, a.z);
  //lookAt
  vec3 up = vec3(0,1,0);
  vec3 zaxis = normalize(eye-lightPosition);   //the forward vector
  vec3 xaxis = normalize(cross(up, zaxis));         //the right vector
  vec3 yaxis = cross(zaxis, xaxis);              //the up vector

  mat4 orientation = mat4(
    vec4(xaxis.x, xaxis.y, xaxis.z, 0.0),
    vec4(yaxis.x, yaxis.y, yaxis.z, 0.0),
    vec4(zaxis.x, zaxis.y, zaxis.z, 0.0),
    vec4(0.0,       0.0,       0.0,       1.0)
  );

   mat4 translation_LookAt = mat4(
    vec4(1.0, 0.0, 0.0, -eye.x),
    vec4(0.0, 1.0, 0.0, -eye.y),
    vec4(0.0, 0.0, 1.0, -eye.z),
    vec4(0.0, 0.0, 0.0, 1.0)
  );

   mat4 lookat_m = orientation * translation_LookAt;
  
   
 gl_Position = projectionMatrix * modelViewMatrix * translation_eye * translation *lookat_m* rotation_z * rotation_x * scale * vec4(position, 1.0);
 
  
  

  
}


