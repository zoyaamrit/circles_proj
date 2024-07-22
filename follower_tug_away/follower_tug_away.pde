int numCircles = 12;
float[] angles = new float[numCircles];
float[] radii = new float[numCircles];
float[] speed = new float[numCircles];
//RED = fill(255, 0, 0); 

float centerX, centerY;

void setup() {
  size(800, 800);
  //surface.setResizable(true);
  noCursor();
  
  centerX = width / 2;  
  centerY = height / 2; 
  
  for (int i = 0; i < numCircles; i++) {
    angles[i] = 0;
    radii[i] = 40 + 10 * i;
    speed[i] = 0.02 + 0.01 * i;  
  }
}

void draw() {
  background(0);
 
  // where the followers are being pulled  
  float tempTargetX = mouseX;
  float tempTargetY = mouseY;
  
  // positioning loop   
  for (int i = 0; i < numCircles; i++) {

    // calculate and change current position 
    float followerX = lerp(centerX, tempTargetX, 0.15) + cos(angles[i]) * radii[i];
    float followerY = lerp(centerY, tempTargetY, 0.15) + sin(angles[i]) * radii[i];
    angles[i] += speed[i];
    
    // colour and visual setting
    fill(map(i, 0, numCircles, 116, 255), map(i, 0, numCircles, 153, 192), 255 - map(i, 0, numCircles, 0, 41));
    noStroke();
    ellipse(followerX, followerY, 15, 15); 
    
  fill(255, 255, 255); 
  ellipse(centerX, centerY, 20, 20);
  noStroke();
  }
}
