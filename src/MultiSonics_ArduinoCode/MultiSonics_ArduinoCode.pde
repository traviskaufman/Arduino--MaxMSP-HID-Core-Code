/**********************************************************
* FINAL PROJECT CODE                                      *
***********************************************************/
// Globals for the digital input pins
#define ENABLE_1 0
#define ENABLE_2 1
#define ENABLE_3 2
#define ENABLE_4 3
#define ENABLE_5 4
#define ENABLE_6 5
#define ENABLE_7 6 
#define ENABLE_8 7
// Globals for the analog input pins
#define SCALE_POT 0
#define ROOTNOTE_POT 1
#define BEATVALUE_POT 2
#define INTRVLSIZE_POT 3
#define NOTELNGTH_POT 4
#define DYNRNG1_POT 5
#define DYNRNG2_POT 6
// Additional Utility Pins
#define CLEAR_PIN 10 // digital pin that clears all the FFs 
#define STATUS_LED 13 // Same as Arduino LED
// Some additional constants
#define MIN_VOLTAGE 0
#define MAX_VOLTAGE 1023 // Assumed 5V input

// Because these are more likely to change, and as not to clash with define, the number of params/toggles with be declared as constant variables
const int onOffSwitches_amt = 8;
const int params_amt = 7;
// Global arrays that serve as universal memory addresses for references to each of the input pins
static int on_off_switches[onOffSwitches_amt] = {ENABLE_1, ENABLE_2, ENABLE_3, ENABLE_4, ENABLE_5, ENABLE_6, ENABLE_7, ENABLE_8};
static int params[params_amt] = {SCALE_POT, ROOTNOTE_POT, BEATVALUE_POT, INTRVLSIZE_POT, NOTELNGTH_POT, DYNRNG1_POT, DYNRNG2_POT};

void setup() {
  int i = ENABLE_1;
  // set up two utility pins
  pinMode(STATUS_LED, OUTPUT);
  pinMode(CLEAR_PIN, OUTPUT);
  // clear any stray logic 
  for (; i < onOffSwitches_amt; i++) {
    digitalWrite(i, LOW);
    pinMode(i, INPUT);
  }
  for (i = 0; i < params_amt; i++) {
    pinMode(i, INPUT);
  }
  Serial.begin(9600);
}
 
void loop() {
   // remap everything from 0 - 1023 into 0 - 127
   // declare variables that read stuff from all pins
   // send them to appropriate functions
 }
 
void ToggleVoice(int pin, bool state) {
  // write to serial 
}

// Write rest of functions...I'm going the fuck to sleep now

