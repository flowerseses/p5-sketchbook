Vehicle pursuer, target;
PVector endpoint;
boolean flee = false;

void setup() {
  size(500, 500, P2D);
  smooth(4);
  frameRate(30);
  pursuer = new Vehicle(width/2, height/2, 4);
  target = new Vehicle(width/2, height/3, 1);
  endpoint = new PVector(width, height);
}

void draw() {
  background(255);
  target.seek(endpoint);
  target.update();
  target.display();

  pursuer.seek(target);
  pursuer.update();
  pursuer.display();
}

/*
// Setup for following the mouse
void setup() {
  size(500, 500, P2D);
  smooth(4);
  one = new Vehicle(width/2, height/2, 4);
}

void draw() {
  background(255);
  PVector target = new PVector(mouseX, mouseY);
  one.seek(target, flee);
  one.update();
  one.display();
}

void mousePressed() {
  flee = !flee;
  }*/

class Vehicle {
  PVector location;
  PVector velocity;
  PVector acceleration;

  float maxSpeed;
  float maxForce;
  float r;

  Vehicle(float x, float y, float maxSpeed) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    r = 4; // size of the triangle
    this.maxSpeed = maxSpeed;
    maxForce = 0.1;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void seek(PVector target) {
    stroke(0, 0, 0, 50);
    line(location.x, location.y, target.x, target.y);

    PVector desired = PVector.sub(target, location);
    float dist = desired.mag();
    desired.normalize();
    if (dist < 100) {
      float m = map(dist, 0, 100, 0, maxSpeed);
      desired.mult(m);
    } else {
      desired.mult(maxSpeed);
    }
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void seek(Vehicle target) {
    PVector targetFuture = PVector.add(target.location, target.velocity);
    seek(targetFuture);
  }
  
  void display() {
    float theta = velocity.heading() + PI/2;
    fill(100);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    strokeWeight(0.5);
    popMatrix();
  }
}
