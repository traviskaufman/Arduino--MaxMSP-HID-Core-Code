/**********************************************************
* FINAL PROJECT CODE                                      *
***********************************************************/
//=======================================
// MAKE SURE ALL PP DEFS ARE UP TO DATE!
//=======================================
// Globals for the digital input pins
#define ENABLE_1 2
#define ENABLE_2 3
#define ENABLE_3 4
#define ENABLE_4 5
#define ENABLE_5 6
#define ENABLE_6 7
#define ENABLE_7 8 
#define ENABLE_8 9
// Globals for the analog input pins and selector switch
#define SELECTOR_SWITCH 10
#define UPDATE_POT 0
#define SELECTOR_POT 1
#define SCALE 1
#define BEATVALUE 3
// Additional Utility Pins
#define VOICE_PIN 11
#define PARAM_PIN 12
#define STATUS_LED 13 // Same as Arduino LED
// Some additional constants
#define MIN_VOLTAGE 0
#define MAX_VOLTAGE 1023 // Assumed 5V 
// MaxMSP Patch Metadata, added for easy future implementation changes.
#define VOICEDIV 16
#define SCALEDIV 6
#define BEATDIV 9
#define PARAMDIV 25


// Because these are more likely to change, and as not to clash with define, the number of params/toggles with be declared as constant variables
const int onOffSwitches_amt = 8;
// Global arrays that serve as universal memory addresses for references to each of the input pins
static int on_off_switches[onOffSwitches_amt] = {ENABLE_1, ENABLE_2, ENABLE_3, ENABLE_4, ENABLE_5, ENABLE_6, ENABLE_7, ENABLE_8};

void setup() {
  int i = 0;
  // set up two utility pins
  pinMode(STATUS_LED, OUTPUT);
  pinMode(VOICE_PIN, OUTPUT);
  pinMode(PARAM_PIN, OUTPUT);
  digitalWrite(VOICE_PIN, LOW);
  digitalWrite(PARAM_PIN, LOW);
  // clear any stray logic 
  for (i = ENABLE_1; i < ENABLE_8; i++) {
    digitalWrite(i, LOW);
    pinMode(i, INPUT);  
  }
  for (i = 0; i < 5; i++) {
    pinMode(i, INPUT);
  }
  Serial.begin(9600);
  for (int i = 0; i < 3; i++) {  
    digitalWrite(STATUS_LED, HIGH);
    delay(125);
    digitalWrite(STATUS_LED, LOW);
    delay(125);
  }
  digitalWrite(STATUS_LED, HIGH);
}

int enableState;
int voice = 1;
int param = 0; // Choose scale


void loop() {
  int uPotVal = analogRead(UPDATE_POT);
  int i = ENABLE_1;
  int whatToSelect = (digitalRead(SELECTOR_SWITCH) == HIGH) ? 1 : 0; // HIGH = Voice, Low = Param
  updateSelectorLEDs(whatToSelect);
  // Toggle different patch voices
  for (; i <= ENABLE_8; i++) {
    enableState = digitalRead(on_off_switches[i-2]);
    if (enableState == HIGH)
      ToggleVoice(on_off_switches[i-2], 1);
    else
      ToggleVoice(on_off_switches[i-2], 0);
    delay(10);
  }
  // Select either a new voice to update or a new parameter
  if (whatToSelect)
    voice = vSplitChoose(MIDIMap(analogRead(SELECTOR_POT)), VOICEDIV);
  else
    param = vSplitChoose(MIDIMap(analogRead(SELECTOR_POT)), PARAMDIV);   
  // Update the chosen voice with the chosen parameter
  if (hasChanged(UPDATE_POT, uPotVal)) {
    if (param == SCALE)
      updatePatchParams(voice, param, (MIDIMap(analogRead(UPDATE_POT)))/SCALEDIV);
    else if (param == BEATVALUE)
      updatePatchParams(voice, param, (MIDIMap(analogRead(UPDATE_POT)))/BEATDIV);
    else
      updatePatchParams(voice, param, MIDIMap(analogRead(UPDATE_POT)));
    delay(10);
  }
}

int MIDIMap(int inVar) {
  return map(inVar, 0, 1023, 0, 127);
}

void ToggleVoice(const int pin, const short unsigned int state) {
  Serial.print(255, BYTE); // NOTE: 255 denotes enable pins
  Serial.print(pin, BYTE);
  Serial.print(state, BYTE);
}

int vSplitChoose(const int inVal, const int split) {
  return inVal/split + 1; // returns anywhere from 1 - 8 for voices, 1 - 4 for params
}

void updatePatchParams(const int inVoice, const int inParamID, const int inValue) { // Update inParamID to the value of inValue at the selected inVoice in the patch
  Serial.print(inVoice, BYTE);
  Serial.print(inParamID, BYTE);
  Serial.print(inValue, BYTE);
}

void updateSelectorLEDs(int inSelector) {
  if (inSelector) {
    digitalWrite(VOICE_PIN, HIGH);
    digitalWrite(PARAM_PIN, LOW);
  }
  else {
    digitalWrite(VOICE_PIN, LOW);
    digitalWrite(PARAM_PIN, HIGH);
  }
}

boolean hasChanged(const int inVal, const int inRef) {
  return ((analogRead(inVal) < (inRef - 2)) || (analogRead(inVal) > (inRef + 2))) ? true : false; // ±2 used so that the program will disregard slight changes
}
