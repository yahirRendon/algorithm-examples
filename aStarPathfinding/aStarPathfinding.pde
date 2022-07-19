/**************************************************************
 Project: An example of the A Star Pathfinding algorithm. I
          explored this when working on recreating a Pacman game.
 
 Author:  Yahir 
 Date:    January 2022
 
 
 Notes:
 - Processing 3.5.4
 
 Instructions:
 1. ARROW KEYS to move node
 2. SPACE KEY to reset start mover

 **************************************************************/

// rough way of creating cells and walls
ArrayList<Cell> cells;
int[] walls = {10, 11, 12, 14, 15, 16, 19, 25, 28,  
               30, 31, 32, 34, 45, 46, 48, 49, 50, 
               52, 53, 58, 64, 65, 67, 69, 70};
int cols;           // number of columns in the grid
int rows;           // number of rows in teh grid
int numCells;       // total number of cells
int cellSize;       // pixel size of a cell

Mover mStart;       // mover object that is the start of path
Mover mTarget;      // mover object that is the target of path

AStarSearch path;     // class for getting path from start to target mover

// color palette
color bckgrnd = color(192, 204, 204);
color fregrnd = color(214, 194, 188);
color strtclr = color(101, 178, 198);
color trgtclr = color(215, 61, 108);

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  size(360, 360);
  cols = 9;
  rows = 9;
  numCells = rows * cols;
  cellSize = 40;
  
  // loop through desired number or rows
  // and columns and create cells including walls.
  cells = new ArrayList<Cell>();
  int wallsIndex = 0;
  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {
      int index = x + y * cols;
      if(index == walls[wallsIndex]) {
        cells.add(new Cell(x, y, 1));
        if(wallsIndex < walls.length - 1) {
          wallsIndex++;
        }
      } else {
        cells.add(new Cell(x, y, 0));
      }
    }
  }
  
  // update neighbors for cells to assist in path finding
  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {
      cells.get(x + y * cols).addNeighbors(cells, rows, cols);
    }
  }
  
  // create objects
  int[] startPos = getEmptyCell();
  mStart = new Mover(startPos[0], startPos[1], 0);
  mTarget = new Mover(0, 0, 1);  
  path = new AStarSearch(); 
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(bckgrnd);
  
  // display the cells
  for(int i = 0; i < cells.size(); i++) {
    cells.get(i).display();
  }
  
  // find and display path
  path.findPath(mStart, mTarget);
  path.displayPath(strtclr);
  
  // display mover
  mStart.display();
  mTarget.display(); 
  
}

/**************************************************************
 KEY PRESSED
 
 KEY LEFT  | move node left
 KEY RIGHT | move node right
 KEY UP    | move node up
 KEY DOWN  | move node down
 KEY SPACE | reset target mover
 **************************************************************/
void keyPressed() {
  if(key == CODED) {
    if(keyCode == LEFT) {
      mTarget.moveLeft();
    }
    if(keyCode == RIGHT) {
      mTarget.moveRight();
    }
    if(keyCode == UP) {
      mTarget.moveUp();
    }
    if(keyCode == DOWN) {
      mTarget.moveDown();
    }
  }
  
  if(key == ' ') {
    int[] startPos = getEmptyCell();
    mStart.x = startPos[0];
    mStart.y = startPos[1];
  }
}

/*
* basic function for getting a cell that is not a wall
*
* @RETURN int array corresponding to x and y cell values
*/
int[] getEmptyCell() {
  int x = int(random(0, cols - 1));
  int y = int(random(0, rows - 1));
  int index = x + y * cols;
  while(cells.get(index).type == 1) {
    x = int(random(0, cols - 1));
    y = int(random(0, rows - 1));
    index = x + y * cols;
  }
  return new int[] {x, y};
}
