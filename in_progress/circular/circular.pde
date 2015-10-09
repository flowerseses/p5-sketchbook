import java.util.*;

int numPoints = 2;
float circleRadius = 150;
Circle theCircle;
int period = 60;
float maxSpeed = 0.03;

void setup() {
  size(1000, 1000);//, P2D);
  background(0);
  frameRate(30);
  smooth(4);
  theCircle = new Circle(width/2, height/2, 200, 5);
}

void draw() {
  boolean addPoint = (frameCount > 1 && (frameCount % period == 0));
  background(0);
  theCircle.update();
  //theCircle.display();
}

PVector getPointAtDistance(PVector start, PVector end, float distance) {
  PVector v = PVector.sub(end, start);
  v.normalize();
  return PVector.add(start, PVector.mult(v, distance));
}

void mousePressed() {
  println("mouse clicked");
  theCircle.addPoint();
}

class Circle {
  private PVector center;
  private PVector speed;
  private float radius;
  int pointCount;
  List<Mover> points;

  public Circle(float x, float y, float radius, int numPoints) {
    this.center = new PVector(x, y);
    pointCount = numPoints;
    this.points = new ArrayList<Mover>(pointCount);
    this.radius = radius;
    for (int i = 0; i < pointCount; ++i) {
      Mover temp = new Mover(0, radius, random(0, TWO_PI), random(-maxSpeed, maxSpeed));
      points.add(temp);
    }
    Collections.sort(points);
    this.speed = new PVector(random(-2, 2), random(-2, 2));
  }

  public void update() {
    center.add(speed);
    if ((center.x >= (width - radius)) || (center.x <= radius)) {
      speed.x *= -1;
    }
    if ((center.y >= (height - radius)) || (center.y <= radius)) {
      speed.y *= -1;
    }
    for (int i =0; i < pointCount; ++i) {
      points.get(i).update();
    }
    Collections.sort(points);
    display();
  }

  public void addPoint() {
    Mover temp = new Mover(0, radius, random(0, TWO_PI), random(-maxSpeed, maxSpeed));
    println("addingPoints");
    points.add(temp);
    pointCount++;
  }

  public void display() {
    point(center.x, center.y);
    strokeWeight(2);
    noFill();
    stroke(50, 50, 50);
    ellipse(center.x, center.y, radius*2, radius*2);
    pushMatrix();
    fill(100, 100, 100);
    translate(center.x, center.y);
    for (int i = 0; i < points.size(); ++i) {
      Mover temp = points.get(i);
      temp.display();
      Mover next;
      if (i == 0) {
        next = points.get(pointCount - 1);
      } else {
        next = points.get(i-1);
      }
      stroke(255);
      PVector p1 = temp.getLocation();
      PVector p2 = next.getLocation();
      line(p1.x, p1.y, p2.x, p2.y);
      noStroke();
    }
    popMatrix();
  }
}

class Mover implements Comparable<Mover>{

  private PVector location;
  float angle;
  private float speed;
  private float distance;
  private float maxDistance;

  private boolean edging;
  private float edgingOutSpeed;
  
  public Mover(float distance, float radius, float angle, float angularSpeed) {
    this.distance = distance;
    this.maxDistance = radius;
    this.angle = angle;
    this.speed = angularSpeed;
    if (distance < radius) {
      edging = false;
      edgingOutSpeed = (radius - distance)/40;
    } else {
      edging = true;
      edgingOutSpeed = 0;
    }
    updateLocation();
  }

  private void updateLocation() {
    location = new PVector(distance*cos(angle), distance*sin(angle));
  }

  public void update() {
    if (edging) {
      angle += speed;
      if (angle > TWO_PI) {
        angle -= TWO_PI;
      }
      if (angle < 0) {
        angle += TWO_PI;
      }
    } else {
      distance += edgingOutSpeed;
      if (distance >= maxDistance) {
        edging = true;
        edgingOutSpeed = 0;
      }
    }
    updateLocation();
  }

  public void display() {
    fill(100, 100, 100);
    ellipse(location.x, location.y, 5, 5);
  }

  public float getAngle() {
    return angle;
  }

  public PVector getLocation() {
    return location;
  }
  @Override
  public int compareTo(Mover m) {
    int retVal = (int)((degrees(this.angle) % 360) - (degrees(m.getAngle()) % 360));
    return retVal;
  }
}

