// families dispering/immigration concept

int numParticles = 1000;
Particle[] particles = new Particle[numParticles];
PImage circleImage;
int delayFrames = 120; 

void setup() {
  size(800, 800);
  circleImage = createCircleImage(200, color(192, 189, 165));
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle(random(width / 2 - 100, width / 2 + 100), random(height / 2 - 100, height / 2 + 100), circleImage);
  }
  noStroke();
}

void draw() {
  background(0);
  if (frameCount > delayFrames) {
    for (Particle p : particles) {
      p.update();
    }
  } else {
    for (Particle p : particles) {
      text("each on their own path", 40, 120); 
    }
  }
  for (Particle p : particles) {
    p.display();
  }
}

PImage createCircleImage(int diameter, int c) {
  PImage img = createImage(diameter, diameter, ARGB);
  img.loadPixels();
  for (int x = 0; x < diameter; x++) {
    for (int y = 0; y < diameter; y++) {
      float d = dist(x, y, diameter / 2, diameter / 2);
      if (d < diameter / 2) {
        img.pixels[x + y * diameter] = c;
      } else {
        img.pixels[x + y * diameter] = color(0, 0);
      }
    }
  }
  img.updatePixels();
  return img;
}
