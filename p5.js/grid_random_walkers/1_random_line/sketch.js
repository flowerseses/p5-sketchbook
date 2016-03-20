"use strict";

var lineX, lineY;
var angleIncrement;
var side, diagonal;
var increment;
var prevX, prevY;


function setup() {
    createCanvas(1000, 800);
    colorMode(HSB, 100);
    frameRate(20);
    background(0, 0, 100);
    stroke(0, 0, 0, 50);

    angleIncrement = PI/4;
    side = 10;
    diagonal = sqrt(2*sq(side));

    prevX = width/2;
    prevY = height/2
    increment = getIncrement(Math.round(random(0, 7)), prevX, prevY, width, height);
    noFill();
}

function draw() {
    var inside = false;
    while(!inside) {
        increment = getIncrement(increment, prevX, prevY, width, height);
        var lineLen;
        var xPos, yPos;
        if (increment % 2 == 0) {
            lineLen = side;
        } else {
            lineLen = diagonal;
        }
        var angle = angleIncrement*increment;
        xPos = prevX + lineLen*cos(angle);
        yPos = prevY + lineLen*sin(angle);
        if (xPos < 0 || xPos > width || yPos < 0 || yPos > height) {
            inside = false;
        } else {
            inside = true;
        }
    }
    stroke(0, 0, 0, 50)
    line(prevX, prevY, xPos, yPos);
    prevX = xPos;
    prevY = yPos;
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
