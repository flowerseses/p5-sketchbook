import java.util.*;

int numParticles = 100;
ArrayList<Particle> particles = new ArrayList<Particle>(numParticles);
ArrayList<Attractor> attractors = new ArrayList<Attractor>();

void setup() {
  size(1000, 1000, P2D);
  colorMode(HSB, 100, 100, 100, 100);
  blendMode(ADD);
  background(0, 0, 0);
  smooth(6);
  frameRate(25);
  PVector pos = new PVector(width/2, height/2);
  float angle = 0;
  float angleInc = TWO_PI / numParticles;
  float intensity = 20;
  for (int i = 0; i < numParticles; ++i) {
    pos = new PVector(random(width/4, 3*width/4), random(height/4, 3*height/4));
    PVector v = new PVector(intensity*cos(angle), intensity*sin(angle));
    angle += angleInc;
    PVector acc = new PVector(0, 0);
    float mass = 2.5;
    Particle p = new Particle(pos, v, acc, mass);
    particles.add(p);
  }
  makeAttractors();
}

void draw() {
  for (Attractor a : attractors) {
    //a.display();
  }
  PVector force;
  for (int i = 0; i < particles.size(); ++i) {
    for (int j = 0; j < particles.size(); ++j) {
      if (i != j) {
        force = particles.get(j).attract(particles.get(i));
        particles.get(i).applyForce(force);
      }
    }
    particles.get(i).display();
  }
}

void makeAttractors() {
  PVector pos = new PVector(width/2, height/2);
  Attractor a = new Attractor(pos, 10);
  attractors.add(a);  
}

class Attractor {
  float mass, G;
  PVector pos;
  boolean reflector = false;

  Attractor(PVector pos, float mass) {
    this.pos = pos.get();
    this.mass = mass;
    G = 0.3;
  }

  void display() {
    noStroke();
    fill(20, 50, 100, 40);
    ellipse(pos.x, pos.y, 3, 3);
  }

  PVector attract(Particle p) {
    PVector force = PVector.sub(pos, p.pos);
    float distance = force.mag();
    distance = constrain(distance, 5, 50);
    force.normalize();
    float strength = (G*mass*mass)/(distance*distance);
    force.mult(strength);
    return reflector ? PVector.mult(force, -1) : force;
  }
}

class Particle {
  PVector pos, speed, acceleration;
  float maxSpeed = 7;
  float mass;
  float G = 0.9;
  
  public Particle(PVector pos, PVector speed, PVector acc, float mass) {
    this.pos = pos.get();
    this.speed = speed.get();
    this.acceleration = acc.get();
    this.mass = mass;
  }

  public Particle(PVector pos, PVector speed) {
    this(pos, speed, new PVector(0, 0), 5);
  }

  protected void update() {
    acceleration.add(new PVector(random(-0.01, 0.01), random(-0.01, 0.01)));
    speed.add(acceleration);
    speed.limit(maxSpeed);
    pos.add(speed);
    acceleration.mult(0);
  }

  public void display() {
    noFill();
    //strokeWeight(2);
    stroke(random(30, 50), random(60, 100), 100, 15);
    PVector prevPos = pos.get();
    update();
    line(prevPos.x, prevPos.y, pos.x, pos.y);
  }

  public void applyForce(PVector force) {
    acceleration.add(force);
  }

  public void updateAcceleration(PVector a) {
    acceleration.add(a);
  }

  PVector attract(Particle p) {
    PVector force = PVector.sub(pos, p.pos);
    float distance = force.mag();
    distance = constrain(distance, 5, 50);
    force.normalize();
    float strength = (G*mass*mass)/(distance*distance);
    force.mult(strength);
    return force;
  }

  
}

void mousePressed() {
  PVector p = new PVector(mouseX, mouseY);
  Attractor a = new Attractor(p, 20);
  attractors.add(a);
  if (attractors.size() > 2) {
    attractors.remove(0);
  }
}
