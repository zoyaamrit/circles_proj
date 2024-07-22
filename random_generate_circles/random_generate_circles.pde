// OOP with random generate

int MAX_CIRCLE_NUM = 100;
float RADIOUS = 100;
float RADIOUS_VARIANT_SIZE = 20;
float POSITION_VARIANT_SIZE = 20;
int ADD_CIRCLE_INTERVAL = 10;

ArrayList<Circle> circles;
int frameCounter = 0;

void setup() {
  size(500, 500);
  smooth();
  background(0);
  frameRate(30);
  
  circles = new ArrayList<Circle>();
}

void draw() {
  background(255);
  frameCounter++;
  
  if (frameCounter % ADD_CIRCLE_INTERVAL == 0) {
    circles.add(new Circle());
  }
  
  if (circles.size() == MAX_CIRCLE_NUM) {
    circles.remove(0);
  }  
  
  for (Circle circle: circles) {
    circle.draw();
  }
}

class Circle {
  
  float x;
  float y;
  float xRadious;
  float yRadious;
  
  Circle() {
    // Generate the initial position close to the center
    float initialX = width / 2 + random(-POSITION_VARIANT_SIZE, POSITION_VARIANT_SIZE);
    float initialY = height / 2 + random(-POSITION_VARIANT_SIZE, POSITION_VARIANT_SIZE);
    
    // Spread out over time
    x = initialX + (circles.size() * 2);
    y = initialY + (circles.size() * 2);
    
    xRadious = RADIOUS + random(-RADIOUS_VARIANT_SIZE, RADIOUS_VARIANT_SIZE);
    yRadious = RADIOUS + random(-RADIOUS_VARIANT_SIZE, RADIOUS_VARIANT_SIZE);
  }
  
  void draw() {
    stroke(0);
    strokeWeight(0.5);
    noFill();
    arc(x, y, xRadious * 2, yRadious * 2, 0, PI * 2);
  }
}
