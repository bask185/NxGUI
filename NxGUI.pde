/* next things to do
* remove play mode and whatever is associated with it
* change memories into switches, or simply make a switch and delete the memory
* delete turnout street code, not needed for NX code
* make an interface with which you can select input IO and linked output IO (greenscreen code from work perhaps?)
* store IO and railitems seperately
* add adjacent stuff for DCC and Xnet and such
* copy enum with items from NxDuino
*/
    
int gridSize;
boolean locked = false;

final int settingID = 1;
final int movingItem = 3;
final int deletingItem = 4;
final int settingInputPin = 5;
final int settingOutputPin = 6;
final int settingType = 7;


enum types
{
    start_stop_sw           ,   // I2C input
    relay_sw                ,   // I2C input
    occupancy_1_I2C         ,   // I2C input
    occupancy_2_I2C         ,   // I2C input
    route_led               ,   // I2C output
    occupance_led_1         ,   // I2C output
    occupance_led_2         ,   // I2C output
    point_pulse             ,   // I2C output
    point_relay             ,   // I2C output
    relay_I2C               ,   // I2C output
    relay_DCC               ,   // Xnet/DCC output
    point_DCC               ,   // Xnet/DCC output
    occupancy_1_Xnet        ,   // Xnet input message
    occupancy_2_Xnet            // Xnet input message
} ;

int typeIndex ;
String[] types = 
{
    "start stop sw",
    "relay sw",
    "occupancy 1 I2C",
    "occupancy 2 I2C",
    "route led",
    "occupance led 1",
    "occupance led 2",
    "point pulse",
    "point relay",
    "relay I2C",
    "relay DCC",
    "point DCC",
    "occupancy 1 Xnet",
    "occupancy 2 Xnet"
};

final int NA = 255 ;            // not available = 255 
int mode = 255;
PrintWriter output;
BufferedReader input;

int left = 1;
int right = 2;

int state;

int item;

int index;
int selector;

int row;
int column;

int ID;

int edgeOffset = 23;

int number = 0;


Switch sw1;
Switch sw2;
Line l1;
Curve c1;
Detection d1;
Memory m1;
Decoupler D1;
Signal S1;

//SSP ssp1;
Display display;


ArrayList <RailItem> railItems = new ArrayList();


void setup() {
    textAlign(CENTER,CENTER);

    //PFont mono;
    // The font "andalemo.ttf" must be located in the 
    // current sketch's "data" directory to load successfully
    //mono = createFont("Monospaced.ttf", 32);
    //textFont(mono, 32);
    
    gridSize = width / 64 - 2;
    gridSize = constrain(gridSize, 10, 50);

    textSize(gridSize/2);

    
    fullScreen();
    background(255);
    //fullScreen();

    sw1 = new Switch(	0,	(width-gridSize-edgeOffset) / gridSize, 0, 2, gridSize, 1); // make default Objects to display on the right side of the UI
    sw2 = new Switch(	0,	(width-gridSize-edgeOffset) / gridSize, 1, 2, gridSize, 2);
    l1 =  new Line(			(width-gridSize-edgeOffset) / gridSize, 2, 2, gridSize);
    c1 =  new Curve(		(width-gridSize-edgeOffset) / gridSize, 3, 2, gridSize);
    d1 =  new Detection(0,	(width-gridSize-edgeOffset) / gridSize, 4, 2, gridSize);
    m1 =  new Memory(	0,	(width-gridSize-edgeOffset) / gridSize, 5, 2, gridSize);
    D1 =  new Decoupler(0,	(width-gridSize-edgeOffset) / gridSize, 6, 2, gridSize);
    S1 =  new Signal(   0,  (width-gridSize-edgeOffset) / gridSize, 7, 0, gridSize, 0);

    loadLayout();

    display = new Display(gridSize*15, gridSize*33, gridSize*31, gridSize*32/3);
}


void whipeScreen()
{
    textSize(gridSize /4);
    textAlign(CENTER,CENTER);
    fill(200);
    stroke(255);
    rect(0,0,width,height); // clear screen 
    stroke(0);
}

void drawRightSideItems()
{
    sw1.Draw();
    sw2.Draw();
    l1.Draw();
    c1.Draw();
    d1.Draw();
    m1.Draw();
    D1.Draw();
    S1.Draw();
}

