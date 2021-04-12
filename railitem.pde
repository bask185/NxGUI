class RailItem{
  // variables
  int column;
  int row;
  int Xpos;
  int Ypos;
  int direction;
  int gridSize;
  int halveSize;
  int quarterSize;
  int item;
  int type;
  int state = 0;
  int ID;
  int directionLimit = 7;
  
  String designation = "";
  
  int getItem()
  {
    return item;
  }
  
  RailItem(int Xpos, int Ypos, int direction, int gridSize)
  {
    this.Xpos = gridSize + Xpos * gridSize;
    this.Ypos = gridSize + Ypos * gridSize;
    this.direction = direction;
    this.gridSize = gridSize;
    halveSize = gridSize / 2;
    quarterSize = halveSize / 2;
    column = Xpos;
    row = Ypos;
  }
 
 int getDirection()
 {
   return direction;
 }
 
 int getType()
 {
   return type;
 }
  
  void setID(int ID)
  {
    this.ID = ID;
    designation = str(ID);
  }
  
  int getID()
  {
    return ID;
  }
  
  void setPos(int Xpos, int Ypos)
  {
    column = Xpos;
    row = Ypos;
    this.Xpos = gridSize + Xpos * gridSize;
    this.Ypos = gridSize + Ypos * gridSize;
  }
  
  int getState()
  {
    return state;
  }
   
  void setState(int state)
  {
    this.state = state;
  }
  
  void setGridSize(int _gridSize)
  {
    this.gridSize = _gridSize;
    this.halveSize = _gridSize / 2;
  }
  
  int getColumn()
  {
    return column;
  }
  
  int getRow()
  {
    return row;
  }
  
  void turnLeft()
  {
    if(--direction<0) direction = directionLimit;
    
  }
  
  void turnRight()
  {
    if(++direction>directionLimit) direction = 0;
  }
  
  // functions
  
}
