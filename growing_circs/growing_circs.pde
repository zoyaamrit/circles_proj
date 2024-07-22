ArrayList<GrowingCircle> circles;

void setup() {
  size(800, 800);
  circles = new ArrayList<GrowingCircle>();
  circles.add(new GrowingCircle(width/2, height/2, 0));
}

void draw() {
  background(0);
  
  if (circles.size() > 50) {
    exit(); 
  }
  
  for (int i = circles.size() - 1; i >= 0; i--) {
    GrowingCircle circle = circles.get(i);
    circle.update(circles.size());
    circle.display();
    if (circle.isReadyToSplit(circles.size())) {
      circles.addAll(circle.split());
      circles.remove(i);
    }
  }
  
  delay(50);
}
