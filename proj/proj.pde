ArrayList<Circle> circles;
boolean isMousePressed = false;
PVector center;
Interaction interaction;
int pressStartTime;

void setup() {
  size(800, 600);
  circles = new ArrayList<Circle>();
  center = new PVector(width / 2, height / 2);
  interaction = new Interaction();
  smooth();
}

void draw() {
  background(255);

  // Update and display circles
  for (int i = 0; i < circles.size(); i++) {
    Circle c1 = circles.get(i);
    c1.move();
    c1.display();
    for (int j = i + 1; j < circles.size(); j++) {
      Circle c2 = circles.get(j);
      interaction.checkInteraction(c1, c2);
    }
  }

  // Handle circle creation when mouse is pressed
  if (isMousePressed) {
    float size = (millis() - pressStartTime) / 10.0; // modify size based on current time and start time 
    fill(200, 200, 255, 100);
    noStroke();
    ellipse(mouseX, mouseY, size, size);
  }
}

void mousePressed() {
  isMousePressed = true;
  pressStartTime = millis(); // when mouse is pressed 
}

void mouseReleased() {
  isMousePressed = false;
  float size = (millis() - pressStartTime) / 10.0; // growth rate
  circles.add(new Circle(mouseX, mouseY, size));
  pressStartTime = 0; // Reset pressStartTime
}
