import ddf.minim.*;
import ddf.minim.analysis.*;

int numCircles = 5;
float[] x = new float[numCircles];
float[] y = new float[numCircles];
float[] orbitRadius = {0, 40, 35, 25, 20}; 
float[] angle = new float[numCircles];
float[] speed = {0, 0.05, 0.1, 0.15, 0.2}; // Speed of the orbits for each circle
int[] diameters = {20, 20, 15, 10, 6}; // Diameters of the circles

Minim minim;
AudioPlayer player;
FFT fft;

void setup() {
  size(800, 600);
  
  minim = new Minim(this);
  // add to data folder
  player = minim.loadFile("audiofile.mp3"); 
  player.loop();
  
  fft = new FFT(player.bufferSize(), player.sampleRate());
}

void draw() {
  background(255);
  
  // play music
  fft.forward(player.mix);
  
  for (int i = 1; i < numCircles; i++) {
    // music influence
    orbitRadius[i] = 20 + fft.getBand(i) * 2;
  }
  
  // center the rotation
  x[0] = width / 2;
  y[0] = height / 2;

  for (int i = 1; i < numCircles; i++) {
    // modify x y based on music and parent circle
    x[i] = x[i-1] + orbitRadius[i] * cos(angle[i]);
    y[i] = y[i-1] + orbitRadius[i] * sin(angle[i]);
    fill(0, 0, 0);
    ellipse(x[i], y[i], diameters[i], diameters[i]);
    angle[i] += speed[i];
  }
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
