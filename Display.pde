class Display {  // 40 x 16
  int Xmin, Xmax, Ymin, Ymax;
  int Xsize, Ysize, Xpos, Ypos;
  
  int kleurIndex;
  final int colMax = 30 ;
  
  int Xcursor, Ycursor; 
  
  int figure;

  color Green = color(0);

  boolean cursor = false, blink;

  color[] c = new color[16];
  Text[][] text = new Text[40][16]; // 2D array which holds all lettre objects


  Display(int Xpos, int Ypos, int Xsize, int Ysize) { // constructor
    this.Xsize = Xsize;
    this.Ysize = Ysize;
    this.Xpos = Xpos;
    this.Ypos = Ypos;

    c[0] = color(0);           // black  // fills the color array
    c[1] = color(0, 0, 255);     // blue
    c[2] = color(0, 255, 0);     // green
    c[3] = color(0, 255, 255);   // cyan
    c[4] = color(255, 0, 0);     // red
    c[5] = color(255, 0, 255);   // magenta
    c[6] = color(255, 255, 0);   // yellow
    c[7] = color(250);         // white
    c[8] = color(125);         // gray
    c[9] = color(150, 150, 255);   // light blue
    c[10] = color(150, 240, 50);  // light green
    c[11] = color(150, 240, 240); // light cyan
    c[12] = color(240, 150, 150);  // light red
    c[13] = color(240, 150, 240); // light magenta
    c[14] = color(240, 240, 150); // light yellow
    c[15] = color(255);        // bright white

    clear(); // fills the arrays to prevent dem annoying nullpointer exception issues.
  }

  void store(char b ) {
    text[column][row].setText(b, c[2]); // safes any lettre with colour as arguement
    if(column < colMax) column++;
  }

void store(String str ) {
	byte index = 0 ;
	for(index = 0 ; index < str.length() ; index++ ) 
  {
	  text[column][row].setText(str.charAt(index), c[2]); // safes any lettre with colour as arguement
	  if(column < colMax) column++;
	}
}

void printAt(int col, int row, String str )
{
	setPosition( col, row );
	store(str);
}

void printNumber(int num )  // just a wrapper really
{
	store(num);
}

void printNumberAt(int col, int row, int num )
{
	setPosition( col, row );
	store(num);
}

void store(int number)
{
	store( Integer.toString(number) );
}


  void paint() {
    fill(0);
    stroke(0);                    // white outline 
    rect(Xpos, Ypos, Xsize, Ysize); // draws new black rectangle over old one
    //noStroke();                     // no outline

    textAlign(BOTTOM, LEFT);
    textSize(20);
    for (int i = 0; i < 16; i++) {
      for (int j = 0; j < 40; j++) {
        fill(text[j][i].getCol());                            // gets the colour of the lettre
        text(text[j][i].getText(), Xpos + 10 + j * 25, Ypos + 25 + i * 23); // draws all the lettres in the display
      }
    }
   /* if(millis() - time > 500) {   // function which handles the Blinking cursor  millis() returns the time that the program runs in ms, 32 bit variable
      blink = !blink;
      time = millis();
    } /*/
    
    if(cursor == true /*&& blink == true*/) {                // draws cursor if it must be drawn and if it is time to blink
      fill(c[kleurIndex]);  
      rect(8 + Xcursor * 25, 9 + Ycursor * 23, 19 , 20);   // draws cursor w/ X/Y offset 8, 9
    }   
    
    if (figure > 0) {          // draws the big figure
      fill(240);
      textSize(50);
      textAlign(RIGHT);
      text(figure, 1014, 50);
    }
  }

  void clear() {
    for (int i = 0; i < 16; i++) {
      for (int j = 0; j < 40; j++) {
        text[j][i] = new Text(' ', c[0]); // 'empties' the button array by filling them with black ' ' (spaces)
      }
    }
  }
  
  void clearToEnd() {                   // clears the line after current X alpha position.
    for(int i = column; i < 40; i++) {
      text[i][row].setText(' ',0);
    }
  }
  
  void clearToEndOfScreen() {          // clears the rest of the page after the alpha position.
    for(int i = column; i < 40; i++) {
      text[i][row].setText(' ', 0);    // clears top line
    }
    for(int j = row + 1; j < 16; j++) {
      for(column = 0; column < 40; column++){ // clears everything else
          text[column][j].setText(' ', 0);
      }
    }
  }
  
  void cursorOn(boolean COWS_CAN_FLY) {
    cursor = COWS_CAN_FLY;                      // sets the boolean used for the cursor true
  }  
  void setPosition(int x, int y) {              // sets position of the alpha position (where text gets drawn)
    column = x;
    row = y;
  } 
  void setCursor(int x, int y) {                // sets cursor position (where text is drawn and where the cursor is are 2 different things)
   Xcursor = x;  
   Ycursor = y;
  }  
  void shiftLeft() {                             // shifts the cursor left 1 pos
    if(Xcursor > 0) Xcursor--;
  }  
  void shiftRight() {
    if(Xcursor < colMax) Xcursor++;                  // shifts the cursor right 1 pos
  }
  void setFigure(int FISH) {                     // sets the big figure
    figure = FISH;
  }
  void setColor(int kleurIndex) {                // sets the colorindex
    this.kleurIndex = kleurIndex;
  }
  int getColor() {                               // gets the color of the lettre
    return kleurIndex;
  }
}