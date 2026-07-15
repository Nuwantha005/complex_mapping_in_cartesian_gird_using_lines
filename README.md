# Normal Functions Using Lines

This Processing sketch visualizes complex-valued functions by mapping a 2D grid through a custom transformation and animating the transition between the original and transformed shapes. The result is a line-based view of complex analysis that makes it easier to see how functions deform a plane.

Project portfolio: [Project Complex Mapping](https://nuwanthakumara.com/projects/project_complex_mapping)

## Project Structure

```text
normal_functions_using_lines/
├── Complex.pde
├── function.pde
├── normal_functions_using_lines.pde
├── README.md
└── run.sh
```

The sketch is split into small, focused files. `Complex.pde` contains the complex-number helper used by the transformation logic. `function.pde` defines the mapping pipeline and the active complex function. `normal_functions_using_lines.pde` owns setup, rendering, animation state, and mouse interaction.

## Dependency

This project depends on the [PeasyCam](https://mrfeinberg.com/peasycam/) library for camera control in the 3D Processing renderer. No other external libraries are required.

## Overview

The sketch starts by building a rectangular grid of `PVector` points in the complex plane. Each point is converted into a `Complex` value, passed through the selected function `f(z)`, and converted back to screen coordinates. The program stores both the original grid and the mapped grid, then uses a frame-by-frame interpolation so the transition can be animated rather than shown as a hard jump.

The visual result is organized into four display states: the original grid, the mapped grid, the forward animation between them, and the reverse animation back to the grid. Mouse clicks switch between those states while PeasyCam handles zooming and panning.

## Classes and Functions

### `Complex`

`Complex.pde` defines a lightweight complex-number class with `x` and `y` components, constructors for default and explicit values, and a set of operations used by the mapping function. The class supports cartesian and polar workflows through methods such as `setPolar()`, `getR()`, and `getAngle()`, which makes it straightforward to express transformations like reciprocal, power, scalar multiplication, and multiplication by `i`.

The important detail is that this class is the mathematical core of the sketch. When you change the function in `function.pde`, you are composing these methods to define a new transformation in the complex plane.

### `setup()`

Defined in `normal_functions_using_lines.pde`, `setup()` initializes the 600 by 600 P3D canvas, enables HSB color mode, creates the PeasyCam instance, and constructs the input grid. It also precomputes the color ramp and generates both the mapped image and the interpolation frames before the first render.

### `draw()`

Also in `normal_functions_using_lines.pde`, `draw()` is responsible for rendering the current state. It reads the active display mode and draws either the original grid, the transformed image, or one of the animated transitions. The function keeps the rendering logic separated from the transformation logic, which makes the visual states easy to follow and maintain.

### `mouseClicked()`

This function switches the sketch between the grid view and the mapped view by toggling the animation state. A click on the original grid starts the forward animation, while a click on the mapped image starts the reverse animation.

### `getColor(int i)`

`getColor()` reads from the precomputed `FloatList` so each grid column can keep a stable hue. This keeps the line colors consistent across the grid, the mapped image, and the animation frames.

### `mapping(ArrayList<ArrayList<PVector>> points)`

Defined in `function.pde`, `mapping()` converts the grid into complex values, applies the active function `f(z)`, and returns the transformed point cloud. This is the main bridge between the sketch geometry and the complex-number logic.

### `f(Complex z)`

This is the function you edit when you want to visualize a different complex mapping. The file currently includes examples such as squaring, reciprocal, multiplication by `i`, and composite expressions. For example, `z.power(2)` represents $f(z) = z^2$, while `z.reciprocal()` represents $f(z) = 1/z$.

### `generateFrame(ArrayList<ArrayList<PVector>> start, ArrayList<ArrayList<PVector>> end)`

`generateFrame()` builds the intermediate animation states by interpolating between the original grid and the mapped grid. Each point receives a sequence of positions across `no_of_Frames`, which allows the sketch to animate the deformation smoothly instead of redrawing only the endpoints.

## How It Works

The sketch maps the plane in three stages. First, it creates a regular grid of sample points around the center of the canvas. Second, it evaluates the selected complex function for every point and stores the transformed geometry. Third, it interpolates between the two shapes over a fixed number of frames so the user can see the transformation unfold.

Because the logic is organized around the `Complex` class and the `f(z)` function, the sketch is easy to extend. To visualize a different mapping, you only need to change the function body in `function.pde` while leaving the rendering pipeline intact.

## Editing The Mapping

The active transformation lives in `function.pde` inside `f(Complex z)`. The file already contains several examples that can be enabled by uncommenting the desired expression and commenting out the current one.

Examples include `z.reciprocal()` for $f(z) = 1/z$, `z.power(2)` for $f(z) = z^2$, and `z.times(2)` for a simple scaling transform. Composite expressions are also supported, such as `z.add(new Complex(1, 0)).reciprocal().power(2)`.

## Running The Sketch

Open the project in Processing and run the sketch from the IDE, or use the included `run.sh` script if you prefer a command-line launch. Make sure the PeasyCam library is installed before running the project.

## Controls

Left click toggles between the grid and mapped animation states. Mouse scroll zooms the camera, and the middle mouse button pans the view.

## Examples

### $f(z) = 1/z$
![complex4](https://github.com/Nuwantha005/complex_mapping_in_cartesian_gird_using_lines/assets/132461834/bfb96479-ac7c-44e8-ac86-c7cd0e60396b)

### $f(z) = 3z^3$
![ezgif-5-996c4e2bec](https://github.com/Nuwantha005/complex_mapping_in_cartesian_gird_using_lines/assets/132461834/42a61822-8543-4d9b-ada3-30f29327e036)


