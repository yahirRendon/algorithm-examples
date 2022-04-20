<h1 align="center">Exploring Bresenham's Line Drawing Algorithm</h1>

## About
Bresenham's line drawin algorithm is an efficient mehtod for drawing straight lines within 2D graphics as it avoid floating point math and instead works with integers.

## Goal
To better understand how the algorithm works and how I can modify it to use within my own creative coding projects. 

## Usage Notes
* Processing 3.5.4
* Copy core code block below to a processing sketch
* Use the various line drawing functions to explore different line techniques
* Modify line drawing functions to fit other projects

## Core Code Block

```java
/**************************************************************
 Project:  Playground for exploring Bresenham's line algorithm
 Date:     April 20, 2022
 
 Notes:
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
  
  // set random point values
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
  bresenhamLine(p1x, p1y, p2x, p2y);
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
```

