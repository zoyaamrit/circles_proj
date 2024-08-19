ArrayList<Circle> circles;
boolean isMousePressed = false;
PVector center;
Interaction interaction;
int pressStartTime;
color current_c;

void setup() {
  size(800, 800);
  circles = new ArrayList<Circle>();
  center = new PVector(width / 2, height / 2);
  interaction = new Interaction();
  smooth();
}

void draw() {
  background(255);

  for (int i = circles.size() - 1; i >= 0; i--) {  // Iterate backwards to safely remove elements
    Circle c1 = circles.get(i);
    c1.move();
    c1.display();
    
    // Handle interactions between circles
    for (int j = i - 1; j >= 0; j--) {  // Iterate backwards to safely remove elements
      Circle c2 = circles.get(j);
      interaction.checkInteraction(c1, c2);
    }

    // Check for deletion conditions
    if (c1.radius > 300) {
      circles.remove(i);  // Remove circle if size is less than 5
      continue;
    }

    // Handle opacity change for more than 10 interactions
    if (c1.totalInteractions > 20) {
      c1.opacity = min(c1.opacity + 5, 255);
    }

    // Handle diminishing size if radius is greater than 500
    //if (c1.radius > 200) {
    //  c1.radius -= 0.5;  // Slowly diminish the circle's size
    //}
  }

  // Handle circle creation when mouse is pressed
  if (isMousePressed) {
    float size = (millis() - pressStartTime) / 10.0; // modify size based on current time and start time
    fill(current_c, 100);
    noStroke();
    ellipse(mouseX, mouseY, size, size);
  }
}

void mousePressed() {
  isMousePressed = true;
  pressStartTime = millis(); // when mouse is pressed
  current_c = color(random(255), random(255), 255, 100);
}

void mouseReleased() {
  isMousePressed = false;
  float size = (millis() - pressStartTime) / 10.0; // growth rate
  circles.add(new Circle(mouseX, mouseY, size, current_c));
  pressStartTime = 0; // Reset pressStartTime
}

class Circle {
  PVector position;
  float radius;
  PVector velocity;
  color c;
  int totalInteractions;  // Track total number of interactions
  float opacity;  // Store current opacity
  boolean inInteraction;
  HashMap<Circle, Boolean> currentlyInteracting; // Track ongoing interactions

  Circle(float x, float y, float r, color col) {
    position = new PVector(x, y);
    radius = r;
    velocity = PVector.random2D();
    c = col;
    totalInteractions = 0;
    opacity = 100;
    inInteraction = false;
    currentlyInteracting = new HashMap<Circle, Boolean>();
  }

  void move() {
    position.add(velocity);

    // Keep movement within window
    if (position.x < radius || position.x > width - radius) {
      velocity.x *= -1;
    }
    if (position.y < radius || position.y > height - radius) {
      velocity.y *= -1;
    }
  }

  void display() {
    fill(c, opacity);  // Use the current opacity
    noStroke();
    ellipse(position.x, position.y, radius, radius);
  }
}

class Interaction {
  HashMap<Circle, HashMap<Circle, Integer>> pastInteractions; // Track past interactions

  Interaction() {
    pastInteractions = new HashMap<Circle, HashMap<Circle, Integer>>();
  }

  void checkInteraction(Circle c1, Circle c2) {
    float d = PVector.dist(c1.position, c2.position);
    float maxRadius = 1.5 * max(c1.radius, c2.radius);

    if (d < maxRadius) {
      color lineColor = lerpColor(c1.c, c2.c, 0.5);
      stroke(lineColor);
      strokeWeight(2);
      line(c1.position.x, c1.position.y, c2.position.x, c2.position.y);

      // Update or initialize interaction history if interaction just started
      if (!c1.currentlyInteracting.containsKey(c2) || !c1.currentlyInteracting.get(c2)) {
        c1.currentlyInteracting.put(c2, true);
        c2.currentlyInteracting.put(c1, true);

        if (!pastInteractions.containsKey(c1)) {
          pastInteractions.put(c1, new HashMap<Circle, Integer>());
        }
        if (!pastInteractions.containsKey(c2)) {
          pastInteractions.put(c2, new HashMap<Circle, Integer>());
        }
        HashMap<Circle, Integer> c1History = pastInteractions.get(c1);
        HashMap<Circle, Integer> c2History = pastInteractions.get(c2);

        if (!c1History.containsKey(c2)) {
          c1History.put(c2, 0);
        }
        if (!c2History.containsKey(c1)) {
          c2History.put(c1, 0);
        }

        // Increment interaction count only when a new interaction begins
        int previousInteractions = c1History.get(c2);
        c1History.put(c2, previousInteractions + 1);
        c2History.put(c1, previousInteractions + 1);
        c1.totalInteractions++;
        c2.totalInteractions++;

        // Determine if the interaction is cooperative or competitive
        if (previousInteractions >= 5) {
          // Cooperative interaction: Both circles grow
          c1.radius += 1;
          c2.radius += 1;
        } else {
          // Competitive interaction: Larger circle grows, smaller circle shrinks
          if (c1.radius > c2.radius) {
            c1.radius -= 1;
            c2.radius += 1;
          } else {
            c1.radius += 1;
            c2.radius -= 1;
          }
        }
      }
    } else {
      // Reset interaction status when circles move apart
      c1.currentlyInteracting.put(c2, false);
      c2.currentlyInteracting.put(c1, false);
    }
  }
}
