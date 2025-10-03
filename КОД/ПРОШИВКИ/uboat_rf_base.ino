#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
int priyom[17]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
int in [2] = {0,0}; 
String test=" " ; 
int parametr[8] = {0,0,0,0,0,0,0,0};
int finder = 0;
int techpar = 0;
int showparametr = 0;
unsigned long mode  = 0;
RF24 radio(9, 10); // CE and CSN
const byte txAddr[6] = "00001";  // адрес
const byte rxAddr[6] = "00011";  // адрес
void setup()
{
  delay(500);
  radio.begin();
  radio.setRetries(15, 15);
  radio.openWritingPipe(txAddr);  
  radio.openReadingPipe(0,rxAddr);  
  Serial.begin(9600);
}

void loop()
{


  radio.stopListening();  
  int text[1];
  if(Serial.available()){
  mode= Serial.parseInt();
  in[0] = mode%100;
  in[1] = mode/100;
  }
techpar = in[0];
parametr[techpar] = in[1];
while(showparametr < 8){
Serial.print ( parametr [showparametr]);
Serial.print (",");
  showparametr++;
}
showparametr=0;
Serial.print ("//////////////");
while(showparametr < 17){
Serial.print (priyom[showparametr]);
Serial.print (",");
  showparametr++;
}
  showparametr=0;
 // Serial.print(in[0]);
  Serial.println("");
  //Serial.println(in[1]);
 radio.write(&parametr, sizeof(parametr));


       
  radio.startListening();
  while(radio.available()){
    radio.read(&priyom, sizeof(priyom));
   // Serial.print(ghr[0]); 
  }
  delay(1);
}
