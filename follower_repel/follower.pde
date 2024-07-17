int numFollowers = 6; 
float[] angle = new float[numFollowers]; 
float[] radius = new float[numFollowers];
float[] speed = new float[numFollowers];



void setup() {
  size(600, 600);
  surface.setResizable(true);
  noCursor(); 
  
  for (int i = 0; i < numFollowers; i++) {
    angle[i] = 0; 
    radius[i] = 20 + 10 * i; 
    speed[i] = 0.02 + 0.01 * i; 
  }
}

void draw() {
  background(0);
  
  float[] followerX = new float[numFollowers];
  float[] followerY = new float[numFollowers];
  
  for (int i = 0; i < numFollowers; i++) {
    
    if (i == 0) {
      fill(255, 255, 255);
      noStroke();
      ellipse(mouseX, mouseY, 15, 15);   
    } else {
    
      followerX[i] = mouseX + cos(angle[i]) * radius[i];
      followerY[i] = mouseY + sin(angle[i]) * radius[i];
      
      angle[i] += speed[i];
      
      float distance = dist(followerX[i], followerY[i], followerX[i-1], followerY[i-1]);
      if (distance <= 13) {
        angle[i] = -angle[i]; 
      }
      
      fill(map(i, 0, numFollowers, 116, 255), map(i, 0, numFollowers, 153, 192), 255 - map(i, 0, numFollowers, 0, 41));
      noStroke(); 
      ellipse(followerX[i], followerY[i], 15, 15); 
    }
  }

}
