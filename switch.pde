	class Switch extends RailItem
	{
	// variables
		
	// constructor
	Switch(int ID, int Xpos, int Ypos, int direction, int type, int gridSize, int state) {
		super(Xpos, Ypos, direction, gridSize);
		this.type = type;
		this.ID = ID;
		this.state = state;
		item = 1;
		designation = str(ID);
	}

	int triggered()
	{
		if(state==1) state=0;
		else         state=1;
		
		return state;
	}

	void Draw()
	{
		fill(0);
		switch(direction) {
		case 0: // 
		text(designation,Xpos+quarterSize,Ypos);
		line(Xpos, Ypos-halveSize, Xpos,Ypos+halveSize);
		if(type == 1) line(Xpos, Ypos, Xpos-halveSize, Ypos-halveSize);
		if(type == 2) line(Xpos, Ypos, Xpos+halveSize, Ypos-halveSize);
		stroke(255);
		if(state==1) line(Xpos,Ypos,Xpos,Ypos-quarterSize);
		else if(type == 1)  line(Xpos,Ypos,Xpos-quarterSize,Ypos-quarterSize);
		else if(type == 2)  line(Xpos,Ypos,Xpos+quarterSize,Ypos-quarterSize); 
		stroke(0);
		break;
		
		case 1: // /
		text(designation,Xpos+quarterSize,Ypos+quarterSize);
		line(Xpos+halveSize, Ypos-halveSize, Xpos-halveSize,Ypos+halveSize);
		if(type == 1) line(Xpos, Ypos, Xpos, Ypos-halveSize);
		if(type == 2) line(Xpos, Ypos, Xpos+halveSize, Ypos);
		stroke(255);
		if(state==1) line(Xpos,Ypos,Xpos+quarterSize,Ypos-quarterSize);
		else if(type == 1)  line(Xpos,Ypos,Xpos,Ypos-quarterSize);
		else if(type == 2)  line(Xpos,Ypos,Xpos+quarterSize,Ypos); 
		stroke(0);
		break;
		
		case 2:                   //     -                    each case has 2 x 2 lines. The top line is the straight direction of the switch and the second line is the turnout of the switch
		text(designation,Xpos,Ypos+quarterSize);
		line(Xpos-halveSize, Ypos, Xpos+halveSize, Ypos); 
		if(type == 1)  line(Xpos,Ypos,Xpos+halveSize,Ypos-halveSize);         // type 1 = LEFT switch
		if(type == 2)  line(Xpos,Ypos,Xpos+halveSize,Ypos+halveSize);         // type 2 = RIGHT switch
		stroke(255);
		if(state==1) line(Xpos,Ypos,Xpos+quarterSize,Ypos);
		else if(type == 1)  line(Xpos,Ypos,Xpos+quarterSize,Ypos-quarterSize);
		else if(type == 2)  line(Xpos,Ypos,Xpos+quarterSize,Ypos+quarterSize); 
		stroke(0);
		break;  
		
		case 3: // \
		text(designation,Xpos-quarterSize,Ypos+quarterSize);
		line(Xpos-halveSize, Ypos-halveSize, Xpos+halveSize,Ypos+halveSize);
		if(type == 1) line(Xpos, Ypos, Xpos+halveSize, Ypos);
		if(type == 2) line(Xpos, Ypos, Xpos, Ypos+halveSize);
		stroke(255);
		if(state==1) line(Xpos,Ypos,Xpos+quarterSize,Ypos+quarterSize);
		else if(type == 1)  line(Xpos,Ypos,Xpos+quarterSize,Ypos);
		else if(type == 2)  line(Xpos,Ypos,Xpos,Ypos+quarterSize); 
		stroke(0);
		break;
		
		case 4: // |
		text(designation,Xpos-quarterSize,Ypos);
		line(Xpos, Ypos-halveSize, Xpos,Ypos+halveSize);
		if(type == 1) line(Xpos, Ypos, Xpos+halveSize, Ypos+halveSize);
		if(type == 2) line(Xpos, Ypos, Xpos-halveSize, Ypos+halveSize);
		stroke(255);
		if(state==1) line(Xpos,Ypos,Xpos,Ypos+quarterSize);
		else if(type == 2)  line(Xpos,Ypos,Xpos-quarterSize,Ypos+quarterSize);
		else if(type == 1)  line(Xpos,Ypos,Xpos+quarterSize,Ypos+quarterSize); 
		stroke(0);
		break;
		
		case 5: // /
		text(designation,Xpos-quarterSize,Ypos-quarterSize);
		line(Xpos+halveSize, Ypos-halveSize, Xpos-halveSize,Ypos+halveSize);
		if(type == 1) line(Xpos, Ypos, Xpos, Ypos+halveSize);
		if(type == 2) line(Xpos, Ypos, Xpos-halveSize, Ypos);
		stroke(255);
		if(state==1) line(Xpos,Ypos,Xpos-quarterSize,Ypos+quarterSize);
		else if(type == 2)  line(Xpos,Ypos,Xpos-quarterSize,Ypos);
		else if(type == 1)  line(Xpos,Ypos,Xpos,Ypos+quarterSize); 
		stroke(0);
		break;
		
		case 6: // -
		text(designation,Xpos,Ypos-quarterSize);
		line(Xpos-halveSize, Ypos, Xpos+halveSize, Ypos); 
		if(type == 1)  line(Xpos,Ypos,Xpos-halveSize,Ypos+halveSize);         // type 1 = LEFT switch
		if(type == 2)  line(Xpos,Ypos,Xpos-halveSize,Ypos-halveSize);         // type 2 = RIGHT switch
		stroke(255);
		if(state==1) line(Xpos,Ypos,Xpos-quarterSize,Ypos);
		else if(type == 2)  line(Xpos,Ypos,Xpos-quarterSize,Ypos-quarterSize);
		else if(type == 1)  line(Xpos,Ypos,Xpos-quarterSize,Ypos+quarterSize); 
		stroke(0);
		break;
		
		case 7: // \
		text(designation,Xpos+quarterSize,Ypos-quarterSize);
		line(Xpos-halveSize, Ypos-halveSize, Xpos+halveSize,Ypos+halveSize);
		if(type == 1) line(Xpos, Ypos, Xpos-halveSize, Ypos);
		if(type == 2) line(Xpos, Ypos, Xpos, Ypos-halveSize);
		stroke(255);
		if(state==1) line(Xpos,Ypos,Xpos-quarterSize,Ypos-quarterSize);
		else if(type == 1)  line(Xpos,Ypos,Xpos-quarterSize,Ypos);
		else if(type == 2)  line(Xpos,Ypos,Xpos,Ypos-quarterSize); 
		stroke(0);
		break;
		}
	} 
}
