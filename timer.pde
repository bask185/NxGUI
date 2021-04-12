//class Timer {
//	boolean prevTimer = false;

//	Timer() {}		// constructor

//	void updateTime() {
//		if(prevTimer == false && (millis() & 1024) {
//			prevTimer = true;
//			if(secondTimer > 0) secondTimer--; }
//		else if(prevTimer == true && (millis() & ~1024) {
//			prevTimer = false;
//			if(secondTimer > 0) secondTimer--; } }

//	byte getTime() {
//		return secondTimer;	}

//	void setTime(int maxTime) {
//		secondTimer = constrain(maxTime,0,99);	} }
