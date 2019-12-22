class IVector
{
  int x, y;
  
  IVector(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  IVector(float x, float y)
  {
    this.x = (int) x;
    this.y = (int) y;
  }
  
  float dist(IVector other)
  {
    return sqrt(pow(other.x - x, 2) + pow(other.y - y, 2));
  }
  
  void set(IVector other)
  {
    this.x = other.x;
    this.y = other.y;
  }
}
