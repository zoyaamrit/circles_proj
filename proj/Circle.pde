class Circle {
  PVector position;
  float radius;
  PVector velocity;
  color c;

  Circle(float x, float y, float r) {
    position = new PVector(x, y);
    radius = r;
    velocity = PVector.random2D();
    c = color(random(100), random(100), 255, 100);
  }

  void move() {
    position.add(velocity);
    
    // keep movement within window 
    if (position.x < radius || position.x > width - radius) {
      velocity.x *= -1;
    }
    if (position.y < radius || position.y > height - radius) {
      velocity.y *= -1;
    }
  }

  void display() {
    fill(c);
    noStroke();
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}
