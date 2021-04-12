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

boolean assignID_bool = false;
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
    
    gridSize = width / 64 - 2;
    gridSize = constrain(gridSize, 10, 50);

    textSize(gridSize/2);

    
    fullScreen();
    background(255);
    //fullScreen();

    sw1 = new Switch(	0,	(width-gridSize-edgeOffset) / gridSize, 0, 2, 1, gridSize, 1); // make default Objects to display on the right side of the UI
    sw2 = new Switch(	0,	(width-gridSize-edgeOffset) / gridSize, 1, 2, 2, gridSize, 1);
    l1 =  new Line(			(width-gridSize-edgeOffset) / gridSize, 2, 2,    gridSize);
    c1 =  new Curve(		(width-gridSize-edgeOffset) / gridSize, 3, 2,    gridSize);
    d1 =  new Detection(0,	(width-gridSize-edgeOffset) / gridSize, 4, 2,    gridSize);
    m1 =  new Memory(	0,	(width-gridSize-edgeOffset) / gridSize, 5, 2,    gridSize);
    D1 =  new Decoupler(0,	(width-gridSize-edgeOffset) / gridSize, 6, 2,    gridSize);
    S1 =  new Signal(   0,  (width-gridSize-edgeOffset) / gridSize, 7, 0,    gridSize, 0);

    loadLayout();

    display = new Display(gridSize*15, gridSize*33, gridSize*31, gridSize*32/3);
}

void draw() {
    textSize(gridSize /4);
    textAlign(CENTER,CENTER);
    fill(200);

    stroke(255);
    rect(0,0,width,height); // clear screen 
    stroke(0);
    
    column = (gridSize/2+constrain(mouseX,0,width-2*gridSize)) / gridSize - 1;
    row = (gridSize/2+constrain(mouseY,0,height-2*gridSize)) / gridSize - 1;
    
    drawGrid();						// draw items on the right
    
    sw1.Draw();
    sw2.Draw();
    l1.Draw();
    c1.Draw();
    d1.Draw();
    m1.Draw();
    D1.Draw();
    S1.Draw();
    
    for (int i = 0; i < railItems.size(); i++) {	
        RailItem anyClass = railItems.get(i);
        if(anyClass instanceof Switch) 	  { Switch sw = (Switch) anyClass; sw.Draw();}
        if(anyClass instanceof Detection) { Detection det = (Detection) anyClass; det.Draw();}
        if(anyClass instanceof Line) 	  { Line ln = (Line) anyClass; ln.Draw();}
        if(anyClass instanceof Curve) 	  { Curve cv = (Curve) anyClass; cv.Draw();}
        if(anyClass instanceof Memory) 	  { Memory mem = (Memory) anyClass; mem.Draw();}
        if(anyClass instanceof Decoupler) { Decoupler dec = (Decoupler) anyClass; dec.Draw();}
        if(anyClass instanceof Signal) 	  { Signal sig = (Signal) anyClass; sig.Draw();} }
    
    fill(0);
    textSize(gridSize/2 );
    textAlign(LEFT,CENTER);
    text("SAVE",gridSize, height - gridSize/2);
    text("<m>   = move items", gridSize, 34 * gridSize );
    text("<DEL> = delete items", gridSize, 35 * gridSize );
    text("<Esc> = quit program", gridSize, 36 * gridSize );
    display.paint();
}

void drawGrid() {
    fill(255);
    stroke(0);
    rect(1,1,65*gridSize-1, 33*gridSize-1);
    for(int i = 0 ; i < 64 ; i++ ){
        for(int j = 0 ; j < 32 ; j++ ){
            rect(gridSize+i*gridSize,gridSize+j*gridSize,1,1);
        } 
    } 
}


