/**
 * Class for fiding shortest path for a given location to a target
 * using A* algorithm and Manhattan distance
 *
 **/
class AStarSearch {
  // Open and closed set
  ArrayList<Cell> openSet;
  ArrayList<Cell> closedSet;
  // The road taken
  ArrayList<Cell> path;
  ArrayList<Cell> winningPath;
  // Start, end, and current Cell
  Cell start;
  Cell end;
  Cell current;


  /**
   * Class Constructor
   **/
  AStarSearch() {
    openSet = new ArrayList<Cell>();
    closedSet = new ArrayList<Cell>();
    path = new ArrayList<Cell>();
    winningPath = new ArrayList<Cell>();
    start = null;
    end = null;
    current = null;
  }

  /**
   * Find Path Method: used to get start and end locations
   * in order to find optitmal path using Manhattan distance
   *
   * @PARAM: a is a Cell: the start location
   * @PARAM: b is a Cell: the end or target location
   * ---------------------------------------------------------
   * ALTERNATE can use Mover a and Mover b as PARAMS
   **/
  void findPath(Mover a, Mover b) { // Alternate Params
  //void findPath(Cell a, Cell b) {
    // RESET previous to null
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        cells.get(x + y * cols).previous = null;
        cells.get(x + y * cols).g = 0;
        cells.get(x + y * cols).f = 0;
        cells.get(x + y * cols).heuristic = 0;
      }
    }
    // CLEAR array lists
    path.clear();
    openSet.clear();
    closedSet.clear();

    // ASSIGN start location to Mover a location
    // ASSIGN end location to Mover b location
    //start = cells[a.getI()][a.getJ()]; // For alternate params
    //end = cells[b.getI()][b.getJ()]; // For alternate params
    //start = a;
    //end = b;
    start = cells.get(a.x + a.y * cols);
    end = cells.get(b.x + b.y * cols);
    // ADD start to openSet list
    openSet.add(start);
   
    // LOOP through until openSet is empty
    while (!openSet.isEmpty()) {
 
      // FIND best next option
      int winner = 0;
      for (int i = 0; i < openSet.size(); i++) {
        //fill(213, 114, 118);
        //ellipse(openSet.get(i).xPos + (cellSize/2),
        //        openSet.get(i).yPos + (cellSize/2), 20, 20);
        if (openSet.get(i).f < openSet.get(winner).f) {
          winner = i;
        }
      }
      current = openSet.get(winner);
     

      // Finish when current cell is equal to end cell
      if (current == end) {
        // FIND optimal path by working backwards
        Cell temp = current;
        path.add(temp);
        while (temp.previous != null) {
          path.add(temp.previous);
          temp = temp.previous;
        }
        break;
      }

      // Best option MOVES from openSet to closedSet
      openSet.remove(current);
      closedSet.add(current);

      // CHECK all the neighbors
      ArrayList<Cell> neighbors = current.neighbors;
      for (int i = 0; i < neighbors.size(); i++) {
        Cell neighbor = neighbors.get(i);

        // Insure next cell is a valid cell to move into
        if (!closedSet.contains(neighbor) && neighbor.type != 1) {
          float tempG = current.g + heuristic(neighbor, current);

          // COMPARE to see if this is a better path the prior path
          boolean newPath = false;
          if (openSet.contains(neighbor)) {
            if (tempG < neighbor.g) {
              neighbor.g = tempG;
              newPath = true;
            }
          } else {
            neighbor.g = tempG;
            newPath = true;
            openSet.add(neighbor);
          }
         
          // IF new path is better update
          if (newPath) {
            neighbor.heuristic = heuristic(neighbor, end);
            neighbor.f = neighbor.g + neighbor.heuristic;
            neighbor.previous = current;
          }
        }
      }
    }
   
  }

  /**
   * Method for displaying the optimal path
   **/
  void displayPath(color c) {
    noFill();
    stroke(trgtclr);
    strokeWeight(5);
    strokeCap(SQUARE);
    beginShape();
    for (int i = 0; i < path.size(); i++) {
      vertex(path.get(i).x * cellSize + cellSize / 2, path.get(i).y * cellSize + cellSize / 2);
    }
    endShape();
    
    for (int i = 0; i < path.size() - 1; i++) {
      stroke(red(c), green(c), blue(c), map(i, 0, path.size(), 100, 255));
      beginShape();
      vertex(path.get(i).x * cellSize + cellSize / 2, 
             path.get(i).y * cellSize + cellSize / 2);
      vertex(path.get(i + 1).x * cellSize + cellSize / 2, 
             path.get(i + 1).y * cellSize + cellSize / 2);
      endShape();
    }
    
    strokeWeight(1);
  }

  /**
   * An educated guess of how far two cells are
   **/
  float heuristic(Cell a, Cell b) {
    float d = dist(a.x, a.y, b.x, b.y);
    return d;
  }
}
