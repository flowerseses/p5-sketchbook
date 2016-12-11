import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;

ArrayList<Particle> system = new ArrayList<Particle>();
int numParticles = 100;
int h;

void setup() {
  size(800, 800, P2D);
  colorMode(HSB, 255);
  smooth(8);
  background(0, 0, 255);
  h = 130;//(int)random(0, 255);
  for (int i = 0; i < numParticles; ++i) {
    Particle p = new Particle(width/2, height/2, random(-3, 3), random(-3,3), h);
    system.add(p);
  }
}

void draw() {
  Iterator<Particle> it = system.iterator();
  while (it.hasNext()) {
    Particle p = it.next();
    if (p.isAlive()) {
      p.run();
    } else {
      it.remove();
    }
  }

  if (system.size() < numParticles) {
    for (int i = system.size(); i < numParticles; ++i) {
      int tempH = h;
      if (random(0, 1) > 0.8) {
        tempH = 240;
      }
      Particle p = new Particle(width/2, height/2, random(-3, 3), random(-3, 3), tempH);
      system.add(p);
    }
  }
}

class Particle {

  PVector location;
  PVector prevLocation;
  PVector velocity;
  PVector acceleration;
  int lifespan;
  int h;

  public Particle(float xPos, float yPos, float initialXVel, float initialYVel, int h) {
    location = new PVector(xPos, yPos);
    prevLocation = new PVector(xPos, yPos);
    velocity = new PVector(initialXVel, initialYVel);
    acceleration = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    lifespan = (int)random(200, 400);
    this.h = h;
  }

  public void run() {
    update();
    display();
  }

  public void update() {
    if (lifespan > 0) {
      prevLocation = location.get();
      velocity.add(acceleration);
      location.add(velocity);
      lifespan -= 2;
    }
  }

  public void applyForce(PVector force) {
    if (lifespan > 0) {

    }
  }

  public void display() {
    if (lifespan > 0) {
      strokeWeight(0.5);
      stroke(h, 125, 120, 120);
      line(prevLocation.x, prevLocation.y, location.x, location.y);
    }
  }

  public boolean isAlive() {
    return lifespan > 0;
  }

}
