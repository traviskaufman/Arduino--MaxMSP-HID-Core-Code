void setup() {
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
  pinMode(11, INPUT);
  Serial.begin(9600);
}

void loop() {
  int inEnabled = (digitalRead(11) == HIGH) ? 1 : 0;
  if (inEnabled) {
    digitalWrite(12, HIGH);
    digitalWrite(13, LOW);
  }
  else {
    digitalWrite(12, LOW);
    digitalWrite(13, HIGH);
  }
  Serial.println(inEnabled);
}
