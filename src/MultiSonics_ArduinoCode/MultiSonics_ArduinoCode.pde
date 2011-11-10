/**********************************************************
* FINAL PROJECT CODE                                      *
***********************************************************/
// Globals for the digital input pins
#define ENABLE_1 2
#define ENABLE_2 3
#define ENABLE_3 4
#define ENABLE_4 5
#define ENABLE_5 6
#define ENABLE_6 7
#define ENABLE_7 8 
#define ENABLE_8 9
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

// Because these are more likely to change, and as not to clash with define, the number of params/toggles with be declared as constant variables
const int onOffSwitches_amt = 8;
const int params_amt = 7;
// Global arrays that serve as universal memory addresses for references to each of the input pins
static int on_off_switches[onOffSwitches_amt];
static int params[params_amt];

void setup() {
  pinMode(STATUS_LED, OUTPUT);
  int i = 0;
  // clear any stray logic 
  
  // although it takes a bit more processing, this is much more versatile than statically declaring the array
  for (; i <= onOffSwitches_amt; i++) 
    on_off_switches[i] = i;
  for (i = 0; i <= params_amt; i++) 
    params[i] = i;
  Serial.begin(9600);
}
 
void loop() {
   // declare variables that read stuff from all pins
   // send them to appropriate functions
 }
 
void ToggleVoice(int pin, bool state) {
  // write to serial 
}

// Write rest of functions...I'm going the fuck to sleep now

