EdgeDot dot;

void setup() {
  size(800, 800, P2D);
  background(0);
  dot = new EdgeDot(random(width/3, 2*width/3), random(height/3, 2*height/3));
}

void draw() {
  background(0);
  dot.update(width/2, height/2);
  dot.display();
}

class EdgeDot {

  PVector location;
  PVector direction;
  float speed = 2;
  
  EdgeDot(float xPos, float yPos) {
    location = new PVector(xPos, yPos);
  }

  void update(float xCenter, float yCenter) {
    direction = PVector.sub(location, new PVector(xCenter, yCenter));
    direction.normalize();
    //direction.mult(-1);
    location = PVector.add(location, direction.mult(speed));
    if (location.x < 0 || location.x > width || location.y < 0 || location.y > height
        || (location.x - xCenter < 2 && location.y - yCenter < 2)) {
      speed *= -1;
    }
  }

  void display() {
    fill(255);
    ellipse(location.x, location.y, 5, 5);
    stroke(255);
    line(width/2, height/2, location.x, location.y);
  }
  
}
