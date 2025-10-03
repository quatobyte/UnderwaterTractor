// Wire Slave Receiver
// by Nicholas Zambetti <http://www.zambetti.com>

// Demonstrates use of the Wire library
// Receives data as an I2C/TWI slave device
// Refer to the "Wire Master Writer" example for use with this

// Created 29 March 2006

// This example code is in the public domain.


#include <Wire.h>
unsigned long a;
int fn [8] = {0,0,0,0,0,0,0,0};
int parametrs [17] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
int count = 0;
int shower = 0;
void setup() {
  Wire.begin(8);                // join I2C bus with address #8
   Wire.onReceive(receiveEvent);// register event
  Serial.begin(9600);           // start serial for output
}

void loop() {  
  sendArray();
  while(shower < 8){
   Serial.print (fn[shower]);
  Serial.print (",");
    shower ++;
  }
  shower = 0;
   Serial.println ("");
}

// function that executes whenever data is received from master
// this function is registered as an event, see setup()
    void receiveEvent(int howMany) {

      // Если это конец массива, считайте последний байт
      while (Wire.available()) {
  byte msb = Wire.read();
  // Читаем младший байт
  byte lsb = Wire.read();
  
  // Собираем число
  int receivedNumber = (msb << 8) | lsb;
        fn[count] =  receivedNumber ;
        count++;
       // Serial.print();
      }
      count= 0;
      //Serial.println(); // Перенос строки для лучшей читаемости
    }


    void sendArray() {
     
      int arraySize = 17; // Размер массива

      Wire.beginTransmission(8); // Начните передачу данных на ведомое устройство с адресом 0x08
      for (int i = 0; i < arraySize; i++) {

        Wire.write(( parametrs[i] >> 8) & 0xFF);
        Wire.write( parametrs[i] & 0xFF);
       // Wire.write(ar[i]); // Отправка каждого байта массива
      }
      Wire.endTransmission(); // Завершите передачу данных
}
