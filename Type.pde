enum Type
{
  DEFAULT (#FFFFFF), 
  START (#00FF00), 
  END (#FF0000), 
  BLOCK (#000000);
  
  color col;
  
  private Type(color col)
  {
    this.col = col;
  }
}
