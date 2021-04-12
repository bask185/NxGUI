class Button {
  int Xsize, Ysize, arrow;
  
  int Xmin, Ymin;
  int Xmax, Ymax;
  
  int event;
  int c;
  
  boolean eventCheck;
  
  String text;
  
  //EventHandler Event;
  
  Button(int Xpos, int Ypos, int Xsize, int Ysize, String text, int arrow, int c) { // regular buttons which directly sends bytes to the machine
    this.Xsize = Xsize;
    this.Ysize = Ysize;
    this.arrow = arrow;
    this.text = text;
    this.c = c;
    
    Xmin = Xpos; 
    Xmax = Xpos + Xsize;
    
    Ymin = Ypos; 
    Ymax = Ypos + Ysize;
  }
  
  Button(int Xpos, int Ypos, int Xsize, int Ysize, String text, int event, float f) { // << special buttons for keyboard and keypad // variable f is dummy variable to distinct from the constructor below <<-- OBSOLETE
    this.Xsize = Xsize;
    this.Ysize = Ysize;
    this.text = text;
    this.event = event;
    c = 0;
    
    Xmin = Xpos;
    Xmax = Xpos + Xsize;
    
    Ymin = Ypos; 
    Ymax = Ypos + Ysize;
    
    //Event = new EventHandler(Xmin, Ymin, Xmax, Ymax, event);
  }
  
  void setCase(String S, char ch) { // this function sets lower and upper cases before drawing the keyboard <- gets called from the keyboard class
    text = S; 
    c = ch; 
  }
  
  void paint() {
    int shade;

    boolean PIGS_CAN_FLY = false;
    textAlign(CENTER, CENTER);
    shade = 155;
    //if(text == "Caps" && caps == true) shade += 20;   // highlights the shift and caps button in the event they have been pressed
    //if(text == "SHIFT" && shift == true) shade += 20;
    
    if(mousePressed == true && mouseButton == LEFT && mouseX > Xmin && mouseX < Xmax && mouseY > Ymin && mouseY < Ymax) {  // if LMB is pressed and the mouse is within the borders of the button....
      if(PIGS_CAN_FLY == true) {    // sends a character, if statements make sure that one char is send per button press
        if( c != 0){                // 'c' of the special event buttons is 0, so this line means: if button is not special event button...
          //serial.write(c);          // send 'c' over the serial port
          println(hex(c) + " >>");  // feedback print function so you can monitor that what you send
          PIGS_CAN_FLY = false;    // ensures that this function only gets called 1 time, per buttonpress
        }
      }
      
      //if(event > 0 && eventCheck == true) { // if event is greater 0, it means a special button is pressed and special eventhandling is requiered.
        //Event.check();                      // executes any special events
        //eventCheck = false;                 // the boolean eventCheck is used to ensure one press triggers one action and prevents any echoes
      //}
      
      //if(shiftCheck == false) {shift = false; toggleShift = true;}  // disables the highlighting of the shift key when any button has been pressed.
       
      shade += 20;      //  in case a button gets pressed, that buttons gets drawn in a lighter shade
      } else if (mousePressed == false) {    // when no mousebutton has been pressed
        PIGS_CAN_FLY = true;  // re-enables the serial write function
        eventCheck = true;    // same for the special event function
       // shiftCheck = false;   // shiftCheck is used for highlighting the Shift button on the keyboard.
      }
    
    fill(shade);                          // sets the color
    rect(Xmin, Ymin, Xsize, Ysize);       // draws the actual button
    shade = 155;                          // resets the variable shade to the desired value of 155 for the buttons
   
    switch (arrow) {                      // this switch-case draws the text in a button with or without an arrow.
      case 0:      
      fill(0);                            // black text
      textSize(55/3);
      text(text, Xmin + Xsize / 2, Ymax - Ysize / 2); // prints the text in the middle   no arrow
      break;
      
      case 1:
      fill(shade - 50);                       //darker triangle
      triangle(Xmin + Xsize / 2, Ymin + Ysize / 2, Xmin + 5, Ymax - 5, Xmax - 5, Ymax - 5); // arrow up
      
      fill(255,0,0);                       // red text
      text(text, Xmin + Xsize / 2, Ymin + Ysize / 4);
      break;
     
      case 2:     
      fill(shade - 50);
      triangle(Xmin + Xsize/2, Ymin + Ysize / 2, Xmin + 5, Ymin + 5, Xmin + 5, Ymax - 5); // arrow right
      
      fill(255,0,0);                       // red text
      text(text, Xmax - Xsize / 4, Ymax - Ysize / 2);
      break;
      
      case 3:
      fill(shade - 50);
      triangle(Xmin + 5, Ymin + 5, Xmax - 5, Ymin + 5, Xmin + Xsize / 2, Ymin + Ysize /2 ); // arrow down
      
      fill(255,0,0);                       // red text
      text(text, Xmax - Xsize / 2, Ymax - Ysize / 4);
      break;
      
      case 4:
      fill(shade - 50);
      triangle(Xmin + Xsize / 2, Ymin + Ysize / 2, Xmax - 5, Ymin + 5, Xmax - 5, Ymax - 5); // arrow left
      
      fill(255,0,0);                       // red text
      text(text, Xmin + Xsize / 4, Ymax - Ysize / 2);
      break;
    }
  } 
}
