"use strict";

var lineX, lineY;
var angleIncrement;
var side, diagonal;
var increment;
var runAwayTimer;

function setup() {
    createCanvas(1000, 800);
    background(255);
    stroke(0, 0, 0, 10);
    line(width/5, 0, width/5, height);
    line(4*width/5, 0, 4*width/5, height);
    line(0, height/5, width, height/5);
    line(0, 4*height/5, width, 4*height/5);
    stroke(0, 0, 0, 50);
    noFill();
    lineX = width/2;
    lineY = height/2;
    angleIncrement = PI/4;
    side = 10;
    diagonal = sqrt(200);
    increment = getIncrement(Math.round(random(0, 7)), lineX, lineY, width, height);
}

function draw() {
    var inside = false;
    while(!inside) {
        increment = getIncrement(increment, lineX, lineY, width, height);
        var lineLen;
        var xPos, yPos;
        if (increment % 2 == 0) {
            lineLen = side;
        } else {
            lineLen = diagonal;
        }
        var angle = angleIncrement*increment;
        xPos = lineX + lineLen*cos(angleIncrement*increment);
        yPos = lineY + lineLen*sin(angleIncrement*increment);
        if (xPos < 0 || xPos > width || yPos < 0 || yPos > height) {
            inside = false;
        } else {
            inside = true;
        }
    }
    line(lineX, lineY, xPos, yPos);
    lineX = xPos;
    lineY = yPos;
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
