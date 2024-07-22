import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

float[] bandValues;
float maxDistance;
int size = 50; 

void setup() {
  size(1000, 1000);
  minim = new Minim(this);
  player = minim.loadFile("dchPhone.mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());
  player.play();
  
  bandValues = new float[fft.specSize()];
  maxDistance = width / 2.5;
}

void draw() {
  background(0);
  fft.forward(player.mix);
  
  // collect band value of music
  float bandSum = 0;
  int bandsToAverage = fft.specSize() / 2;
  for (int i = 0; i < bandsToAverage; i++) {
    bandValues[i] = fft.getBand(i);
    bandSum += bandValues[i];
  }
  
  // calculate pos of circles
  float avgBandValue = bandSum / bandsToAverage;
  float distance = map(avgBandValue, 0, 95, 0, maxDistance); 

  // place circle
  float x1 = 200 + (width / width - distance);
  float x2 = 200 + (width / distance - 50);
  float y = height / 2;
  
  // size modification
  if (dist(x1, y, x2, y) < 100) {
    //fill(255, 0, 0);  
    size = 120;
    x2 = x1;
  } else {
    size = 50; 
  }
  fill(255, 255, 255); 
  noStroke();
  ellipse(x1, y, size, size);
  ellipse(x2, y, 50, 50);
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
