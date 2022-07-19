/**
 * Class for creating cells that will make up a grid
 * movers can traverse and pathfinding can be done.
 **/
 
class Cell {
  int x, y;                  // cell x and y (index)
  int xPos, yPos;            // cell x and y (pixel)
  int type;                  // type of cell (empty or wall)

  // g, h and f values for A*
  float g = 0;               // movement cost
  float heuristic = 0;       // educated distance
  float f = 0;               // movement cost + educated distance
  Cell previous = null;      // used to check cells in pathfinding
  ArrayList<Cell> neighbors; // list of neighboring cells. 
  
  /**
  * Constructor for cell
  * 
  * @PARAM _x      the x index position of cell
  * @PARAM _y      the y index position of cell
  * @PARAM _t      type of cell
  */
  Cell(int _x, int _y, int _t) {
    x = _x;
    y = _y;
    xPos = _x * cellSize;
    yPos = _y * cellSize;
    type = _t;
    neighbors = new ArrayList<Cell>();
      
  }
  
  /**
  * display the cell according to type
  */
  void display() {
    
    switch(type) {
      case 1: // wall
      strokeWeight(1);
      stroke(255);  
      fill(fregrnd);
      rect(xPos, yPos, cellSize - 3, cellSize - 3, 5);
      break;
      default: // empty
      noStroke();
      if(g > 0) {
      fill(255, map(g, 0, 9, 50, 255));
      } else {
        fill(bckgrnd);
      }
      rect(xPos, yPos, cellSize - 5, cellSize - 5);
      break;    
    }
  }
  
  /**
  * displayign neighboring cells
  */
  void displayNeighbors() {
    fill(255, 0, 0);
    rect(xPos, yPos, cellSize, cellSize);
   
    for(int i = 0; i < neighbors.size(); i++) {
      fill(0);
      rect(neighbors.get(i).xPos, neighbors.get(i).yPos, cellSize, cellSize);
    }    
  }
  
  /**
  * populate neighbor cells to list
  */
  void addNeighbors(ArrayList<Cell> cells, int numCols, int numRows) {
    if (x < numCols - 1) {
      neighbors.add(cells.get((x + 1) + y * cols));
    }
    if (x > 0) { // this works
      neighbors.add(cells.get((x - 1) + y * cols));
    }
    if (y < numRows - 1) {
      neighbors.add(cells.get(x + (y + 1) * cols));
    }
    if (y > 0) { // this works
      neighbors.add(cells.get(x + (y - 1) * cols));
    }
  }
}
