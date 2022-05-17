
struct Cell {
  int id;
  float center_x;
  float center_y;
};

/**
 Hello world
 @param count Number of cells
 @param weight Proportional weight of the border (eg on a scale of 0 to 1, 0
 being no border, 1 being only border)
*/
float Grid(float count, float weight, float x) {
  return step(weight, fract((x + weight / count * .5) * count + .5));
}

float Dot(vec2 uv, float x, float y) {
  return smoothstep(.0009, .0, length(uv - vec2(x, y)) - 0.02);
}

float SelectCell(float id, float count, float x) {
  float res = floor((x - .5) * count) + count - id;
  res = 1. - step(1. / (2. * count), abs(res));
  return res;
}

Cell GridCell(float x, float y) {
  Cell res = Cell(0, 0., 0.);
  return res;
}