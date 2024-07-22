class Particle {
  float x, y;
  float speedX, speedY;
  color c;
  boolean active = false;
  float circleCenterX, circleCenterY, circleRadius;

  Particle(float x, float y, PImage img) {
    this.x = x;
    this.y = y;
    circleCenterX = width / 2;
    circleCenterY = height / 2;
    circleRadius = 100; // Half of the circle diameter used for createCircleImage
    int imgX = int(map(x, circleCenterX - circleRadius, circleCenterX + circleRadius, 0, img.width));
    int imgY = int(map(y, circleCenterY - circleRadius, circleCenterY + circleRadius, 0, img.height));
    c = img.pixels[imgX + imgY * img.width];
    speedX = random(-2, 2);
    speedY = random(-2, 2);
  }

  void update() {
    if (active) {
      x += speedX;
      y += speedY;
      if (x < 0 || x > width || y < 0 || y > height) {
        active = false;
      }
    } else if (frameCount > delayFrames) {
      active = true;
    }
  }

  void updateWithinCircle() {
    float d = dist(x, y, circleCenterX, circleCenterY);
    if (d < circleRadius) {
      x += speedX;
      y += speedY;
    } else {
      float angle = atan2(y - circleCenterY, x - circleCenterX);
      x = circleCenterX + cos(angle) * circleRadius;
      y = circleCenterY + sin(angle) * circleRadius;
    }
  }

  void display() {
    fill(c);
    ellipse(x, y, 4, 4);
  }
}
