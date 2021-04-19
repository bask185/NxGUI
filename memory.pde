class Memory extends RailItem // has become a start stop switch
{
  int switchIndex = 0;
  
  int[] attachedSwitches = new int[256];
  int[] switchStates = new int[256];
  
  Memory(int ID, int Xpos, int Ypos, int direction, int gridSize, int type, int input, int output )
  {
    super(Xpos, Ypos, direction, gridSize, input, output);
    this.ID = ID;
    this.type = type ;
    item = 5;
    
    designation = str(ID);
  }

  
  void Draw()
  {
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
    
    fill(200,200,0);
    
    stroke(0);
    ellipse(Xpos,Ypos,gridSize-5,gridSize-5);
    fill(0);
    text(designation,Xpos,Ypos);
  }
}