void mousePressed()
{	
    if(mouseX < width / 2 && mouseY > height - gridSize) saveLayout(); // works
    //if(mouseX > width / 2 && mouseY > height - gridSize) loadLayout(); // WORK IN PROGRESS
    RailItem anyClass = railItems.get(0);
    
    for (int i = 0; i < railItems.size(); i++) { 
        anyClass = railItems.get(i);																			// store the object in 'anyClass' 
        if(column == anyClass.getColumn() && row == anyClass.getRow()) {	// get index of clicked item	 
            locked = true;
            index = i;
            if(anyClass instanceof Switch) 		print("SWITCH ");
            if(anyClass instanceof Line)	 	print("LINE ");
            if(anyClass instanceof Curve) 		print("CURVE ");
            if(anyClass instanceof Memory) 		print("MEMORY ");
            if(anyClass instanceof Detection) 	print("DETECTOR ");
            if(anyClass instanceof Detection) 	print("DECOUPLER ");
            if(anyClass instanceof Signal) 		print("SIGNAL ");
            println("SELECTED");
            break;
        } 
    }
    
    switch(mode) {        
        case settingID:
        break;

        
        case movingItem:
        if(mouseX > (width-2*gridSize)) { 
            locked = true;
            println("new item created");
            switch(row) {
                case 0: railItems.add( new Switch(      0,(width-2*gridSize)/gridSize,0,2,left,gridSize, 1) );println("SWITCH CREATED");    break;
                case 1: railItems.add( new Switch(     0,(width-2*gridSize)/gridSize,0,2,right,gridSize, 1) );println("SWITCH CREATED");    break;
                case 2: railItems.add( new Line(                (width-2*gridSize)/gridSize,2, 2, gridSize) );println("LINE CREATED");      break;
                case 3: railItems.add( new Curve(              (width-2*gridSize)/gridSize, 3, 2, gridSize) );println("CURVE CREATED");     break;
                case 4: railItems.add( new Detection(        0,(width-2*gridSize)/gridSize, 4, 2, gridSize) );println("DETECTOR CREATED");  break;
                case 5: railItems.add( new Memory(   0,(width-gridSize-edgeOffset)/gridSize,5, 0, gridSize) );println("MEMORY CREATED");    break;
                case 6: railItems.add( new Decoupler(0,(width-gridSize-edgeOffset)/gridSize,6, 0, gridSize) );println("DECOUPLER CREATED"); break;
                case 7: railItems.add( new Signal(0,(width-gridSize-edgeOffset) / gridSize, 7, 0,gridSize,0));println("SIGNAL CREATED");   break;
            }
            index = railItems.size() - 1;
        }
        break;
        
        case deletingItem:
        break;
        }		
}

void setSwitches(RailItem anyClass) {
    Memory mem = (Memory) anyClass; 
    int tmp;
    int[] tmpSwitches = mem.getSwitches();
    int[] tmpStates = mem.getStates(); 
        
    for(int j=0;j<255;j++){																// cross reference any ID stored in the arrays of the memory object with switch IDs
        if(tmpSwitches[j] != 0) {																
            //println(tmpSwitches[j] + " " + tmpStates[j]);
            tmp = tmpSwitches[j];
            try{
                for(int k=0;k<255;k++) {
                    anyClass = railItems.get(k);									 // use anyClass to select all switches
                    if(tmp == anyClass.getID() && anyClass instanceof Switch) {		// compares the elements out if the array with all switches' IDs
                        
                        anyClass.setState(tmpStates[j]); } } }						 // set the state of the switch to the elements out of the array
            catch(IndexOutOfBoundsException e) {
            }
        }		 
    }
}

void setSignals(RailItem anyClass) {
    Detection det = (Detection) anyClass;
    int tmp;
    int[] tmpSignals = det.getSignals();
    int[] tmpStates  = det.getStates(); 

    for(int j = 0 ; j < 255 ; j++ ){								// cross reference any ID stored in the arrays of the memory object with switch IDs
        if(tmpSignals[j] != 0) {
            tmp = tmpSignals[j];
            try{
                for(int k = 0 ; k < 255 ; k++ ) {
                    anyClass = railItems.get(k);									// use anyClass to select all signals
                    if(tmp == anyClass.getID() && anyClass instanceof Signal) {		// compares the elements out if the array with all switches' IDs
                        
                        anyClass.setState(tmpStates[j]); } } }						// set the state of the switch to the elements out of the array
            catch(IndexOutOfBoundsException e) {
            }
        }		 
    }
}
            

