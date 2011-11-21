void setup() {
  pinMode(0, INPUT);
  Serial.begin(9600);
}
int x = LOW;
void loop() {
  /*x = digitalRead(0);
  if (x == HIGH)
    Serial.println(1);
  else
    Serial.println(0);*/
  x = analogRead(5);
  Serial.println(x);
}
