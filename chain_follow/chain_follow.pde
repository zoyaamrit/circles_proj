int numCircles = 5;
float[] x = new float[numCircles];
float[] y = new float[numCircles];
float[] orbitRadius = {0, 40, 35, 25, 20}; // Radius of the orbits for each circle
float[] angle = new float[numCircles];
float[] speed = {0, 0.05, 0.1, 0.15, 0.2}; // Speed of the orbits for each circle
int[] diameters = {20, 20, 15, 10, 6}; // Diameters of the circles
float mouseInfluence = 0.5; // Factor to scale mouse influence

void setup() {
  size(800, 600);
}

void draw() {
  background(255);
  
  x[0] = mouseX;
  y[0] = mouseY;

  for (int i = 1; i < numCircles; i++) {
    float dx = mouseX - pmouseX;
    float dy = mouseY - pmouseY;
    x[i] = x[i-1] + orbitRadius[i] * cos(angle[i]) + dx * mouseInfluence * i;
    y[i] = y[i-1] + orbitRadius[i] * sin(angle[i]) + dy * mouseInfluence * i;
    fill(0, 0, 0);
    ellipse(x[i], y[i], diameters[i], diameters[i]);
    angle[i] += speed[i];
  }
}