void mouseDragged()
{
    if(locked && mode == movingItem) {
        RailItem anyClass = railItems.get(index);
        column = constrain( column, 0, 63 );
        row = constrain( row, 0, 31 );

        anyClass.setPos(column,row);
    }
}



void mouseReleased()
{
    switch(mode) {
        
        case movingItem:
        locked = false;
        break;
        
        case deletingItem:
        if(railItems.size()>0 && index < railItems.size())
            railItems.remove(index);		// DELETE THE OBJECT
        locked=false;
        break;
    }
}



void keyPressed()
{	
    switch (key){
        
    case 'm':
        display.printAt(0,0, "MOVING ITEM");
        display.clearToEnd();
        mode = movingItem;
        break;
    
    case DELETE:
        display.printAt(0,0, "DELETING ITEM");
        display.clearToEnd();
        mode = deletingItem;
        break;
        
        
    case 'n':
        mode = settingID;
        println("mode = NAME");
        assignID_bool = true;
        break;
    }
    
    switch(mode) {
        case settingID:
        if(keyCode == ENTER) {
            assignID_bool = false;
            RailItem anyClass = railItems.get(index);
            anyClass.setID(number);
            number = 0;
        }
        else {
            println("SETTING ID");
            print("CURRENT ID = ");
            number = makeNumber(number,0,255);
        }
        break;
        
        case movingItem:
        if(locked == true) {
            RailItem anyClass = railItems.get(index);
            if(keyCode == LEFT )	anyClass.turnLeft();											 // ROTATE THE OBJECT CCW		
            if(keyCode == RIGHT)	anyClass.turnRight();											// ROTATE THE OBJECT CW
            
            if(index > railItems.size()) index = railItems.size();
        }
        
        else {
            for (int i = 0; i < railItems.size(); i++) {																	// move all objects
                int Xoffset=0, Yoffset=0;
                RailItem anyClass = railItems.get(i); 
                
                //if(key == 'q') gridSize+=10; 
                //if(key == 'e') gridSize-=10;
                //anyClass.setGridSize(gridSize);
                
                if(keyCode == DOWN ) Yoffset = +1;
                if(keyCode == UP)	 Yoffset = -1;
                if(keyCode == LEFT ) Xoffset = -1;
                if(keyCode == RIGHT) Xoffset = +1; 
                anyClass.setPos(anyClass.getColumn() + Xoffset, anyClass.getRow() + Yoffset);
            } 
        }
        break;
        
        case deletingItem:
        break;
    }
}

int makeNumber(int _number, int lowerLimit, int upperLimit)
{
    if(keyCode == BACKSPACE) _number /= 10;
        else if(key >= '0' && key <= '9'){
            if(number<100)_number *= 10;
            _number += (key-'0');
            _number = constrain(_number,lowerLimit,upperLimit);
        }
        println(_number);
        return _number;
}



