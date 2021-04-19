class Line extends RailItem
{
  // variables

  // constructor
  Line(int Xpos, int Ypos, int direction, int gridSize, int type )
  {
    super(Xpos, Ypos, direction, gridSize, 0, 0);
    this.type = type ;
    item = 2;
  }
  
  void Draw()
  { 
    switch( direction ) {
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
   
    }
  }
}
