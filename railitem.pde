// typedef struct someName {    // the data structs copied from the arduino side, to keep track in how I should store data on the SD card
//     uint8_t ID ;
//     uint8_t type ;
//     uint8_t state ;
//     uint8_t statePrev ;
//     uint8_t pin ;           // some devices have both an input as well as an output such as a occupancy detector
//     uint8_t linkedPin ;
// } railItems ;
// extern railItems IO ;

// // N.B. rail sections will propably be great in amount, therefor reduced RAM storage is preferable.
// typedef struct  
// {
//     uint8_t x0 ;
//     uint8_t y0  ; 
//     uint8_t x1 ; // 'normal' objects have 2 connections
//     uint8_t y1 ; 
//     uint8_t x2 ;
//     uint8_t y2 ;
//     uint8_t x3 ; // points have 3 connections <-- node only
//     uint8_t y3 ;
// } trackSegments ;

class RailItem{
  // variables
  int column;
  int row;
  int Xpos;
  int Ypos;

  int x0;   // following 8 coordinates are for SD card.
  int y0;
  int x1;
  int y1;
  int x2;
  int y2;
  int x3;     // point have three connections
  int y3;

  int ID ;
  int type ;
  int LR ;

  int pin ;           // some devices have both an input as well as an output such as a occupancy detector
  int linkedPin ;

  int direction;
  int gridSize;
  int halveSize;
  int quarterSize;
  int item;
  int state ; 
  int directionLimit = 7;

  //final int[][] positions ;
  
  String designation = "";
  
  int getItem()
  {
    return item;
  }
  
  
  RailItem(int Xpos, int Ypos, int direction, int gridSize )
  {
    this.Xpos = gridSize + Xpos * gridSize;
    this.Ypos = gridSize + Ypos * gridSize;
    this.direction = direction;
    this.gridSize = gridSize;
   // this.type = type ;
    halveSize = gridSize / 2;
    quarterSize = halveSize / 2;
    column = Xpos;
    row = Ypos;
  }

  int getLR()
	{
		return LR ;
	}

  void recordPositions()  // this function is to make sure that all variables are set after a new railItem is put in place
  {

  }


  int getPin()
  {
    return pin ;
  }

  int getLinkedPin()
  {
    return linkedPin ;
  }

  void setPin( int _pin )
  {
    pin = _pin ;
  }

  void setLinkedPin( int _pin )
  {
    linkedPin = _pin ;
  }
 
  int getDirection()
  {
    return direction;
  }

  void setType(int type)
  {
    this.type = type ;
  }
  
  int getType()
  {
    return type ;
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
