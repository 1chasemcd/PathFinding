Grid grid;
Solver solver;

void setup() {
  size(700, 700);
  noStroke();
  
  PImage maze = loadImage("maze.png");
  IVector start = new IVector(1, 1);
  IVector end = new IVector(maze.width-2, maze.height-2);
  
  grid = new Grid(maze, start, end);
  solver = new Solver(grid, 0);
  solver.setDaemon(true);
  solver.start();
}


void draw() {
  grid.showGrid();
  solver.showSolve();
}
