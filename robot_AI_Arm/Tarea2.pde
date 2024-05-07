import java.util.ArrayList;
import java.util.List;
import processing.core.PApplet;
PShape base, shoulder, upArm, loArm, end;
float rotX, rotY;
float posX=1, posY=50, posZ=50;
float alpha, beta, gamma;
float F = 50;
float T = 70;
float time;
float millisOld, gTime, gSpeed = 4;
int timeBetweenLetters = 1000;
long lastChangeTime;
int counter = 0;
String secondPart = "";
String str ="";
void IK(){
  float X = posX;
  float Y = posY;
  float Z = posZ;

  float L = sqrt(Y*Y+X*X);
  float dia = sqrt(Z*Z+L*L);

  alpha = PI/2-(atan2(L, Z)+acos((T*T-F*F-dia*dia)/(-2*F*dia)));
  beta = -PI+acos((dia*dia-T*T-F*F)/(-2*F*T));
  gamma = atan2(Y, X);
}

void setTime(){
  gTime += ((float)millis()/1000 - millisOld)*(gSpeed/4);
  if(gTime >= 9)  gTime = 0;  
  millisOld = (float)millis()/1000;
}

List<String[]> readTextFile(String filename) {
  List<String[]> arrays = new ArrayList<>();
  String[] lines = loadStrings(filename);
  for (String line : lines) {
  String[] parts = line.split(" ");
  if (parts.length == 2) {
    arrays.add(parts);
   }
  }
  return arrays;
}

void letter_b(){
  IK();
  setTime();
  float time = 1.5;
  if(gTime >= 0 && gTime <= 2){
    posX = 0;
    posZ = ((-gTime)*10);
  }else if(gTime >=2 && gTime <=3){
    posX = ((-gTime+2)*10);
    posZ = -20;
  }else if(gTime >=3 && gTime <= 4){
    posX = -10;
    posZ = ((-gTime + 4)*-10)-10;
  }else if(gTime >= 4 && gTime <= 5){
    posX = ((-gTime+5)*-10);
    posZ = -10;
  }else if(gTime >= 5 && gTime <= 6){
    posX = ((-gTime+5)*10);
    posZ = -10;
  }else if(gTime >= 6 && gTime <= 7){
    posX = -10;
    posZ = ((-gTime + 7)*-10);
  }else if(gTime >=7 && gTime <= 8){
    posX = ((-gTime+8)*-10);
    posZ =0;
  }
  
}

void letter_h(){
  IK();
  setTime();
  float time = 1.5;
  if(gTime >= 0 && gTime <= 2){
    posX = 0;
    posZ = ((-gTime)*10);
  }else if(gTime>=2 && gTime <=3){
    posX = ((-gTime+2)*10);
    posZ = -10;
  }else if(gTime >= 3 && gTime <= 5){
    posX = -10;
    posZ = ((-gTime+3)*10);
  }
}

void letter_n(){
  IK();
  setTime();
  float time = 1.5;
  if(gTime>=0 && gTime <= 2){
    posX = 0;
    posZ = ((-gTime +2)*10);
  }else if(gTime >= 2 && gTime <=3){
    posX = (-gTime+2)*20;
    posZ = (-gTime+2)*-20;
  }else if(gTime >= 3 && gTime <= 5){
    posX = -20;
    posZ = ((-gTime+5)*10);
  }
}

void letter_t(){
  IK();
  setTime();
  float time = 1.5;
  if(gTime>=0 && gTime<=1){
    posX = -10;
    posZ = ((-gTime +1)*20);
  }else if(gTime>=1 && gTime <= 2){
    posX = ((-gTime+1)*20);
    posZ = 0;
  }
}

void letter_z(){
  IK();
  setTime();
  float time = 1.5;
  if(gTime >= 0 && gTime <= 1){
    posX = ((-gTime)*20);
    posZ = -20;
  }else if(gTime >= 1 && gTime <= 2){
    posX = ((-gTime+2)*-20);
    posZ = ((-gTime+2)*-20);
  }else if(gTime >=2 && gTime <= 3){
    posX = ((-gTime+2)*20);
    posZ = 0;
  }
}

boolean flag = false;
int character = 0;
void writePos(){
  //int currentPosition = 0;
  IK();
  setTime();
  if(millis() - lastChangeTime > time*1000){
    if(flag){
      counter++;
    }
  
  if(counter >= str.length()){
    counter = 0;
    character++;
    if(character >= str.length()){
      character = 0;
      
    }
  }
  }
  flag = !flag;
  lastChangeTime = millis();

  char currentChar = str.charAt(counter);

  switch(currentChar) {
    case 'b':
      letter_b();
      break;
    case 'h':
      letter_h();
      break;
    case 'z':
      letter_z();
      break;
    case 'n':
      letter_n();
      break;
    // Add cases for other letters as needed
  }
}

  


float[] Xsphere = new float[99];
float[] Ysphere = new float[99];
float[] Zsphere = new float[99];

void setup(){
    size(1200, 800, OPENGL);
    List<String[]> arrays = readTextFile("result.txt");
    for (String[] arr: arrays){
      if(arr.length >= 2){
        System.out.print(arr[1]+" ");
        secondPart = arr[1];
      }
    }
    str = secondPart;
    
    base = loadShape("r5.obj");
    shoulder = loadShape("r1.obj");
    upArm = loadShape("r2.obj");
    loArm = loadShape("r3.obj");
    end = loadShape("r4.obj");
    
    shoulder.disableStyle();
    upArm.disableStyle();
    loArm.disableStyle(); 
}

void draw(){ 
   writePos();
   background(32);
   smooth();
   lights(); 
   directionalLight(51, 102, 126, -1, 0, 0);
    
    for (int i=0; i< Xsphere.length - 1; i++) {
    Xsphere[i] = Xsphere[i + 1];
    Ysphere[i] = Ysphere[i + 1];
    Zsphere[i] = Zsphere[i + 1];
    }
    
    Xsphere[Xsphere.length - 1] = posX;
    Ysphere[Ysphere.length - 1] = posY;
    Zsphere[Zsphere.length - 1] = posZ;
   
   noStroke();
   
   translate(width/2,height/2);
   rotateX(rotX);
   rotateY(-rotY);
   scale(-4);
   
   for (int i=0; i < Xsphere.length; i++) {
     pushMatrix();
     translate(-Ysphere[i], -Zsphere[i]-11, -Xsphere[i]);
     fill (#D003FF, 25);
     sphere (float(i) / 20);
     popMatrix();
    }
    
   fill(#FFE308);  
   translate(0,-40,0);   
     shape(base);
     
   translate(0, 4, 0);
   rotateY(gamma);
     shape(shoulder);
      
   translate(0, 25, 0);
   rotateY(PI);
   rotateX(alpha);
     shape(upArm);
      
   translate(0, 0, 50);
   rotateY(PI);
   rotateX(beta);
     shape(loArm);
      
   translate(0, 0, -50);
   rotateY(PI);
     shape(end);
}

void mouseDragged(){
    rotY -= (mouseX - pmouseX) * 0.01;
    rotX -= (mouseY - pmouseY) * 0.01;
}
