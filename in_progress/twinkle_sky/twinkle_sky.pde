import java.util.ArrayList;

int frames = 30;
int numStars = 1850;
ArrayList<Star> stars = new ArrayList<Star>();
PImage clouds;

void setup() {
  size(1000, 700, P2D);
  smooth(4);
  frameRate(frames);
  rectMode(CENTER);
  background(0);
  clouds = loadImage("clouds.png");
  for (int i = 0; i < numStars; ++i) {
    Star star = new Star((int)random(10, width-10), (int)random(10, height-10), (int)random(100, 200), (int)random(60, 160));
    stars.add(star);
  }
}

void draw() {
  background(0);
  for (Star star : stars) {
    star.display();
  }
  image(clouds, 0, 0);
}

class Star {

  PVector location;
  float intensity;
  int intensityMax, intensityMin;
  int period = frames; // not used yet, use me to calculate shit
  float increment;
  boolean brighten = false;
  int intDiff = 120;

  public Star(int x, int y, int intensityMax) {
    this(x, y, intensityMax, frames);
  }

  public Star(int x, int y, int intensityMax, int period) {
    location = new PVector(x, y);
    this.intensity = random(intensityMin, intensityMax);
    this.intensityMax = intensityMax;
    this.intensityMin = intensityMax - intDiff;
    if (intensityMin < 0) {
      intensityMin = 0;
    }
    this.period = period;
    increment = intDiff/period;
  }

  public void display() {
    pushStyle();
    pushMatrix();
    translate(location.x, location.y);
    rotate(PI/4);
    fill((int)intensity);
    stroke((int)intensity);
    rect(0, 0, 2, 2);
    if (brighten) {
      intensity += increment;;
      if (intensity >= intensityMax) {
        intensity = intensityMax;
        brighten = false;
      }
    } else {
      intensity -= increment;
      if (intensity <= intensityMin) {
        intensity = intensityMin;
        brighten = true;
      }
    }
    //println(intensity);
    //if (intensity >= intensityMax || intensity <= intensityMin) {
    //brighten = !brighten;
    // intensity = limit(intensity, intensityMin, intensityMax);
    //}
    popMatrix();
    popStyle();
  }

  private int limit(int intensity, int intensityMax, int intensityMin) {
    if (intensity > intensityMax) {
      return(intensityMax);
    } else if (intensity < intensityMin) {
      return(intensityMin);
    }
    return intensity;
  }

}
