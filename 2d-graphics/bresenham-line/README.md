<h1 align="center">Exploring Bresenham's Line Drawing Algorithm</h1>

## About
Bresenham's line drawin algorithm is an efficient mehtod for drawing straight lines within 2D graphics as it avoid floating point math and instead works with integers.

## Goal
To better understand how the algorithm works and how I can modify it to use within my own creative coding projects. 

## Usage Notes
* Processing 3.5.4
* Use the various line drawing functions to explore different line techniques
* Modify line drawing functions to fit other projects

## Different Implementations
The most basic way to a line on a canvas would be to use the following functions. A line is generated and displayed with one function offering the option to conrol the stroke width. 
<p><a href="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/basic_line.pde">Basic Line</a></p>
<p><a href="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/basic_line_stroke.pde">Basic Line with Stroke</a></p>

The following function returns an array that can present more freedom to play with individual pixel points that make up the line. An example for creating a smooth color transition from one color to another is show below demonstrating this flexibility in control.
<p><a href="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/basic_line_array_stroke.pde">Basic Line Array</a></p>
<details>
  <summary>Relevant code snip</summary>
  
  ```java
  // loop through array list to access points that make up the line
  for(int i = 0; i < linePoints.size(); i++) {
    float rmap = map(i, 0, linePoints.size(), 0, 255);    
    stroke(rmap, 50, 50);
    point(linePoints.get(i).x, linePoints.get(i).y);
  }
 ```
</details>
<img alt="line example" width="900" align="center" src="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/data/line_array_ex.png"/>

  
Another option for extending the flexibility of the line drawing function is to loop through all the points of the line in an orderlyu fashion using nested loops. This mirrors the order in which points are added to the array. This allows for animating the way in which the line is drawn to the canvas. An example is shown below. 
  
<p><a href="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/basic_line_anim.pde">Basic Line Animation</a></p>
  
<details>
  <summary>Relevant code snip</summary>
  
  ```java
  int strkAmt = 10;
  
  // assign function return to array list
  ArrayList<PVector> linePoints = bresenhamLine(p1x, p1y, p2x, p2y, strkAmt);
  
  // loop through array list in steps to reveal line
  for(int i = 0; i < step; i+=strkAmt) {
    for(int j = 0; j < strkAmt; j++) {
      float rmap = map(i + j, 0, linePoints.size(), 0, 255);
      stroke(rmap, 50, 50);
      point(linePoints.get(i + j).x, linePoints.get(i + j).y);
    }
  }
  if(step < linePoints.size()) {
    step += strkAmt;
  }
 ```
</details>
<img alt="line anim example" width="900" align="center" src="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/data/line_anim.gif"/>
  
Finally, another way to get even more flexibility is through the creation of a class in which even more unique lines can be created. An output example can be found below that was used in one of my Veiled Projects. 

<p><a href="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/basic_line_anim_class.pde">Line Class</a></p>

<p align="center">
  <img alt="veiled line anim" width="600" align="center" src="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/data/veiled_anim.gif"/>
  <img alt="veiled line out" width="600" align="center" src="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/data/lineanim_0743.png"/>
</p>
  


  



