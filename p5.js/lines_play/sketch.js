var lineX, lineY;
var angleIncrement;
var side, diagonal;

function setup() {
    createCanvas(1000, 800);
    background(255);
    stroke(0, 0, 0, 50);
    noFill();
    lineX = width/2;
    lineY = height/2;
    angleIncrement = PI/4;
    side = 10;
    diagonal = sqrt(200);
}

function draw() {
    var inside = false;
    while(!inside) {
        var increment = getIncrement(lineX, lineY, width, height);
        var lineLen;
        var xPos, yPos;
        if (increment % 2 == 0) {
            lineLen = side;
            console.log("side");
        } else {
            lineLen = diagonal;
            console.log("diagonal");
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
function getIncrement(lineX, lineY, w, h) {
    return Math.round(random(0, 7));
}
