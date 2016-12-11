import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;

ArrayList<Particle> system = new ArrayList<Particle>();
int numParticles = 100;

void setup() {
  size(800, 800, P2D);
  colorMode(HSB, 100);
  smooth(8);
  background(0, 0, 100);
  for (int i = 0; i < numParticles; ++i) {
    Particle p = new Particle(width/2, height/2, random(-3, 3), random(-3,3));
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
      Particle p = new Particle(width/2, height/2, random(-3, 3), random(-3, 3));
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

  public Particle(float xPos, float yPos, float initialXVel, float initialYVel) {
    location = new PVector(xPos, yPos);
    prevLocation = new PVector(xPos, yPos);
    velocity = new PVector(initialXVel, initialYVel);
    acceleration = new PVector(0, 0);
    lifespan = (int)random(200, 400);
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
      acceleration = new PVector(0, 0);
      lifespan -= 2;
    }
  }

  public void applyForce(PVector force) {
    if (lifespan > 0) {

    }
  }

  public void display() {
    if (lifespan > 0) {
      stroke(185, 50, 40, 50);
      line(prevLocation.x, prevLocation.y, location.x, location.y);
    }
  }

  public boolean isAlive() {
    return lifespan > 0;
  }

}
