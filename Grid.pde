class Grid
{
  Node[][] nodes;
  float nodeWidth;
  Node start, end;
  
  Grid(PImage maze, IVector spos, IVector epos)
  {
    int w = maze.width;
    int h = maze.height;
    boolean[][] blocks = blocksFromImage(maze);
    
    nodes = new Node[w][h];
    
    start = new Node(spos.x, spos.y, start);
    start.type = Type.START;
    end = new Node(epos.x, epos.y, start);
    end.type = Type.END;
    
    for (int x = 0; x < nodes.length; x++)
    {
      for (int y = 0; y < nodes[0].length; y++)
      {
        nodes[x][y] = new Node(x, y, start);
        if (blocks[x][y])
        {
          nodes[x][y].type = Type.BLOCK;
        }
      }
    }
    
    nodes[spos.x][spos.y] = start;
    nodes[epos.x][epos.y] = end;
    
    nodeWidth = (float) width / w;
  }
  
  boolean[][] blocksFromImage(PImage maze)
  {
    boolean[][] blocks = new boolean[maze.width][maze.height];
    
    for (int x = 0; x < maze.width; x++)
    {
      for (int y = 0; y < maze.height; y++)
      {
        blocks[x][y] = red(maze.get(x, y)) < 200;
      }
    }
    
    return blocks;
  }
  
  void showGrid()
  {
    for (int x = 0; x < nodes.length; x++)
    {
      for (int y = 0; y < nodes[0].length; y++)
      {
        fill(nodes[x][y].type.col);
        rect(x * nodeWidth, y * nodeWidth, nodeWidth, nodeWidth);
      }
    }
  }
}
