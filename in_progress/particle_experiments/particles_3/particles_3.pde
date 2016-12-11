import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;

ArrayList<ParticleSystem> particleSystems = new ArrayList<ParticleSystem>();
int maxSystems = 3;
int numParticles = 100;
int h;

void setup() {
  size(800, 800, P2D);
  colorMode(HSB, 255);
  //blendMode(LIGHTEST);
  smooth(8);
  background(0, 0, 180);
  int h = 130;
  int s = 150;
  int b = 150;
  int a = 120;
  particleSystems.add(new ParticleSystem(width/2, height/2, 10, 150, h, s, b, a));
}

void draw() {
  Iterator<ParticleSystem> it = particleSystems.iterator();
  while (it.hasNext()) {
    ParticleSystem ps = it.next();
    if (ps.isAlive()) {
      ps.run();
    } else {
      it.remove();
    }
  }
}

void mousePressed() {
  if (particleSystems.size() < maxSystems) {
    particleSystems.add(new ParticleSystem(mouseX, mouseY, 10));
  }
}


// Classes 

class ParticleSystem {

  ArrayList<Particle> particles;

  PVector location;
  PVector prevLocation;
  PVector velocity;
  PVector acceleration;
  int numParticles;
  int avgParticleLifespan;
  int particleHue, particleSaturation, particleBrightness, particleAlpha;
  boolean dying;

  public ParticleSystem(float xPos, float yPos, int numParticles) {
    // No hue/lifespan provided, randomize them?
    this(xPos, yPos, numParticles, (int)random(100, 400), (int)random(0, 255), (int)random(150, 250), (int)random(100, 2000), (int)random(100, 180));
  }

  public ParticleSystem(float xPos, float yPos, int numParticles, int lifespan, int h, int s, int b, int a) {
    location = new PVector(xPos, yPos);
    prevLocation = location.get();
    // No movement for now;
    velocity = new PVector(0, 0);
    acceleration = new PVector(random(-0.005, 0.005), random(-0.005, 0.005));
    this.numParticles = numParticles;
    avgParticleLifespan = lifespan;
    particleHue = h;
    particleSaturation = s;
    particleBrightness = b;
    particleAlpha = a;

    particles = new ArrayList<Particle>();
    for (int i = 0; i < numParticles; ++i) {
      Particle p = new Particle(location.x, location.y, random(-3, 3), random(-3, 3), avgParticleLifespan, particleHue, particleSaturation, particleBrightness, particleAlpha);
      particles.add(p);
    }
    dying = false;
  }

  public void run() {
    update();
    updateParticles();
  }

  private void updateParticles() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      if (p.isAlive()) {
        p.run();
      } else {
        it.remove();
      }
    }
    
    if (particles.size() < numParticles && !dying) {
      for (int i = particles.size(); i < numParticles; ++i) {
        Particle p = new Particle(location.x, location.y, random(-3, 3), random(-3, 3), avgParticleLifespan, particleHue, particleSaturation, particleBrightness, particleAlpha);
        particles.add(p);
      }
    }
  }

  private void update() {
    // We'll move here
    if (!dying) {
      prevLocation = location.get();
      velocity.add(acceleration);
      location.add(velocity);
      if (outOfBounds()) {
        dying = true;
      }
      strokeWeight(0.5);
      stroke(particleHue, particleSaturation, particleBrightness, particleAlpha);
      line(prevLocation.x, prevLocation.y, location.x, location.y);
    }
  }

  private boolean outOfBounds() {
    return (location.x < 0 || location.x > width || location.y < 0 || location.y > height);
  }

  public boolean isAlive() { 
    return particles.size() > 0;
  }

}

class Particle {

  PVector location;
  PVector prevLocation;
  PVector velocity;
  PVector acceleration;
  int lifespan;
  int h, s, b ,a;

  public Particle(float xPos, float yPos, float initialXVel, float initialYVel, int lifespan, int h, int s, int b, int a) {
    location = new PVector(xPos, yPos);
    prevLocation = new PVector(xPos, yPos);
    velocity = new PVector(initialXVel, initialYVel);
    acceleration = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    this.lifespan = (int)random(lifespan-50, lifespan+50);
    this.h = h;
    this.s = s;
    this.b = b;
    this.a = a;
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
      stroke(h, s, b, a);
      line(prevLocation.x, prevLocation.y, location.x, location.y);
    }
  }

  public boolean isAlive() {
    return lifespan > 0;
  }

}
