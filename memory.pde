class Memory extends RailItem 
{
  int switchIndex = 0;
  
  int[] attachedSwitches = new int[256];
  int[] switchStates = new int[256];
  
  Memory(int ID, int Xpos, int Ypos, int direction, int gridSize)
  {
    super(Xpos, Ypos, direction, gridSize);
    this.ID = ID;
    item = 5;
    
    designation = str(ID);
  }
  
  void addSwitch(int switchID, int state)  
  {
    attachedSwitches[switchIndex] = switchID;
    switchStates[switchIndex++] = state;
  }
  
  void triggered()
  {
    if(state == 1) state =0;
    else state = 1;
  }
  
  int[] getSwitches()
  {
    return attachedSwitches;
  }
  
  int[] getStates()
  {
    return switchStates;
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
    ellipse(Xpos,Ypos,gridSize-10,gridSize-10);
    fill(0);
    text(designation,Xpos,Ypos);
  }
}
