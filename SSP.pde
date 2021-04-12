class SSP {
	//Timer t = new Timer();

	String[] commands;
	String command;
	int Ncommands, counter = 0;
	boolean entryState = false;
	
	final int tra = 1; 
	final int mem = 2; 
	final int det = 3; 
	final int dly = 4; 
	final int ret = 5; 
	
	SSP(String fileName) {
		commands = loadStrings(fileName);
		Ncommands = commands.length; }
		
	void runCommands(){
		command = commands[counter].substring(0, 3);
		switch(command) {
			case "tra": if(traF()==1) nextSSP(); break;			
			case "mem": if(memF()==1) nextSSP(); break;
			case "det": if(detF()==1) nextSSP(); break;
			case "dly": if(dlyF()==1) nextSSP(); break;
			case "ret": if(retF()==1) nextSSP(); break; } }
	
	byte traF() {
		if(entryState == true) {
			entryState = false;
			
			} 
		return 1;}
		
	byte memF() {
		if(entryState == true) {
			entryState = false;
			}
		return 1;}
	
	byte detF() {
		int param1;
		if(entryState == true) {
			entryState = false;
			param1 = Integer.parseInt(commands[counter].substring(3, 5));} // get ID of detector
  return 1;
		//if(detector[param1] == true) return 1;
		//else								  return 0; }
}
	
	byte dlyF() {
		int param1;
		if(entryState == true) {
			entryState = false;
			param1 = Integer.parseInt(commands[counter].substring(3, 5));}
			//t.setTime(param1);} // get delay time
		//if(t.getTime() == 0) {
		//	return 1; }
	//	else {
			return 0; } //}
	
	byte retF() {
		counter = 0;
		return 1; }
		
	void nextSSP() {
		counter++;
		entryState = true; } 

	void setDetectors() {

	} }

 //for (int i = 0 ; i < lines.length; i++) {
	//	println(lines[i]); } } }
	 
