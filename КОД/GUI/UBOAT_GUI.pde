PShape rocket;
import controlP5.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.serial.*;
Serial myPort;  // Create object from Serial class
ControlP5 cp5;
Capture video;
OpenCV opencv;

int REV1 = 1, REV2 = 1;
int ARM_1 = 1, ARM_2 = 1;
int THROTTLE_1 = 0, THROTTLE_2 = 0;
String cm ;
String [] lm = {"101","102","103","104"}  ;
int y = 0;
int LIGHT = 1;
int AUTOPILOT = 1;
int time = 0;

String [] arms1 = {"M1 DISARMED","M1 ARMED"} ;
String [] arms2 = {"M2 DISARMED","M2 ARMED"} ;


String [] rever1 = {"M1 NON REVERSED","M1 REVERSED"} ;
String [] rever2 = {"M2 NON REVERSED","M2 REVERSED"} ;

String [] ap = {"AP DISABLED","AP ENABLED"} ;

String portName;
String textValue = "";
long a;
void setup() {
   String[] cameras = Capture.list();


   
  video = new Capture(this, 640, 480);
    video = new Capture(this, cameras[0]);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
background(0);
  video.start();
  size(1060,600);
  noStroke();
  cp5 = new ControlP5(this);

  // create a new button with name 'buttonA'
  cp5.addButton("FILL_BALLAST")
     .setValue(0)
     .setPosition(640,0)
     .setSize(200,60)
     ;
  
  // and add another 2 buttons
  cp5.addButton("DRAIN_BALLAST")
     .setValue(100)
     .setPosition(840,0)
     .setSize(200,60)
     ;
     
  cp5.addButton("BALLAST_LEFT")
     .setValue(0)
     .setPosition(640,70)
     .setSize(200,60)
     ;
  
  // and add another 2 buttons
  cp5.addButton("BALLAST_RIGHT")
     .setValue(100)
     .setPosition(840,70)
     .setSize(200,60)
     ;

       cp5.addToggle("LIGHT")
     .setPosition(640,140)
     .setSize(420,60)
     .setValue(false)
     //.setMode(ControlP5.SWITCH)
     ;
       cp5.addToggle("ARM_M1")
     .setPosition(640,230)
     .setSize(200,60)
     .setValue(false)
   //  .setMode(ControlP5.SWITCH)
     ;
       cp5.addToggle("ARM_M2")
     .setPosition(850,230)
     .setSize(200,60)
     .setValue(false)
 //    .setMode(ControlP5.SWITCH)
     ;
     
       cp5.addSlider("THROTTLE_1")
     .setPosition(640,310)
     .setSize(200,20)
     .setRange(0,255)
     .setValue(0)
     ;
     
            cp5.addToggle("REVERS_M1")
     .setPosition(900,310)
     .setSize(70,20)
     .setValue(false)
   //  .setMode(ControlP5.SWITCH)
     ;
     
       cp5.addSlider("THROTTLE_2")
      .setPosition(640,360)
     .setSize(200,19)
     .setRange(0,255)
     .setValue(0)
     ;
            cp5.addToggle("REVERS_M2")
     .setPosition(900,360)
     .setSize(70,19)
     .setValue(false)
   //  .setMode(ControlP5.SWITCH)
     ;
            cp5.addToggle("AUTOPILOT")
     .setPosition(640,400)
     .setSize(420,60)
     .setValue(false)
 //    .setMode(ControlP5.SWITCH)
     ;
     
            cp5.addSlider("AP_TIME_SEC")
      .setPosition(640,480)
     .setSize(200,20)
     .setRange(0,600)
     .setValue(0)
     ;
            cp5.addSlider("STEER_ANGLE_DEG")
      .setPosition(640,510)
     .setSize(200,20)
     .setRange(0,600)
     .setValue(0)
     ;
      portName = "COM5";
    myPort = new Serial(this, portName, 9600);
myPort.write("1");
}
void draw() { 
String val;
if(millis() - a > 2000){
        myPort.write(lm[y]);
        y++;
  a = millis();
}
if(y>3){
  y = 0;
}

  if( ARM_1 == 1){
     lm[1] = str(THROTTLE_1 * 100 + 2);
  }
  else{
    lm[1] = "2";
  }
  if( ARM_2 == 1){
      lm[2] = str(THROTTLE_2 * 100 + 3);
  }
  else{
    lm[2] = "3";
  }




lm[3] = str(time * 100 + 4);
  opencv.loadImage(video);

  image(video, 0, 0 );


}



// function colorC will receive changes from 
// controller with name colorC
void captureEvent(Capture c) {
  c.read();
}
public void controlEvent(ControlEvent theEvent) {  
 //  myPort.write(cm);
  

}
public void FILL_BALLAST(int theValue) {
lm[0] = "101";
}

public void DRAIN_BALLAST(int theValue) {
lm[0] = "201";
}

public void BALLAST_LEFT(int theValue) {
lm[0] = "301";
}

public void BALLAST_RIGHT(int theValue) {
lm[0] = "401";  
}

void THROTTLE_1(float gas1) {
  if( ARM_1 == 1){
      THROTTLE_1 = int(gas1);

  }

}
void THROTTLE_2(float gas2) {
  if( ARM_2 == 1){
      THROTTLE_2 = int(gas2);

  }

}
void LIGHT(boolean lght) {
   LIGHT ++;
   if( LIGHT > 1){
      LIGHT  = 0;
   }
   
 if(LIGHT == 0){
   lm[0] = "501";
   
 }
 else{
    lm[0] = "601";
 }


}

void ARM_M1(boolean arm_1) {
   ARM_1 ++;
   if( ARM_1 > 1){
      ARM_1  = 0;
   }
}


void ARM_M2(boolean arm_2) {
   ARM_2 ++;
   if( ARM_2 > 1){
      ARM_2  = 0;
   }
}



void REVERS_M1(boolean rv_1) {
   REV1 ++;
   if( REV1 > 1){
      REV1  = 0;
   }
   if(REV1 == 0){
     lm[0] = "701";
   }
   else{
     lm[0] = "801";
   }
}
void REVERS_M2(boolean rv_2) {
   REV2 ++;
   if( REV2 > 1){
      REV2  = 0;
   }
   if(REV2 == 0){
     lm[0] = "901";
   }
   else{
     lm[0] = "1001";
   }
}



void AUTOPILOT(boolean apr) {
   AUTOPILOT ++;
   if( AUTOPILOT > 1){
      AUTOPILOT  = 0;
   }
   if(AUTOPILOT == 0){
     lm[0] = "1101";
   }
   else{
     lm[0] = "1201";
   }
 
}
void AP_TIME_SEC (float tm) {
  
      time= int(tm);
      //  println(time );


}
