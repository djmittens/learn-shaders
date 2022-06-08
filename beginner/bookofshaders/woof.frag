precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

const float PI=acos(-1.);


void main() {
  float dim = min(u_resolution.y, u_resolution.x);
  vec2 st = (gl_FragCoord.xy - u_resolution.xy / 2.) / dim;

  vec3 color = vec3(1.0);
//   color *= 1. - fract(sin(10. * st.x * PI -  u_time*3. ));
    color *= pow(abs(st.x), 1.);
  gl_FragColor = vec4(color, 1.0);
}