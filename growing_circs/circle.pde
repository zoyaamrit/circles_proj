class GrowingCircle {
  float x, y, radius;
  float growthRate = 1.1;

  GrowingCircle(float x, float y, float radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
  }

  void update(int num) {
    float maxRadius = 100.0 / num;
    radius += growthRate;
    if (radius > maxRadius) {
      radius = maxRadius;
    }
  }

  void display() {
    noFill();
    stroke(255);
    strokeWeight(4); 
    ellipse(x, y, radius*2, radius*2);
  }

  boolean isReadyToSplit(int num) {
    float maxRadius = 100.0 / num;
    return radius >= maxRadius;
  }

  ArrayList<GrowingCircle> split() {
    ArrayList<GrowingCircle> newCircles = new ArrayList<GrowingCircle>();
    newCircles.add(new GrowingCircle(x - radius / 2, y, 0));
    newCircles.add(new GrowingCircle(x + radius / 2, y, 0));
    return newCircles;
  }
}
