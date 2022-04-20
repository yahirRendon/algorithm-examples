/**
 * Basics for drawing a line between two points using
 * Bresenham's algorithm with stroke of 1 pixel. 
 *
 * @param {int} _x1   the x value for point 1
 * @param {int} _y1   the y value for point 1
 * @param {int} _x2   the x value for point 2
 * @param {int} _y2   the y value for point 2
 */
void bresenhamLine(int _x1, int _y1, int _x2, int _y2) {
  int x1 = _x1;
  int y1 = _y1;
  int x2 = _x2;
  int y2 = _y2;

  // delta of exact value and rounded value of the dependent variable
  int d = 0;

  // changes in x and y between points 1 and 2
  int dx = abs(x2 - x1);
  int dy = abs(y2 - y1);

  // scale to avoid float values
  int dx2 = 2 * dx; 
  int dy2 = 2 * dy; 

  // set increment value for x and y direction 
  int ix = x1 < x2 ? 1 : -1; 
  int iy = y1 < y2 ? 1 : -1;

  // set x and y to point 1
  int x = x1;
  int y = y1;

  if (dx >= dy) {
    while (true) {
      // draw point if not at x2
      point(x, y);                
      if (x == x2)            
        break;

      // update x and y
      x += ix;
      d += dy2;
      if (d > dx) {
        y += iy;
        d -= dx2;
      }
    }
  } else {
    while (true) {
      point(x, y);
      if (y == y2)
        break;
      y += iy;
      d += dx2;
      if (d > dy) {
        x += ix;
        d -= dy2;
      }
    }
  }
}