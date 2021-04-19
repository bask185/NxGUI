class Crossing extends RailItem // to be made
{
  // variables
  int column;
  int row;
  int Xpos;
  int Ypos;
  int gridSize;
  int halveSize;
  int direction;
  int directionLimit = 7;
  // constructor
  Crossing(int Xpos, int Ypos, int direction , int gridSize, int input, int output) 
  {
    super(Xpos, Ypos, direction, gridSize, 0, output);
  }
  
  // functions
  
 
  void Draw()
  {
    switch(direction){
      case 0: //     |
      line(Xpos, Ypos-halveSize, Xpos,Ypos+halveSize);
      break;
       
      case 1: //     /
      line(Xpos+halveSize, Ypos-halveSize, Xpos-halveSize,Ypos+halveSize);
      break;
      
      case 2:  //    -              
      line(Xpos-halveSize, Ypos, Xpos+halveSize, Ypos); 
      break;  
      
      case 3:  //     \  
      line(Xpos-halveSize, Ypos-halveSize, Xpos+halveSize, Ypos+halveSize); 
      break;  
      
      case 4:
      break;
      
      case 5:
      break;
      
      case 6:
      break;
      
      case 7:
      break;
    }
  }
}
   
