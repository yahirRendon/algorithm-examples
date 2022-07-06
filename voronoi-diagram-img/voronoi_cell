/**
  *
  * Class for displaying the Voronoi cells
  *
  */
class Cell {
  int cellX;                      // x origin position
  int cellY;                      // y origin position
  int radius;                     // radius that increments to display cell expansion
  int nodeIndex;                  // index position within node list. used to prevent cell checking distance
  
  ArrayList<PVector> points;      // list of pixels that make up the area of the cell
                                  // to its own origin
                                  
  boolean growing;                // track whether the cell is still growing or cell area has been maxed out by neighbor cells
  boolean solidColor;             // tracks whether display is using solid colors or img sampling
  color cellColor;                // the color of the cell area
  
  int currentArea;                // track the current area of cell (pixel size)
  int priorArea;                  // track the prior size of area cell. used to check if cell is not longer expanding
  
  int colCounter;                 // track number of pixels being added to cell area. used for calcuating average colors
  
  /**
    * Constructor
    *
    * @param _x:          the origin x position
    * @param _y:          the origin y position
    * @param _nodeIndex:  the index position of x and y values within the node list
    */
  Cell(int _x, int _y, int _nodeIndex) {
    cellX = _x;
    cellY = _y;
    radius = 0;
    nodeIndex = _nodeIndex;
    currentArea = 0;
    priorArea = -1;
    growing = true;
    points = new ArrayList<PVector>();
    
    // set color based on image
    int index = cellX + cellY * width;
    cellColor = color(red(img.pixels[index]), green(img.pixels[index]), blue(img.pixels[index]));
  }


  
  /**
    * Method for running math and other calculations that
    * generate the visuals elements of Voronoi pattern
    *
    * @param: _nodes    an arraylist of nodes used to generate cell origins
    */
  void update(ArrayList<PVector> _nodes) {

  // only update when growing is true
  if (growing) {
 
    // nested for loop to create growing square aroudn radius
    for (int y = cellY - radius; y < cellY + radius; y++) { 
      for (int x = cellX - radius; x < cellX + radius; x++) { 
        
        // calculate distance from cell origin to x and y from for loops
        float distForEdge = dist(cellX, cellY, x, y);   
        // used to compare distance to all node
        // initialze to largest possible distance for one corner to another
        float distMin = dist(0, 0, width +1, height + 1);
        
        // limit checks to circle perimeter
        if (distForEdge >= radius - 1 && distForEdge <= radius) {
          
          // loop through nodes list
          for (int i = 0; i < _nodes.size(); i++) {
            // exclude adding this cells origin from the node list
            if (int(_nodes.get(i).z) != nodeIndex) {
              // cacluate the distance from this oute perimeter x,y value to origin of all nodes
              float distToNode = dist(x, y, _nodes.get(i).x, _nodes.get(i).y);
              // if the distance to a node is less than a prior distance update
              // distMin to the new lowest minimum distance
              // this ensures only pixels will be added that are closest to its own origin than any other cell origin
              if (distToNode < distMin) {
                distMin = distToNode; 
              }
            }
          }
          // now that we have the lowest distance to all other nodes or cell origins check if the
          // x,y perimter pixel is closer to its own origin than any other node
          if (distForEdge <= distMin) {
            // do a boundary check
            if (x > -1 && x < width && y > -1 && y < height) {
              // add pixel points that have passed all filter to points array which stores all
              // pixels within the bounds of the cell
              points.add(new PVector(x, y));
              // update the currentArea variable to the size of the points array
              currentArea = points.size();
            }
          }
        }
      } 
    } 
  }
  
  // check if the currentArea size is greater than the prior cell size
  // if so update the priorArea to the current area size
  // once the currentArea is no longer bigger it means the cell size has maxed out
  // we should stop growing the perimeter to avoid over calculating
  if (currentArea > priorArea) {
    priorArea = currentArea;
    // if area is still growing keep increasing the radius
    radius++;
    // for all the cells on the outer edges that will never max out
    // stop growing them when the radius is bigger that any possible size
    // that would cover the window size. this could in theory be a smaller check
    if (radius > dist(0, 0, width + 1, height + 1)) {
      growing = false;
    }
  } else {
    // if the area stopped growing stop growing
    growing = false;
  }
}

  
  /**
    * Method for managine visual display elements
    *
    */
  void display() {
    
    // if the cell is still growing
    if(growing) {
      // set color
      stroke(cellColor);
      
      // loop through all points in the array
      // these are the points that passed update method filtering
      for (PVector p : points) {
        // calculate index for a boundary check
        int index = int(p.x) + int(p.y) * width;
        if(index > -1 && index < width * height) {
          // update the appropriate pixel in the backgroudn canvase with
          // desired color
          canvas.pixels[index] = color(cellColor);
          canvas.updatePixels();
        }
      }
      
    } 
  }
  
  /**
    * Method for setting the color value
    *
    * @param: _C     the desired color
    */
  void setColor(color _c) {
    cellColor = _c;
  }
}
