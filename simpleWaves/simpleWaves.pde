/*
 * Simple code experiments to make wave-like motion with 3d primitives.
 * The waves are created by calculating the sine values of the curent frame, offset
 * by the position of the given box and the vector determining the motion of the waves.
 *
 * @author ivan dervisevic (thedervish@gmail.com)
 */

int screenWidth = 700;
int screenHeight = 500;

int duration = 6; // Duration of the sine loop in seconds.
int frames = 30;
int numBoxes = 19;
PVector waveDir = new PVector(5, 5, 15); // Vector determining the direction of the waves.

float[][][] boxCoords;
int boxX = 33;
int boxY = 33;
int boxZ = 15;

int redValue = 100;
int blueValue = 200;
int greenValue = 160;

void setup() {
  size(screenWidth, screenHeight, P3D);
  frameRate(frames);
  boxCoords = new float[numBoxes][numBoxes][2];
  for (int i = 0; i < numBoxes; ++i) {
    for (int j = 0; j < numBoxes; ++j) {
      boxCoords[i][j][0] = width/2-(boxX*(int)(numBoxes/2))+(i*boxX);
      boxCoords[i][j][1] = height/2-(boxY*(int)(numBoxes/2))+(j*boxY);
    }
  }
  smooth(8); // set smoothing/antialiasing to 8x, the max.
}

void draw() {
  int currFrame = frameCount;
  background(255,255,255);
  float radianVal, currVal, zTranslation;
  pushMatrix();
  // apply the base transformations for the desired viewpoint
  rotateX(radians(45));
  translate(0,-300,-300);
  // Not having an edge makes the whole thing look more organic. not sure if that's what I would like.
  noStroke();
  // Uncomment to make the edge of the boxes be the base color of the water.
  //stroke(redValue, greenValue, blueValue);
  //strokeWeight(1.5);

  // For each box, translate the center of the screen to be the center point of where the box needs to be, then draw it.
  // Alter the color based on it's height.
  for (int i = 0; i < numBoxes; ++i) {
    for (int j = 0; j < numBoxes; ++j) {
      pushMatrix();
      currVal = (currFrame + i*waveDir.x + j*waveDir.y) % (duration * frames);
      radianVal = map(currVal, 0, duration*frames, 0, 2*PI);
      zTranslation = map(sin(radianVal), -1, 1, -waveDir.z, waveDir.z);
      int colorIntensity = (int)map(sin(radianVal), -1, 1, -100, 50);
      fill(redValue + colorIntensity, greenValue + colorIntensity, blueValue + colorIntensity);
      translate(boxCoords[i][j][0], boxCoords[i][j][1], zTranslation);
      box(boxX, boxY, boxZ);
      popMatrix();
    }
  }
  popMatrix();
}
