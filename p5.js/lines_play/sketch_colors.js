"use strict";

var lineX, lineY;
var angleIncrement;
var side, diagonal;
var increment;
var runAwayTimer;
var xPositions, yPositions, colors, increments;
var numSnakes;

function setup() {
    createCanvas(1000, 800);
    colorMode(HSB, 100);
    frameRate(20);
    background(0, 0, 100);
    stroke(0, 0, 0, 10);
    line(width/5, 0, width/5, height);
    line(4*width/5, 0, 4*width/5, height);
    line(0, height/5, width, height/5);
    line(0, 4*height/5, width, 4*height/5);

    numSnakes = 8;
    xPositions = [];
    yPositions = [];
    colors = [];
    increments = [];
    angleIncrement = PI/4;
    side = 10;
    diagonal = sqrt(200);

    for (var i = 0; i < numSnakes; i++) {
        colors[i] = color(Math.round(random(0, 100)), 100, 100, 30);
        xPositions[i] = width/2;
        yPositions[i] = height/2;
        increments[i] = getIncrement(Math.round(random(0, 7)), xPositions[i], yPositions[i], width, height);
    }
    noFill();
}

function draw() {
    for (var i = 0; i < numSnakes; i++) {
        var inside = false;
        while(!inside) {
            increments[i] = getIncrement(increments[i], xPositions[i], yPositions[i], width, height);
            var lineLen;
            var xPos, yPos;
            if (increments[i] % 2 == 0) {
                lineLen = side;
            } else {
                lineLen = diagonal;
            }
            var angle = angleIncrement*increments[i];
            xPos = xPositions[i] + lineLen*cos(angle);
            yPos = yPositions[i] + lineLen*sin(angle);
            if (xPos < 0 || xPos > width || yPos < 0 || yPos > height) {
                inside = false;
            } else {
                inside = true;
            }
        }
        stroke(colors[i])
        console.log(increments[i]);
        line(xPositions[i], yPositions[i], xPos, yPos);
        xPositions[i] = xPos;
        yPositions[i] = yPos;
    }
}

// TODO: fix me up so that I return weighted directions
function getIncrement(prev, lineX, lineY, w, h) {
    var res;
    if (random(0, 1) > 0.4) {
        res = Math.round(random(prev - 1, prev + 1));
    } else {
        res = Math.round(random(0, 8));
    }
    if (lineX < w/5) {
        if (lineY < h/5) {
            if (random(0, 1) > 0.65) {
                res = Math.round(random(0, 2));
            }
        } else if (lineY > 4*h/5) {
            if (random(0, 1) > 0.65) {
                res = Math.round(random(-2, 0));
            }
        } else {
            if (random(0, 1) > 0.65) {
                res = Math.round(random(-2, 2));
            }
        }
    } else if (lineX > 4*w/5) {
        if (lineY < h/5) {
            if (random(0, 1) > 0.65) {
                res = Math.round(random(2, 4));
            }
        } else if (lineY > 4*h/5) {
            if (random(0, 1) > 0.65) {
                res = Math.round(random(4, 6));
            }
        } else {
            if (random(0, 1) > 0.65) {
                res = Math.round(random(2, 6));
            }
        }
    } else if (lineY < h/5) {
        if (random(0, 1) > 0.65) {
            res = Math.round(random(0, 4));
        }
    } else if (lineY > 4*h/5) {
        if (random(0, 1) > 0.65) {
            res = Math.round(random(4, 8));
        }
    }
    return res;
}
