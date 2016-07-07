import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

List<EdgeDot> dots;
int numDots = 10;
float xCenter, yCenter;

void setup() {
  size(800, 800, P2D);
  background(0);
  smooth(4);
  //frameRate(2);
  xCenter = width/2;
  yCenter = height/2;
  dots = new ArrayList<EdgeDot>();
  for (int i = 0; i < numDots; ++i) {
    EdgeDot dot = new EdgeDot(random(width/3, 2*width/3), random(height/3, 2*height/3), xCenter, yCenter);
    dots.add(dot);
  }
  sortDots(dots, xCenter, yCenter);
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(0.5);
  for (EdgeDot dot : dots) {
    dot.update(xCenter, yCenter);
    dot.display();
  }
  for (int i = 0; i < dots.size()-1; ++i) {
    EdgeDot firstDot = dots.get(i);
    EdgeDot secondDot = dots.get(i+1);
    line(firstDot.getX(), firstDot.getY(), secondDot.getX(), secondDot.getY());
  }
  EdgeDot firstDot = dots.get(dots.size()-1);
  EdgeDot secondDot = dots.get(0);
  line(firstDot.getX(), firstDot.getY(), secondDot.getX(), secondDot.getY());
}

void sortDots(List<EdgeDot> dots, float xCenter, float yCenter) {
  PVector center = new PVector(xCenter, yCenter);
  List<EdgeDot> result = new ArrayList<EdgeDot>();
  for(int i = 0; i < dots.size()-1; ++i) {
    for(int j = i+1; j < dots.size(); ++j) {
      if (dots.get(i).getAngle() > dots.get(j).getAngle()) {
        EdgeDot temp1 = dots.get(i);
        EdgeDot temp2 = dots.get(j);
        dots.set(i, temp2);
        dots.set(j, temp1);
      }
    }
  }
}


class EdgeDot {

  PVector location;
  PVector direction;
  float angle; // for ordering
  float speed = 2;
  
  EdgeDot(float xPos, float yPos, float xCenter, float yCenter) {
    location = new PVector(xPos, yPos);
    angle = atan2(xPos-xCenter, yPos - yCenter);
    speed = random(1, 2);
  }

  void update(float xCenter, float yCenter) {
    direction = PVector.sub(location, new PVector(xCenter, yCenter));
    direction.normalize();
    location = PVector.add(location, direction.mult(speed));
    if (location.x <= 0 || location.x >= width || location.y <= 0 || location.y >= height
      || (PVector.dist(new PVector(xCenter, yCenter), location) < 2)) {
      speed *= -1;
    }
  }

  void display() {
    fill(255);
    ellipse(location.x, location.y, 2, 2);
    stroke(255);
    strokeWeight(0.5);
    //line(xCenter, yCenter, location.x, location.y);
  }

  float getX() {
    return location.x;
  }

  float getY() {
    return location.y;
  }

  PVector getLocation() {
    return location;
  }

  float getAngle() {
    return angle;
  }
  
}
