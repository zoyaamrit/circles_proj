int numCircles = 12;
float[] angles = new float[numCircles];
float[] radii = new float[numCircles];
float[] speed = new float[numCircles];

void setup() {
  size(600, 600);
  surface.setResizable(true);
  noCursor();
  for (int i = 0; i < numCircles; i++) {
    angles[i] = 0;
    radii[i] = 40 + 10 * i;
    speed[i] = 0.02 + 0.01 * i;
  }
}

void draw() {
  background(0);
  
  float[] followerX = new float[numCircles];
  float[] followerY = new float[numCircles];
  
  for (int i = 0; i < numCircles; i++) {
    followerX[i] = mouseX + cos(angles[i]) * radii[i];
    followerY[i] = mouseY + sin(angles[i]) * radii[i];
    
    angles[i] += speed[i];
  }
  
  for (int i = 0; i < numCircles; i++) {
    if (i > 0) {
      float distance = dist(followerX[i], followerY[i], followerX[i-1], followerY[i-1]);
      if (distance <= 13) { // 15 is the diameter of the circles
         fill(255, 0, 0);
        speed[i] = -speed[i];
      } else {
        fill(map(i, 0, numCircles, 116, 255), map(i, 0, numCircles, 153, 192), 255 - map(i, 0, numCircles, 0, 41));
      }
    }
    noStroke();
    ellipse(followerX[i], followerY[i], 15, 15); 
  }
  
  fill(255, 255, 255);
  noStroke();
  ellipse(mouseX, mouseY, 20, 20); 
}
