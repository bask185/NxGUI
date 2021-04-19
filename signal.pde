class Signal extends RailItem{
// variables

// constructor
Signal(int ID, int Xpos, int Ypos, int direction, int gridSize, int type, int input, int output ) {
    super(Xpos, Ypos, direction, gridSize, input, output);
    this.type = type;
    this.ID = ID;
    //this.state = state;
    item = 7;
    designation = str(ID);
}

// functions

void Draw()   {
    line(Xpos, Ypos+quarterSize, Xpos, Ypos-quarterSize);
    if( state > 0 ) fill(0,230,0);
    else            fill(0,128,0);
    ellipse(Xpos, Ypos-halveSize, quarterSize, quarterSize);
    if( state > 0 ) fill(128,0,0);
    else            fill(230,0,0);
    ellipse(Xpos, Ypos-quarterSize, quarterSize, quarterSize);
    fill(0);
    text(designation,Xpos+quarterSize,Ypos);
} 

    int triggered() {
        if(state==1) state=0;
        else         state=1;
        
        return state;
    }
}
    
