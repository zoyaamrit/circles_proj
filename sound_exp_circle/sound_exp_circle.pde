import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

float[] bandValues;
float maxDistance;
int size = 50; // Increased the base size of circles

void setup() {
  size(1000, 1000);
  minim = new Minim(this);
  player = minim.loadFile("audiofile.mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());
  player.play();
  
  bandValues = new float[fft.specSize()];
  maxDistance = width; // Adjusted maxDistance to better fit the screen
}

void draw() {
  background(0);
  fft.forward(player.mix);
  
  // collect band values of music
  int bandsToAverage = fft.specSize() / 2;
  for (int i = 0; i < bandsToAverage; i++) {
    bandValues[i] = fft.getBand(i);
  }
  
  // calculate average band value
  float bandSum = 0;
  for (int i = 0; i < bandsToAverage; i++) {
    bandSum += bandValues[i];
  }
  float avgBandValue = bandSum / bandsToAverage;
  float distance = map(avgBandValue, 0, 100, 200, maxDistance); // Adjusted distance mapping
  
  // place circles in a circular pattern
  float centerX = width / 2;
  float centerY = height / 2;
  float radius = distance;
  
  for (int i = 0; i < bandsToAverage; i++) {
    float angle = map(i, 0, bandsToAverage, 0.4, 5);
    float x = centerX + cos(angle) * radius;
    float y = centerY + sin(angle) * radius;
    
    // size modification based on band value
    float circleSize = map(bandValues[i], 0, 30, 10, size); // Increased minimum size of circles
    fill(0); // Color based on band index
    stroke(map(i, 0, bandsToAverage, 40, 100), 100, 200);
    strokeWeight(2);
    
    ellipse(x, y, circleSize, circleSize);
  }
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
