precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#include "./grid.glsl"

float Bars(float x) { return 1. - step(.5, abs(x)); }

void main() {
  float dim = min(u_resolution.y, u_resolution.x);
  vec2 st = (gl_FragCoord.xy - u_resolution.xy / 2.) / dim;
  vec2 mt = (u_mouse.xy - u_resolution.xy / 2.) / dim;
  vec2 mt_n = floor((mt + .5) * 9.);  // get id of the cell.
  vec2 mt_3n = floor((mt + .5) * 3.); // get id of the cell.

  vec3 color = vec3(1.0);

  color *= Grid(9., .05, st.x) * Grid(9., 0.05, st.y);
  color *= Grid(3., 0.05, st.x) * Grid(3., 0.05, st.y);

  // Hood
  float row_cell = SelectCell(mt_3n.y, 3., st.y);
  float col_cell = SelectCell(mt_3n.x, 3., st.x);
  float cell_m = row_cell * col_cell;
  vec3 c_color = mix(color, vec3(0.9686, 0.9569, 0.3608), cell_m * length(color));

  // Column
  cell_m = col_cell;
  cell_m *= SelectCell(mt_n.x, 9., st.x);
  c_color = mix(c_color, vec3(0.4471, 0.9059, 0.9059), cell_m * length(color));

  // Row
  cell_m = row_cell;
  cell_m *= SelectCell(mt_n.y, 9., st.y);
  c_color = mix(c_color, vec3(0.4471, 0.9059, 0.9059), cell_m * length(color));

  // Cell
  row_cell = SelectCell(mt_n.y, 9., st.y);
  col_cell = SelectCell(mt_n.x, 9., st.x);
  cell_m = row_cell * col_cell;
  c_color = mix(c_color, vec3(0.8, 0.2863, 0.9255), cell_m * length(color));

  color *= c_color;
  color *= Bars(st.x) * Bars(st.y);
  color = mix(vec3(1., 0., 0.), color, 1. - Dot(st, mt.x, mt.y));

  gl_FragColor = vec4(color, 1.0);
}