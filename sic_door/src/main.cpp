#include <Arduino.h>
#include <SPI.h>
#include <MFRC522.h>
#include "Stepper.h"

#define SS_PIN 10
#define RST_PIN 9

MFRC522 rfid(SS_PIN, RST_PIN);

byte uidPICC[4];

const int stepsPerRevolution = 512;
Stepper myStepper = Stepper(stepsPerRevolution, 2, 5, 3, 6);

void setup() { 
  Serial.begin(9600);
  SPI.begin();
  rfid.PCD_Init();
}

void loop() {
  if ( ! rfid.PICC_IsNewCardPresent())
    return;

  if ( ! rfid.PICC_ReadCardSerial())
    return;

  for (byte i = 0; i < 4; i++) {
    uidPICC[i] = rfid.uid.uidByte[i];
  }
  
  if (uidPICC[0] == 151 && uidPICC[1] == 87 && uidPICC[2] == 131 && uidPICC[3] == 75)
  {
    Serial.println("True");
    
    myStepper.setSpeed(50);
    myStepper.step(stepsPerRevolution*2);
    delay(5000);

  myStepper.setSpeed(50);
    myStepper.step(-stepsPerRevolution*2);
    delay(5000);
  }
  else
  {
    Serial.println("False");
  }
  rfid.PICC_HaltA();
  
  rfid.PCD_StopCrypto1();
}

void printHex(byte *buffer, byte bufferSize) {
  for (byte i = 0; i < bufferSize; i++) {
    Serial.print(buffer[i] < 0x10 ? " 0" : " ");
    Serial.print(buffer[i], HEX);
  }
}

void printDec(byte *buffer, byte bufferSize) {
  for (byte i = 0; i < bufferSize; i++) {
    Serial.print(' ');
    Serial.print(buffer[i], DEC);
  }
}

/* 
  Example sketch to control a 28BYJ-48 stepper motor 
  with ULN2003 driver board and Arduino UNO. 
  More info: https://www.makerguides.com 
*/

// Include the Arduino Stepper.h library:
// #include <Arduino.h>
// #include "Stepper.h"
// #include <SPI.h>

// // Define number of steps per rotation:
// const int stepsPerRevolution = 2048;

// // Wiring:
// // Pin 8 to IN1 on the ULN2003 driver
// // Pin 9 to IN2 on the ULN2003 driver
// // Pin 10 to IN3 on the ULN2003 driver
// // Pin 11 to IN4 on the ULN2003 driver

// // Create stepper object called 'myStepper', note the pin order:
// Stepper myStepper = Stepper(stepsPerRevolution, 2, 5, 3, 6);

// void setup() {
//   // Set the speed to 5 rpm:
//   myStepper.setSpeed(5);
  
//   // Begin Serial communication at a baud rate of 9600:
//   Serial.begin(9600);
// }

// void loop() {
//   // Step one revolution in one direction:
//   Serial.println("clockwise");
//   myStepper.step(stepsPerRevolution);
//   delay(500);
  
//   // Step one revolution in the other direction:
//   Serial.println("counterclockwise");
//   myStepper.step(-stepsPerRevolution);
//   delay(500);
// }