void drawRailItems()
{
    for (int i = 0; i < railItems.size(); i++) {	
        RailItem anyClass = railItems.get(i);
        if(anyClass instanceof Switch) 	  { Switch     sw = (Switch)    anyClass; sw.Draw();}
        if(anyClass instanceof Detection) { Detection det = (Detection) anyClass; det.Draw();}
        if(anyClass instanceof Line) 	  { Line       ln = (Line)      anyClass; ln.Draw();}
        if(anyClass instanceof Curve) 	  { Curve      cv = (Curve)     anyClass; cv.Draw();}
        if(anyClass instanceof Memory) 	  { Memory    mem = (Memory)    anyClass; mem.Draw();}
        if(anyClass instanceof Decoupler) { Decoupler dec = (Decoupler) anyClass; dec.Draw();}
        if(anyClass instanceof Signal) 	  { Signal    sig = (Signal)    anyClass; sig.Draw();} }
}

void drawTexts()
{
    fill(0);
    textSize(gridSize/2 );
    textAlign(LEFT,CENTER);
    
    textSize(gridSize/2 );
    text( "point left", 65 * gridSize + 5, gridSize * 1 );
    text("point right", 65 * gridSize + 5, gridSize * 2 );
    text(       "line", 65 * gridSize + 5, gridSize * 3 );
    text(      "curve", 65 * gridSize + 5, gridSize * 4 );
    text(   "detector", 65 * gridSize + 5, gridSize * 5 );
    text(     "button", 65 * gridSize + 5, gridSize * 6 );
    text(  "decoupler", 65 * gridSize + 5, gridSize * 7 );
    text(     "signal", 65 * gridSize + 5, gridSize * 8 );    
    
    text("MENU:"                , gridSize, 34 * gridSize );
    text("<M/m> = move items"   , gridSize, 35 * gridSize );
    text("<D/d> = delete items" , gridSize, 36 * gridSize );
    text("<I/i> = set input"    , gridSize, 37 * gridSize );
    text("<O/o> = set output"   , gridSize, 38 * gridSize );
    text("<T/t> = set IO type"  , gridSize, 39 * gridSize );
    text("<N/n> = set ID"       , gridSize, 40 * gridSize );
    text("<Esc> = quit program" , gridSize, 41 * gridSize );
    text("SAVE"                 , gridSize, height - gridSize/2);
    display.paint();
}

 void updateColumn()
    {
        column = (gridSize/2+constrain(mouseX,0,width-2*gridSize)) / gridSize - 1;
        row = (gridSize/2+constrain(mouseY,0,height-2*gridSize)) / gridSize - 1;
    }

void drawGrid() {
    fill(255);
    stroke(0);
    rect(1,1,65*gridSize-1, 33*gridSize-1);
    for(int i = 0 ; i < 64 ; i++ )
    {
        for(int j = 0 ; j < 32 ; j++ )
        {
            rect(gridSize+i*gridSize,gridSize+j*gridSize,0,0);
        } 
    } 
}


/// ABOVE ARE ALL DRAW FUNCTIONS //////

///////////////// MAIN LOOP /////////////
void draw() {    
    whipeScreen() ;
    drawRightSideItems() ;
    updateColumn() ;
    drawGrid();						// draw items on the right
    drawTexts() ;
    drawRailItems() ;

}

/// BELOW ARE ALL EVENT functions

//  mousePressed()
//  mouseDragged()
//  mouseReleased()
//  keyPressed()

