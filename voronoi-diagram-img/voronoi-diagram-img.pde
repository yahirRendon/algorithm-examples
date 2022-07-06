/**************************************************************
 Project:  Implementation of the Voronoi pattern/algorthim while
           using an image to sample colors. Not the most efficient 
           implementation but got me thinking about what is going 
           on. Will have to revist after exploring its relationship 
           with Delaunay triagulation
 
 Author:  Yahir 
 Date:    February 2021
 
 
 Notes:
 - Processing 3.5.4
 
 Instructions:
 1. SPACE | to begin creating vornoi pattern
 2. R KEY | clear the canvas
 
 
 **************************************************************/

PImage canvas;                // background canvas
PImage img;                   // imaged being sampled

ArrayList<PVector> nodes;     // list origin of voronoi cells
ArrayList<Cell> cells;        // list of Cell objects that will display pattern
boolean startVor;             // start to display voronoi pattern
int numCells;                 // the number of cells. matches number of nodes

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  // window size. ensure canvas image is the same pixel size
  size(900, 900);
  
  // initialize globarl variables
  startVor = false;
  numCells = 200;
  
  // load background canvas
  canvas = loadImage("blank.png");
  canvas.loadPixels();
  
  // load sample image 
  img = loadImage("kaja-reichardt-S3__pWlOEs8-unsplash.jpg");
  img.loadPixels();
  
  // initialize nodes and cells
  nodes = new ArrayList<PVector>();
  cells = new ArrayList<Cell>();;
  
  // run method for assigning nodes and cells 
  initializeVoronoi();
}

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void draw() {
  background(255);
  
  // show image
  image(img, 0, 0);
  
  // display background canvas
  // initially all pixels are transparent and are updated
  image(canvas, 0, 0);
  
  // begin visual display
  if(startVor) {
    
    // loop through cells list for updating and displaying
    for(Cell c : cells) {
      c.update(nodes);
      c.display();
    }
  }
}

/**
  * Method for controlling key input
  *
  * SPACE : start the visual display
  * R KEY : reset the nodes and display
  */
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
    cells.add(new Cell(int(nodes.get(i).x), int(nodes.get(i).y), i));
  } 
}