void saveLayout() {
    println("layout saved");
    output = createWriter("railItems.txt");
    output.println(railItems.size());
    for (int i = 0; i < railItems.size(); i++) {
        RailItem anyClass = railItems.get(i);
        if(anyClass instanceof Switch)		output.println(anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn()	+ "," + anyClass.getRow()+ "," + anyClass.getDirection() + "," + anyClass.getState() + "," + anyClass.getType()+ ","); 
        if(anyClass instanceof Line)		output.println(anyClass.getItem() + ","	+ 0	                + "," + anyClass.getColumn()	+ "," + anyClass.getRow()+ "," + anyClass.getDirection() + "," + anyClass.getState() + ","); 
        if(anyClass instanceof Curve)		output.println(anyClass.getItem() + ","	+ 0                 + "," + anyClass.getColumn()	+ "," + anyClass.getRow()+ "," + anyClass.getDirection() + "," + anyClass.getState() + ",");
        if(anyClass instanceof Signal)      output.println(anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn()	+ "," + anyClass.getRow()+ "," + anyClass.getDirection() + "," + anyClass.getState() + ","); 
        if(anyClass instanceof Decoupler)	output.println(anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn()	+ "," + anyClass.getRow()+ "," + anyClass.getDirection() + "," + anyClass.getState() + ",");
        if(anyClass instanceof Memory)	 {  output.print  (anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn()	+ "," + anyClass.getRow()+ "," + anyClass.getDirection() + "," + anyClass.getState() + ","); 
            Memory mem = (Memory) anyClass;
            int[] tmpSwitches = mem.getSwitches();
            int[] tmpStates = mem.getStates();
            for(int j=0;j<255;j++) {
                if(tmpSwitches[j]!=0) {	// if we have a switch
                    output.print(tmpSwitches[j] + "," + tmpStates[j] + ",");
                }
            }
            output.println();
        }
        if(anyClass instanceof Detection){	output.print(anyClass.getItem() + ","	+ anyClass.getID()  + "," + anyClass.getColumn()	+ "," + anyClass.getRow()+ "," + anyClass.getDirection() + "," + anyClass.getState() + ",");
            Detection det = (Detection) anyClass;
            int[] tmpSignals = det.getSignals();
            int[] tmpStates = det.getStates();
            for(int j=0;j<255;j++) {
                if(tmpSignals[j]!=0) {	// if we have a signal
                    output.print(tmpSignals[j] + "," + tmpStates[j] + ",");
                    println("signal" + tmpSignals[j] + " to " + tmpStates[j]);
                }
            }
            output.println();
        }
    }
    output.close();
}
String line ;
void loadLayout()
{
    println("layout loaded");
    input = createReader("railItems.txt");
    
    try{
        line = input.readLine();
    } 
    catch (IOException e) {}
    
    int size = Integer.parseInt(line);
    
    for(int j=0; j<size; j++) {
        try {
            line = input.readLine();
        } 
        catch (IOException e) {
            line = null;
        }
        
        if (line == null) {
            // Stop reading because of an error or file is empty
            //noLoop();	
        } 
        else {
            String[] pieces = split(line, ',');
            //println();
            int item = Integer.parseInt(pieces[0]);	 // holds the type+
            int ID = Integer.parseInt(pieces[1]);
            int column = Integer.parseInt(pieces[2]);
            int row = Integer.parseInt(pieces[3]);
            int direction = Integer.parseInt(pieces[4]);
            //int state;
            state = Integer.parseInt(pieces[5]); 
            //print(pieces[4] + " ");
            
            /*for(int i=0;i<pieces.length;i++){
                print(pieces[i] + " ");
            }
            println();*/
            
            switch(item){

                case 1: // switch
                int type = Integer.parseInt(pieces[6]);
                railItems.add( new Switch(ID,column,row,direction,type,gridSize,state) );
                break;

                case 2: // line
                railItems.add( new Line(column,row,direction,gridSize) );
                break;

                case 3: // curve
                railItems.add( new Curve(column,row,direction,gridSize) );
                break;

                case 4: // detector
                railItems.add( new Detection(ID,column,row,direction,gridSize) );
                RailItem anyClass = railItems.get(j);
                break;

                case 5: // memory
                railItems.add( new Memory	(ID,column,row,direction,gridSize));
                RailItem anyClass2 = railItems.get(j);
                break; 
                
                case 6: // Decoupler
                railItems.add(new Decoupler(ID,column,row,direction,gridSize) );
                break;

                case 7: // Signal
                railItems.add(new Signal(ID,column,row,direction,gridSize, 1) );
                break;
            }
        }
    } 
}