void mousePressed()
{	
    if(mouseX < width / 2 && mouseY > height - gridSize) saveLayout(); // works
    
    RailItem anyClass = railItems.get(0);
    
    for (int i = 0; i < railItems.size(); i++)
    { 
        anyClass = railItems.get(i);																			// store the object in 'anyClass' 
        if(column == anyClass.getColumn() && row == anyClass.getRow()) 	// get index of clicked item	 
        {
            locked = true;
            index = i;
  
            display.printAt(0,2, "ID         = "); display.printNumber( anyClass.getID()       ) ; display.clearToEnd();
            display.printAt(0,3, "INPUT PIN  = "); display.printNumber( anyClass.getPin()      ) ; display.clearToEnd();
            display.printAt(0,4, "OUTPUT PIN = "); display.printNumber( anyClass.getLinkedPin()) ; display.clearToEnd();
            display.printAt(0,5, "type = "); display.store( types[ anyClass.getType() ] ) ;
            // if(anyClass instanceof Switch) 		print("SWITCH ");
            break;
        } 
    }
    
    if( mode == movingItem) 
    {
        if(mouseX > (width-2*gridSize)) 
        { 
            locked = true;
            println("new item created");
            switch(row) 
            {
                case 0: railItems.add( new Switch(   0,(width - 2 * gridSize)      / gridSize, 0, 2, gridSize,left )); println("SWITCH CREATED");    break;
                case 1: railItems.add( new Switch(   0,(width - 2 * gridSize)      / gridSize, 0, 2, gridSize,right)); println("SWITCH CREATED");    break;
                case 2: railItems.add( new Line(       (width - 2 * gridSize)      / gridSize, 2, 2, gridSize) );      println("LINE CREATED");      break;
                case 4: railItems.add( new Detection(0,(width - 2 * gridSize)      / gridSize, 4, 2, gridSize) );      println("DETECTOR CREATED");  break;
                case 3: railItems.add( new Curve(      (width - 2 * gridSize)      / gridSize, 3, 2, gridSize) );      println("CURVE CREATED");     break;
                case 5: railItems.add( new Memory(   0,(width-gridSize-edgeOffset) / gridSize, 5, 0, gridSize) );      println("MEMORY CREATED");    break;
                case 6: railItems.add( new Decoupler(0,(width-gridSize-edgeOffset) / gridSize, 6, 0, gridSize) );      println("DECOUPLER CREATED"); break;
                case 7: railItems.add( new Signal(   0,(width-gridSize-edgeOffset) / gridSize, 7, 0, gridSize,0));     println("SIGNAL CREATED");    break;
            }
            index = railItems.size() - 1;
        }
    }
}
      

void mouseDragged()
{
    if(locked && mode == movingItem) 
    {
        RailItem anyClass = railItems.get(index);
        column = constrain( column, 0, 63 );
        row = constrain( row, 0, 31 );
        anyClass.setPos(column,row);            // update positon of selected object
    }
}



void mouseReleased()
{
    locked = false;

    if(mode == deletingItem)
    {
        if( railItems.size() > 0 && index < railItems.size() ) // N.B. TODO. if you click on empty space you will delete elements from the railItem list. a coordinate check is needed
        {
            railItems.remove(index);		// DELETE THE OBJECT
        }
    }
}


void keyPressed()
{
    switch (key)
    {
        case 'm':case 'M': display.printAt(0,0,       "MOVING ITEM"); display.clearToEnd(); mode = movingItem; break;
        case 'd':case 'D': display.printAt(0,0,     "DELETING ITEM"); display.clearToEnd(); mode = deletingItem; break;
        case 'n':case 'N': display.printAt(0,0,        "SETTING ID"); display.clearToEnd(); mode = settingID ; break;
        case 'i':case 'I': display.printAt(0,0, "SETTING INPUT PIN"); display.clearToEnd(); mode = settingInputPin; break;
        case 'o':case 'O': display.printAt(0,0,"SETTING OUTPUT PIN"); display.clearToEnd(); mode = settingOutputPin; break;
        case 't':case 'T': display.printAt(0,0,    "CHANGE IO TYPE"); display.clearToEnd(); mode = settingType; break ;
        
        default: // all other caracters

        if (keyCode == ENTER) number = 0 ;
        else number = makeNumber(number,0,255);


        switch(mode) 
        {
            case settingID:         display.setCursor( 7, 3 );  display.printNumber( number ); display.clearToEnd(); break ; // TODO, formed number should be directly updated
            case settingInputPin:   display.setCursor( 7, 4 );  display.printNumber( number ); display.clearToEnd(); break ;
            case settingOutputPin:  display.setCursor( 7, 5 );  display.printNumber( number ); display.clearToEnd(); break ;
            case movingItem:
            if( locked == true ) 
            {
                RailItem anyClass = railItems.get(index);
                if(keyCode == LEFT )	anyClass.turnLeft();											 // ROTATE THE OBJECT CCW		
                if(keyCode == RIGHT)	anyClass.turnRight();											// ROTATE THE OBJECT CW
                
                if(index > railItems.size()) index = railItems.size();
            } else 
            {
                for (int i = 0; i < railItems.size(); i++) 
                {																	// move all objects
                    int Xoffset=0, Yoffset=0;
                    RailItem anyClass = railItems.get(i); 
                    
                    if(keyCode == DOWN ) Yoffset = +1 ;
                    if(keyCode == UP)	 Yoffset = -1 ;
                    if(keyCode == LEFT ) Xoffset = -1 ;
                    if(keyCode == RIGHT) Xoffset = +1 ; 
                    anyClass.setPos(anyClass.getColumn() + Xoffset, anyClass.getRow() + Yoffset);
                } 
            }
            break;
        }
        break ;
    }
}

