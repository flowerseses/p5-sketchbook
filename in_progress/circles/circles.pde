import java.util.ArrayList;

ArrayList<CircleMover> things;
int numCircles = 20;
int frameDelay = 0;
int circleRadius = 60;

void setup() {
  size(1000, 1000, P2D);
  smooth(4);
  frameRate(30);
  things = new ArrayList<CircleMover>();
  for (int i = 0; i < numCircles; ++i) {
    CircleMover thing = new CircleMover(new PVector(random(circleRadius, width - circleRadius), random(circleRadius, height-circleRadius)), new PVector(random(-5, 5), random(-5, 5)), random(circleRadius-10, circleRadius + 10));
    things.add(thing);
  }
  background(0);
}

void draw() {
  background(0);
  println(frameCount);
  if (frameCount % 70 == 0) {
    frameDelay = (int)random(20,50);
    println("THING\n\n");
  }
  for (CircleMover thing: things) {
    thing.update();
  }
  if (frameDelay > 0){
    frameDelay--;
  }

}

class CircleMover {

  PVector location, speed;
  float radius, pointAngle, angularSpeed;
  
  public CircleMover(PVector pos, PVector speed, float radius) {
    location = pos.get();
    this.speed = speed.get();
    this.radius = radius;
    pointAngle = random(0, TWO_PI);
    angularSpeed = random(0, 1) > 0.5 ? 0.05 : -0.05;
  }

  public void update() {
    location.add(speed);
    if (location.x + radius/2 >= width || location.x - radius/2 <= 0) {
      speed.x *= -1;
    }
    if (location.y + radius/2 >= height || location.y - radius/2 <= 0) {
      speed.y *= -1;
    }
    pointAngle += angularSpeed;
    if (pointAngle >= TWO_PI) {
      pointAngle -= TWO_PI;
    }
    if (pointAngle <= 0) {
      pointAngle += TWO_PI;
    }
    boolean showOutline = false;
    for (CircleMover mover: things) {
      float close = location.dist(mover.location);
      if (close <= radius && close >0) {
        showOutline = true;
        break;
      }
    }
    display(showOutline);
  }

  public void display(boolean showOutline) {
    strokeWeight(2);
    stroke(155);
    noFill();
    if (showOutline) {
      ellipse(location.x, location.y, radius, radius);
    }
    float xPos = location.x + (radius/2)*sin(pointAngle);
    float yPos = location.y + (radius/2)*cos(pointAngle);
    noStroke();
    fill(255);
    ellipse(xPos, yPos, 10, 10);
  }
  
}


