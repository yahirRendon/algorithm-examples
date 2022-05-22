/**************************************************************
 Project:  Playground for exploring Bresenham's line algorithm
 Date:     May 20, 2022
 
 Notes:
           This uses a class for creating lines and drawing
           them overtime.
           
 - Processing 3.5.4
 **************************************************************/
 
int p1x;      // point 1 x
int p1y;      // point 1 y
int p2x;      // point 2 x
int p2y;      // point 2 y
BresenhamLine bline;  // class for line

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
  
  bline = new BresenhamLine(p1x, p1y, p2x, p2y, 3);
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(255);
  
  color lcolor = color(100, 50, 50);
  bline.display(lcolor);
  
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
    bline.resetLine(p1x, p1y, p2x, p2y, 3);
  }
}

/**************************************************************
 Class for drawing a line using Bresenham's line drawing algo.
 The line is revealed overtime based on frame rate as opposed to 
 plotting all points at once. 
 **************************************************************/
class BresenhamLine {
  ArrayList<PVector> points; // holds aa points in line
  int x1;                    // start x position
  int y1;                    // start y position
  int x2;                    // target x position
  int y2;                    // target y position  
  int strokeAmt;             // thickness of line stroke in pixels
  int d;                     // determinative for drawing line
  int strokeDir;             // determine direction of stroke growth (x or y axis)
  boolean done;              // toggle when target position reached
  
  /**
   * Constructor
   *
   * @param {int} _x1            the x value for point 1
   * @param {int} _y1            the y value for point 1
   * @param {int} _x2            the x value for point 2
   * @param {int} _y2            the y value for point 2
   * @param {int} _stroke        the stroke/width  amount of line
   */
  BresenhamLine(int _x1, int _y1, int _x2, int _y2, int _stroke) {   
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2; 
    strokeAmt = _stroke;
        
    setInitialValues();     
  }
  
  /**
   * set initial conditions for drawing a line
   */
  void setInitialValues() {
    points = new ArrayList<PVector>();
    d = 0;
    done = false;

    int dx = abs(x2 - x1);
    int dy = abs(y2 - y1);

    if (strokeAmt > 1) {
      if (dx >= dy) {
        //adding to y       
        y1 = y1 - int(strokeAmt/2);
        y2 = y2 - int(strokeAmt/2);
        strokeDir = 0;
      } else {

        x1 = x1 - int(strokeAmt/2);
        x2 = x2 - int(strokeAmt/2);
        strokeDir = 1;
      }
    }
  }

  /**
   * Update new start and end points for line
   *
   * @param {int} _x1            the x value for point 1
   * @param {int} _y1            the y value for point 1
   * @param {int} _x2            the x value for point 2
   * @param {int} _y2            the y value for point 2
   * @param {int} _stroke        the stroke/width  amount of line
   */
  void resetLine(int _x1, int _y1, int _x2, int _y2, int _stroke) {
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2; 
    strokeAmt = _stroke;  
    setInitialValues();     
  }


  /**
   * Update the end point of the line
   * usefule for creating non linear lines
   *
   * @param {int} _x2    end x value
   * @param {int} _y2    end y value
   */
  void updateEnd(int _x2, int _y2) {
    x2 = _x2;
    y2 = _y2;
  }

  /**
   * calculates the next x1 and y1 values
   * along the line path
   */
  void update() {
    
    // update 
    int dx = abs(x2 - x1);
    int dy = abs(y2 - y1);
    int dx2 = 2 * dx;
    int dy2 = 2 * dy;
    int ix = x1 < x2 ? 1 : -1;
    int iy = y1 < y2 ? 1 : -1;

    if (dx >= dy) {    
      if (x1 != x2) {
        if (y1 == y2)
          strokeDir = 0;
        x1 += ix;
        d += dy2;
        if (d > dx) {
          y1 += iy;
          d -= dx2;
        }
      }
    } else {
      strokeDir = 1;
      if (y1 != y2) {
        y1 += iy;
        d += dx2;
        if (d > dy) {
          x1 += ix;
          d -= dy2;
        }
      }
    }
  }
  
  /**
   * visually display the line being created
   */
  void updateArray() {
    
    // loop to draw stroke 
    for (int i = 0; i < strokeAmt; i++) {
      int x;
      int y;
      if(strokeDir == 0) {
        x = x1;
        y = y1 + i;
      } else {
        x = x1 + i;
        y = y1;
      }
      
      points.add(new PVector(x, y));
 
    }
    
    // trigger once target position is met
    // else update modulators and position
    if (x1 == x2 && y1 == y2) {
      done = true;
    } else {
      
    // get new x1 and y1 positions
    update();
    }
  }
  
  /**
   * visually display the line being created
   */
  void display(color _c) {
    updateArray();
    stroke(_c);
    for(int i = 0; i < points.size(); i++) {     
      point(points.get(i).x, points.get(i).y);
    }   
  }
}
