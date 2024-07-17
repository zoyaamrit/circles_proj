float angle0 = 0; 
float angle1 = 0; 
float radius = 40; 
float rotationSpeed0 = 0.07; 
float rotationSpeed1 = 0.06; 


void setup() {
  size(600, 400);
}

void draw() {
  background(255);
  
  float followerX0 = mouseX + cos(angle0) * radius;
  float followerY0 = mouseY + sin(angle0) * radius;
  
  float followerX1 = mouseX + cos(angle1) * radius * 1.5;
  float followerY1 = mouseY + sin(angle1) * radius * 1.5;
  
  angle0 += rotationSpeed0;
  angle1 += rotationSpeed1;
  
  fill(116, 153, 255);
  noStroke();
  ellipse(followerX0, followerY0, 15, 15); 
  
  fill(255, 192, 41);
  noStroke();
  ellipse(followerX1, followerY1, 15, 15); 
  
  //fill(116, 153, 255);
  //noStroke();
  //ellipse(followerX, followerY, 15, 15); 
  
  fill(0, 0, 0);
  noStroke();
  ellipse(mouseX, mouseY, 20, 20); 
}
