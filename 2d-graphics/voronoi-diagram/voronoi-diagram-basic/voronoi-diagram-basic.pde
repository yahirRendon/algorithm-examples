/**************************************************************
 Project:  Implementation of the Voronoi pattern/algorthim. Not
           the most efficient implementation but got me thinking
           about what is going on. Will have to revist after 
           exploring its relationship with Delaunay triagulation
 
 Author:  Yahir 
 Date:    February 2021
 
 
 Notes:
 - Processing 3.5.4
 
 Instructions:
 1. SPACE | to begin creating vornoi pattern
 2. R KEY | clear the canvas
 
 
 **************************************************************/

PImage canvas;                  // background canvas
ArrayList<PVector> nodes;       // list origin of voronoi cells
ArrayList<VoronoiCell> cells;   // list of Cell objects that will display pattern
boolean startVor;               // start to display voronoi pattern
int numCells;                   // the number of cells. matches number of nodes

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  // window size. ensure canvas image is the same pixel size
  size(900, 900);
  
  surface.setTitle("Paint Display");
  
  // use HSB color definitions
  colorMode(HSB, 360, 100, 100, 100);
  
  // load background canvas
  canvas = loadImage("blank.png");
  canvas.loadPixels();
  
  // initialize nodes and cells
  nodes = new ArrayList<PVector>();
  cells = new ArrayList<VoronoiCell>();;
  
  // initialize globarl variables
  startVor = false;
  numCells = 300;
  
  // run method for assigning nodes and cells 
  initializeVoronoi();
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(0, 0, 100);
  
  // display background canvas
  // initially all pixels are transparent and are updated
  image(canvas, 0, 0);
  
  // begin visual display
  if(startVor) {
    
    // loop through cells list for updating and displaying
    for(VoronoiCell c : cells) {
      c.update(nodes);
      c.display();
    }
  } else {
   for(PVector node : nodes) {
     ellipse(node.x, node.y, 2, 2);
   }
  }
}


/**************************************************************
 KEY PRESSED
 
 - SPACE : start the visual display
 - R KEY : reset the nodes and display
 **************************************************************/
void keyPressed() {
  
  // START DISPLAY
  if(key == ' ') {
    startVor = true;
  }
  
  // RESET
  if(key == 'r' || key == 'R') {
    
    // Loop through all canvas pixels and reset to transparent
    for(int i = 0; i < canvas.pixels.length; i++) {
      canvas.pixels[i] = color(0, 0, 0, 0);
      canvas.updatePixels();
    }
    
    // generate new node positiosn and cells
    initializeVoronoi();
    
    // stop display activation
    startVor = false;
  }
}

/**
  * Method for setting up the node origin for voronoi cells
  * as well as the Cell objects which will create the visual display
  */
void initializeVoronoi() {
  
  // Clear lists incase of reset
  nodes.clear();
  cells.clear();
  
  // loop for creating nodes
  for (int i = 0; i < numCells; i++) {
    // randmoize node origins
    nodes.add(new PVector(int(random(width)), int(random(height)), i));
    
    // create Cell objects
    // x pos | y pos | node index
    cells.add(new VoronoiCell(int(nodes.get(i).x), int(nodes.get(i).y), i));
    
    // for changin color
    //int h = int(random(60, 140));
    //int s = int(random(20, 100));
    //int b = int(random(50, 100));
    //cells.get(i).setColor(color(h, s, b));
  } 
}
