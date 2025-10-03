#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
unsigned long dfg;
int ar[5] = {9278,48735,65,12,34};
int parametr [17] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
RF24 radio(9, 10);  // указать номера пинов, куда подключаются CE и CSN
const byte rxAddr[6] = "00001"; // адрес
const byte txAddr[6] = "00011";  // адрес
int count = 0;
int count1 = 0;
int ends = 0;
int tarnsmitt[5];
int yr = 0;
int couter = 0;
int hu = 0;
int indclr=0;
int text[8]={0,0,0,0,0,0,0,0};
#include<Wire.h>
void setup()
{
  Wire.begin(8);
  radio.begin();
  Wire.onReceive(receiveEvent);
  radio.openReadingPipe(0, rxAddr);
  radio.openWritingPipe(txAddr); 
  radio.startListening();
  Serial.begin(9600);
}

void loop()
{
sendArray();
  
  if (radio.available())
  {
   
    radio.read(&text, sizeof(text));   
   //Serial.println(text[0]);
  }
  while(couter<8){
    Serial.print(text[couter]);
    Serial.print(",");
    couter++;
  }
  couter = 0;
  Serial.println();
  //Serial.print(" ");

   /* while(yr <5){
      ar[0] = ar[0] + tarnsmitt[yr] *10 ^(4-yr);
      yr++;
    }
    yr = 0;
    /*
     * 
     */
    // ar[0] = tarnsmitt[0] *10000 +tarnsmitt[1] *1000+tarnsmitt[2] *100+tarnsmitt[3] *10 +tarnsmitt[4];
//    Serial.println(ar[0]);
    //Serial.println();


  radio.stopListening();
  radio.write(&parametr, sizeof(parametr));
  radio.startListening();  
delay(1);
 //ar[0] = 0;
}

void sendArray() {
      int myData[] = {10, 20, 30, 40, 50}; // Пример массива
      int arraySize = 8; // Размер массива

      Wire.beginTransmission(8); // Начните передачу данных на ведомое устройство с адресом 0x08
      for (int i = 0; i < arraySize; i++) {

        Wire.write((text[i] >> 8) & 0xFF);
        Wire.write(text[i] & 0xFF);
       // Wire.write(ar[i]); // Отправка каждого байта массива
      }
      Wire.endTransmission(); // Завершите передачу данных
}

    void receiveEvent(int howMany) {

      // Если это конец массива, считайте последний байт
      while (Wire.available()) {
  byte msb = Wire.read();
  // Читаем младший байт
  byte lsb = Wire.read();
  
  // Собираем число
  int receivedNumber = (msb << 8) | lsb;
        parametr[count1] =  receivedNumber ;
        count1++;
       // Serial.print();
      }
      count1= 0;
      //Serial.println(); // Перенос строки для лучшей читаемости
    }
