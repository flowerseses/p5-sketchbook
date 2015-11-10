
int screenWidth = 1000;
int screenHeight = 1000;
ArrayList<Snake> snakes;
int numSnakes = 10;

void setup() {
  size(screenWidth, screenHeight, P2D);
  colorMode(HSB, 100);
  background(0, 0, 0);
  frameRate(30);
  snakes = new ArrayList<Snake>();
  for (int i = 0; i < numSnakes; ++i) {
    boolean vertical = true;
    if (random(0, 1) >= 0.5) {
      vertical = false;
    }
    Snake snake = new Snake(random(width/5, 4*width/5), random(height/5, 4*height/5), vertical, (int)random(1, 4), (int)random(5, 10));
    snakes.add(snake);
  }
}

void draw() {
  fill(0, 0, 0, 5);
  noStroke();
  rect(0, 0, width, height);
  for (Snake snake : snakes) {
    snake.update();
  }
}

class Snake {

  private PVector location;
  private boolean vertical;
  private int moveDelay; // in frames
  private int currDelay;
  private int dotWidth;
  private float snakeSpeed;
  private float offset;
  
  public Snake(float x, float y, boolean vertical, int moveDelay, int dotWidth) {
    PVector temp = new PVector(x, y);
    location = temp;
    this.vertical = vertical;
    this.moveDelay = moveDelay;
    this.currDelay = moveDelay;
    this.dotWidth = dotWidth;
    offset = dotWidth/5;
    snakeSpeed = dotWidth + offset;
  }

  public void update() {
    currDelay--;
    if (currDelay == 0) {
      currDelay = moveDelay;
      if (vertical) {
        location.x += snakeSpeed;
      } else {
        location.y += snakeSpeed;
      }
      if (location.x <= 0 || location .x >= width || location.y <= 0 || location.y >= height) {
        snakeSpeed *= -1;
        //vertical = !vertical;
      }
    } else {
      if (random(0, 1) > 0.9) {
          vertical = !vertical;
        if (random(0, 1) > 0.95) {
          snakeSpeed *= -1;
        }
      }
    }
    display();
  }

  public void display() {
    fill(45, 60, 60, 70);
    rect(location.x, location.y, dotWidth, dotWidth);
  }
}
