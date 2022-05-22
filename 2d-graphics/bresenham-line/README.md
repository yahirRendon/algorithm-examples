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

The following function returns an array that can present more freedom to play with individual pixel points that make up the line. A great way to orderly loop through the line is by using nested loops. An example for creating a smooth color transition from one color to another is show below demonstrating this flexibility in control.