int makeNumber(int _number, int lowerLimit, int upperLimit)
{
    if(keyCode == BACKSPACE) _number /= 10;
    else if(key >= '0' && key <= '9')
    {
        if(number<100)_number *= 10;
        _number += (key-'0');
        _number = constrain(_number,lowerLimit,upperLimit);
    }
    println(_number);
    return _number;
}


// loading and store functions
void saveLayout() 
{
    println("layout saved");
    output = createWriter("layout.csv");
    output.println(railItems.size());
    for (int i = 0; i < railItems.size(); i++) 
    {
        RailItem anyClass = railItems.get(i);
        if(anyClass instanceof Switch)		output.println(anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn() + "," + anyClass.getRow() + "," + anyClass.getDirection() + ","  + anyClass.getType()+ ","); 
        if(anyClass instanceof Line)		output.println(anyClass.getItem() + ","	+ 0	                + "," + anyClass.getColumn() + "," + anyClass.getRow() + "," + anyClass.getDirection() + "," ) ; 
        if(anyClass instanceof Curve)		output.println(anyClass.getItem() + ","	+ 0                 + "," + anyClass.getColumn() + "," + anyClass.getRow() + "," + anyClass.getDirection() + "," ) ;
        if(anyClass instanceof Signal)      output.println(anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn() + "," + anyClass.getRow() + "," + anyClass.getDirection() + "," ) ; 
        if(anyClass instanceof Decoupler)	output.println(anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn() + "," + anyClass.getRow() + "," + anyClass.getDirection() + "," ) ;
        if(anyClass instanceof Memory)	    output.println(anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn() + "," + anyClass.getRow() + "," + anyClass.getDirection() + "," ) ; 
        if(anyClass instanceof Detection) 	output.println(anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn() + "," + anyClass.getRow() + "," + anyClass.getDirection() + "," ) ;
    }
    output.close();
    display.printAt(0,0, "LAYOUT SAVED"); display.clearToEnd();
}

String line ;
void loadLayout()
{
    println("layout loaded");
    input = createReader("layout.csv");
    try
    {
        line = input.readLine();
    } 
    catch (IOException e) {}
    
    int size = Integer.parseInt(line);
    
    for(int j=0; j<size; j++) {
        try 
        {
            line = input.readLine();
        } 
        catch (IOException e) 
        {
            line = null;
        }
        if (line == null) 
        {
            // Stop reading because of an error or file is empty
            //noLoop();	
        } 
        else 
        {
            String[] pieces = split(line, ',');
            int item        = Integer.parseInt( pieces[0] );	 // holds the type+
            int ID          = Integer.parseInt( pieces[1] );
            int column      = Integer.parseInt( pieces[2] );
            int row         = Integer.parseInt( pieces[3] );
            int direction   = Integer.parseInt( pieces[4] );
            
            switch(item)
            {
                case 1: // switch
                int type = Integer.parseInt(pieces[5]); // determen left or right switch
                        railItems.add( new Switch(   ID, column, row, direction, gridSize, type) ); break;
                case 2: railItems.add( new Line(         column, row, direction, gridSize ) );    break;
                case 3: railItems.add( new Curve(        column, row, direction, gridSize ) );    break;
                case 4: railItems.add( new Detection(ID, column, row, direction, gridSize ) );    RailItem  anyClass = railItems.get(j); break;
                case 5: railItems.add( new Memory	(ID, column, row, direction, gridSize ) );    RailItem anyClass2 = railItems.get(j); break;
                case 6: railItems.add(new Decoupler( ID, column, row, direction, gridSize ) );    break;
                case 7: railItems.add(new Signal(    ID, column, row, direction, gridSize, 1) );  break;
            }
        }
    } 
}
