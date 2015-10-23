import java.util.*;

int mainHue = 50;
int maxSaturation = 50;
float maxBrightness = 50;
int tempPeriod = 150; //frames

float[] periodStarts = new float[3];
float[] periods = new float[3];

ArrayList<Wave> waves = new ArrayList<Wave>();

void setup() {
  size(1000, 1000, P2D);
  colorMode(HSB, 100);
  frameRate(30);
  periodStarts[0] = random(3*tempPeriod/4, tempPeriod);
  periodStarts[1] = random(0, tempPeriod/4);
  periodStarts[2] = random(tempPeriod/2, tempPeriod);
  for (int i = 0; i < periodStarts.length; ++i) {
    periods[i] = periodStarts[i];
  }
  Wave wave;

  for (int i = 0 ; i < 10; ++ i) {
    wave = new Wave(height/3 + i*(2*height/30), 20, periodStarts,(int)random(100, 300), random(30, 60), random(30, 60));
    waves.add(wave);
  }
}

void draw() {
  int currFrame = frameCount;
  initPeriods(currFrame);
  background(50, 0, 20);
  for(Wave wave : waves) {
    fill(mainHue, wave.sat, wave.bright);
    beginShape();
    for (PVector vert : wave.points) {
      vertex(vert.x, vert.y);
    }
    fill(mainHue, 0, 20);
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
  }
}

void initPeriods(int currFrame) {
  for (int i = 0; i < periods.length; ++i) {
    periods[i] = currFrame + periodStarts[i];
  }
  for (Wave wave : waves) {
    wave.update(periods);
  }
}

class Wave {

  List<PVector> points = new ArrayList<PVector>();
  float waveHeight;
  float sat, bright;
  int fullPeriod;

  public Wave(float waveHeight, float wibble, float[] periods, int fullPeriod, float sat, float bright) {
    PVector wavePoint = new PVector(0, waveHeight + random(-wibble, wibble));
    this.waveHeight = waveHeight;
    this.sat = sat;
    this.bright = bright;
    this.fullPeriod = fullPeriod;
    points.add(wavePoint.get());
    for (int i = 0; i < periods.length; ++i) {
      wavePoint = new PVector((i+1) * width/(periods.length + 1), waveHeight + getOffset(periods[i]));
      points.add(wavePoint.get());
    }
    wavePoint = new PVector(width, waveHeight + random(-wibble, wibble));
    points.add(wavePoint.get());
  }

  public void update(float[] periods) {
    for (int i = 1; i < (points.size() -1); ++i) {
      PVector temp = points.get(i).get();
      temp.y = waveHeight + getOffset(periods[i-1]);
      points.set(i, temp.get());
    }
  }

  public float getOffset(float period) {
    float angle = map(period % fullPeriod, 0, fullPeriod, 0, TWO_PI);
    return map(sin(angle), -1, 1, -40, 40);
  }

}
