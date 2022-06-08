precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

const float PI = acos(-1.);
const float TWO_PI = PI * 2.;

float circle(in vec2 _st, in float _radius) {
    return  1. - step(_radius, length(_st));
}

float gear(in vec2 _st, in vec2 _pos,  in float _inner_radius, in float _spin) {
  vec2 pos = _pos - _st;
  float r = length(pos) * 2.;
  float a = atan(pos.y , pos.x) + _spin;
  float f;
  f = smoothstep(-.5,1., (cos(a * 21.))) * (1. - _inner_radius) + _inner_radius;
  return 1. - step(f, r);
}
mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}


/*
https://www.shadertoy.com/view/MlcXDB
*/
float polygon(vec2 st, float numVertices) {
  float a = atan(st.x, st.y) + PI;
  float r = TWO_PI / numVertices;

  return cos(floor(.5+a/r)*r-a)*length(st);
}

void main() {
  float dim = min(u_resolution.y, u_resolution.x);
  vec2 st = (gl_FragCoord.xy - u_resolution.xy / 2.) / dim;

//   vec2 st = gl_FragCoord.xy / dim;
//   st = rotate2d(PI * .35) * st;
  st = st * 5.;

  float row;
  row = floor(st.y);
  st.x -= .5 * mod(row, 2.);
  float col = st.x - fract(st.x);

  st = fract(st);

  vec3 color = vec3(0.);

  st-= .5 ; //translate it
  float dir = mod(row + col, 2.) * 2. - 1. ;
  float spin = u_time / 3.;
  st = rotate2d(dir * spin) * st; // rotate it
  color = vec3(gear(st, vec2(.0), .89, 0.));
//   vec3 p = vec3(step(.3, polygon(st , clamp(3.*abs(spin),1., 5.))));
  vec3 p = vec3(step(.3, polygon(st, 5.)));
  color= min(color, p);

  vec3 bg= vec3(mod(row + col, 2.));
  color = mix(bg, color, p) ;
  color = min(color, 1. - circle(st, .1));
//   color = vec3(id / 25.);
//   color = vec3(dir * .5 + .5);

  gl_FragColor = vec4(color, 1.0);
}