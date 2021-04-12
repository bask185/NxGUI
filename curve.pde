class Curve extends RailItem
{
  // variables
  
  // constructor
  Curve(int Xpos, int Ypos, int direction, int gridSize) 
  {
    super(Xpos, Ypos, direction, gridSize);
    item = 3;
  }
  
  // functions
  
  void Draw()
  { 
    stroke(100);
    fill(100);
    
    switch(direction) {
      case 0: //     |
      line(Xpos, Ypos, Xpos, Ypos+halveSize);
      line(Xpos, Ypos, Xpos-halveSize, Ypos-halveSize);
      break;
       
      case 1: //     /
      line(Xpos, Ypos, Xpos-halveSize, Ypos+halveSize);
      line(Xpos, Ypos, Xpos, Ypos-halveSize);
      break;
      
      case 2:  //    -              
      line(Xpos, Ypos, Xpos-halveSize, Ypos);
      line(Xpos, Ypos, Xpos+halveSize,Ypos-halveSize);
      break;  
      
      case 3:  //     \  
      line(Xpos, Ypos, Xpos-halveSize, Ypos-halveSize);
      line(Xpos, Ypos, Xpos+halveSize, Ypos);
      break; 
      
      case 4:  //     \  
      line(Xpos, Ypos, Xpos, Ypos-halveSize);
      line(Xpos, Ypos, Xpos+halveSize,Ypos+halveSize);
      break;  
      
      case 5:  //     \  
      line(Xpos, Ypos, Xpos+halveSize, Ypos-halveSize);
      line(Xpos, Ypos, Xpos,Ypos+halveSize);
      break;  
      
      case 6:  //     \  
      line(Xpos, Ypos, Xpos+halveSize, Ypos);
      line(Xpos, Ypos, Xpos-halveSize,Ypos+halveSize);
      break;  
      
      case 7:  //     \  
      line(Xpos, Ypos, Xpos+halveSize, Ypos+halveSize);
      line(Xpos, Ypos, Xpos-halveSize,Ypos);
      break;  
  
    }
  }
}
