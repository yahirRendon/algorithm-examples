/**
 * Class for creating mover objects that can move along 
 * cells in the grid.
 **/
class Mover {
  int x, y;            // the x index position of mover
  int xPos, yPos;      // the y index position of mver
  int w;               // the width/size of the mover
  int index;           // the index position within grid
  int type;            // the type of mover for assiging color

  /**
  * constructor for mover
  * @PARAM: _x     x index position
  * @PARAM: _y     y index position
  * @PARAM: _t     type of mover
  */
  Mover(int _x, int _y, int _t) {
    x = _x;
    y = _y;
    w = cellSize/2;
    type = _t;
    update();
  }
  
  /**
  * Update the pixel location and index value
  */
  void update() {
    index = x + y * cols;
    xPos = x * cellSize + w;
    yPos = y * cellSize + w;
  }
  
  /**
  * display the mover
  */
  void display() {
    update();
    fill(strtclr);
    noStroke();
    if (type == 1) {
      fill(trgtclr);
    }   
    ellipse(xPos, yPos, w, w);
  }
  
  /**
  *  check if mover can move down within the grid
  *
  * @RETURN: true if can move and false if unable to move
  */
  boolean canMoveDown() {
    int newY = y + 1;
    if (newY >= 0 && newY < rows) {
      if (cells.get(x + newY * cols).type != 1) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
  
  /**
  *  check if mover can move up within the grid
  *
  * @RETURN: true if can move and false if unable to move
  */
  boolean canMoveUp() {
    int newY = y - 1;
    if (newY >= 0 && newY < rows) {
      if (cells.get(x + newY * cols).type != 1) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
  
  /**
  *  check if mover can move left within the grid
  *
  * @RETURN: true if can move and false if unable to move
  */
  boolean canMoveLeft() {
    int newX = x - 1;
    if (newX >=0 && newX < cols) {
      if (cells.get((newX + y * cols)).type != 1) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
  
  /**
  *  check if mover can move right within the grid
  *
  * @RETURN: true if can move and false if unable to move
  */
  boolean canMoveRight() {
    int newX = x + 1;
    if (newX >= 0 && newX < cols) {
      if (cells.get(newX + y * cols).type != 1) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
  
  /**
  * set mover y index down
  */
  void moveDown() {
    if (canMoveDown()) {
      y++;
    }
  }
  
  /**
  * set mover y index up
  */
  void moveUp() {
    if (canMoveUp()) {
      y--;
    }
  }
  
  /**
  * set mover y index left
  */
  void moveLeft() {
    if (canMoveLeft()) {
      x--;
    }
  }
  
  /**
  * set mover y index right
  */
  void moveRight() {
    if (canMoveRight()) {
      x++;
    }
  }
}
