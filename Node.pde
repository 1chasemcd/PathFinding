class Node
{
  Type type;
  Node parent;
  IVector pos;
  
  Node(int x, int y, Node parent)
  {
    this.type = Type.DEFAULT;
    this.pos = new IVector(x, y);
    this.parent = parent;
  }
  
  // Construct an empty type for simple uses
  Node()
  {
    this.type = Type.DEFAULT;
    this.pos = new IVector(0, 0);
    this.parent = null;
  }
  
  
  float distance(Node n)
  {
    return pos.dist(n.pos);
  }
}
