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
<details>
  <summary>Looping code snip</summary>
  
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

<img alt="line anim example" width="900" align="center" src="https://github.com/yahirRendon/algorithm-examples/blob/main/2d-graphics/bresenham-line/data/line_anim.gif"/>
  



