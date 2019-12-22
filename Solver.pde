class Solver extends Thread
{
  ArrayList<Node> open = new ArrayList<Node>();
  ArrayList<Node> closed = new ArrayList<Node>();
  
  Node start, end, last;
  Grid grid;
  int delay;
  
  Solver(Grid grid, int delay)
  {
    this.grid = grid;
    this.start = grid.start;
    this.end = grid.end;
    open.add(start);
    this.delay = delay;
    
    last = end;
  }
  
  void run()
  {
    delay(1000);
    while(true)
    {
      if (open.size() == 0)
      {
        return;
      }
      
      Node current = open.remove(getLowestCost());
      closed.add(current);
      last = current;
      
      if (current.type == Type.END)
      {
        return;
      }
      
      Node[] neighbors = getNeighbors(current);
      
      for (Node neighbor : neighbors)
      {
        if (!(neighbor.type == Type.BLOCK || in(closed, neighbor)))
        {
          if (in(open, neighbor))
          {
            if (hCost(neighbor) + gCost(neighbor, current) < fCost(neighbor))
            {
              neighbor.parent = current;
            }
          }
          else
          {
            neighbor.parent = current;
            open.add(neighbor);
          }
        }
      }
      delay(delay);
    }
  }
  
  int getLowestCost()
  {
    int lowest = 0;
    
    for (int i = 0; i < open.size(); i++)
    {
      if (fCost(open.get(i)) < fCost(open.get(lowest)))
      {
        lowest = i;
      }
    }
    
    return lowest;
  }
  
  Node[] getNeighbors(Node n)
  {
    Node[] neighbors = new Node[8];
    
    int counter = 0;
    
    for (int x = n.pos.x - 1; x <= n.pos.x + 1; x++)
    {
      for (int y = n.pos.y - 1; y <= n.pos.y + 1; y++)
      {
        if (x >= 0 && x < grid.nodes.length && y >= 0 && y < grid.nodes[0].length)
        {
          neighbors[counter] = grid.nodes[x][y];
        }
        else
        {
          neighbors[counter] = new Node();
          neighbors[counter].type = Type.BLOCK;
        }
        
        if (x != n.pos.x || y != n.pos.y)
          counter++;
      }
    }
    
    return neighbors;
  }
  
  boolean in(ArrayList<Node> al, Node n)
  {
    for (Node node: al)
    {
      if (n == node)
      {
        return true;
      }
    }
    return false;
  }
  
  
  // ----------------------------------------------------------------------
  // Finding node costs
  // ----------------------------------------------------------------------
  
  float gCost(Node node)
  {
    return gCost(node, node.parent);
  }
  
  float gCost(Node node, Node assign)
  {
    float d = 0;
    Node testing1 = node;
    Node testing2 = assign;
    
    if (testing1.type == Type.START)
    {
      return 0;
    }
    
    while(testing2.type != Type.START)
    {
      d += testing1.distance(testing2);
      
      testing1 = testing2;
      testing2 = testing2.parent;
    }
    
    return d;
  }
  
  float hCost(Node node)
  {
    return node.distance(end);
  }
  
  float fCost(Node node)
  {
    return gCost(node) + hCost(node);
  }
  
  void showSolve()
  {
    fill(0, 200, 100);
    for (int i = 0; i < open.size(); i++)
    {
      rect(open.get(i).pos.x * grid.nodeWidth, open.get(i).pos.y * grid.nodeWidth, 
           grid.nodeWidth, grid.nodeWidth);
    }
    
    fill(200, 100, 0);
    for (int i = 0; i < closed.size(); i++)
    {
      rect(closed.get(i).pos.x * grid.nodeWidth, closed.get(i).pos.y * grid.nodeWidth, 
           grid.nodeWidth, grid.nodeWidth);
    }
    
    fill(100, 0, 200);
    Node node = last.parent;
    
    while(node.type != Type.START)
    {
      rect(node.pos.x * grid.nodeWidth, node.pos.y * grid.nodeWidth, 
           grid.nodeWidth, grid.nodeWidth);
      node = node.parent;
    }
  }
}
