/**************************************************************
 Project:  Playground for exploring Bresenham's line algorithm
 Date:     May 20, 2022
 
 Notes:
           This uses a function to draw a line with desired stroke
           width/amount
 - Processing 3.5.4
 **************************************************************/
 
int p1x;      // point 1 x
int p1y;      // point 1 y
int p2x;      // point 2 x
int p2y;      // point 2 y

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  size(900, 900);
  
  // set random start and end point values of line
  p1x = int(random(100, width - 100));
  p1y = int(random(100, width - 100));
  p2x = int(random(100, height - 100));
  p2y = int(random(100, height - 100));
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(255);
  bresenhamLine(p1x, p1y, p2x, p2y, 5);
}

/**************************************************************
 KEY PRESSED FUNCTION
 
 - SPACE | set new points
 **************************************************************/
void keyPressed() {
  if(key == ' ') {
    p1x = int(random(100, width - 100));
    p1y = int(random(100, width - 100));
    p2x = int(random(100, height - 100));
    p2y = int(random(100, height - 100));
  }
}

/**
 * Basics for drawing a line between two points using
 * Bresenham's algorithm with custome stroke width/amount 
 *
 * @param {int} _x1   the x value for point 1
 * @param {int} _y1   the y value for point 1
 * @param {int} _x2   the x value for point 2
 * @param {int} _y2   the y value for point 2
 * @param {int} _stroke        the stroke/width  amount of line
 */
void bresenhamLine(int _x1, int _y1, int _x2, int _y2, int _stroke) {
  int x1 = _x1;
  int y1 = _y1;
  int x2 = _x2;
  int y2 = _y2;
  int strokeAmt = _stroke;

  // dif of exact value and rounded value 
  int d = 0;

  // changes in x and y between points 1 and 2
  int dx = abs(x2 - x1);
  int dy = abs(y2 - y1);
  
  // adjust start and end points for stroke
  if(strokeAmt > 1) {
    if(dx >= dy) {
      y1 = y1 - int(strokeAmt/2);
      y2 = y2 - int(strokeAmt/2);
    }
  } else {
    x1 = x1 - int(strokeAmt/2);
    x2 = x2 - int(strokeAmt/2);
  }

  // scale to avoid float values
  int dx2 = 2 * dx; 
  int dy2 = 2 * dy; 

  // set increment value for x and y direction 
  // 1 is solid line. as you increase you cna create dotted
  // or dashed lines
  int incx = 1;
  int incy = 1;
  int ix = x1 < x2 ? incx : -incx; 
  int iy = y1 < y2 ? incy : -incy;

  // set x and y to point 1
  int x = x1;
  int y = y1;
  
  // set direction
  if (dx >= dy) {
    while (true) {
      // draw point and only break
      // if x1 is at end x2 with stroke
      for(int i = 0; i < strokeAmt; i++) {
        point(x, y + i);
      }                
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
      for(int i = 0; i < strokeAmt; i++) {
        point(x + i, y);
      }
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
