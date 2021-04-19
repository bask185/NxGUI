class Decoupler extends RailItem
{
  // variables
  
  // constructor
  Decoupler(int ID, int Xpos, int Ypos, int direction , int gridSize, int input, int output, int type) 
  {
    super(Xpos, Ypos, direction, gridSize, input, output);
    this.ID = ID;
    this.type = type ;
    designation = str(ID);
    item = 6;
  }
  
  // functions
  
  void Draw()
  {
    fill(0);
    if(direction>3)direction-=4;
    switch(direction) {
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
      break; }  
    if(state == 1) fill(0,255,0);
    else           fill(255,0,0);
    quad(Xpos-halveSize, Ypos+quarterSize, Xpos-quarterSize, Ypos-quarterSize,  Xpos+quarterSize, Ypos-quarterSize, Xpos+halveSize, Ypos+quarterSize);
    fill(0);
    stroke(0);
    text(designation,Xpos,Ypos);
  }
}
