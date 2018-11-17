import processing.video.*;

Capture webcam;

color trackingColor;

float threshold = 150;
float score = 0;
void setup() {
size(1920, 1080);
webcam = new Capture(this, 1920, 1080, Capture.list()[79]);
//webcam = new Capture(this,960, 540, "Logitech Webcam C930e #2");
webcam.start();
printArray(Capture.list());
trackingColor = color(0, 0, 255);

}

void captureEvent(Capture webcam) {
webcam.read();
webcam.loadPixels(); 
}

void draw() {

//if(webcam.available()){
// webcam.read();
// webcam.loadPixels(); 
//}
float matchX = 0;
float matchY = 0;

int counter = 0;

float triggerX1 = random(width);
float triggerY1 = random(height);

//...
image(webcam, 0, 0);
// background(255);
for (int x = 0; x < webcam.width; x++) {
for (int y = 0; y < webcam.height; y++) {
int loc = x + y * webcam.width;
color currentColor = webcam.pixels[loc];

float r1 = red(currentColor);
float g1 = green(currentColor);
float b1 = blue(currentColor);

float r2 = red(trackingColor);
float g2 = green(trackingColor);
float b2 = blue(trackingColor);

float colorDiff = dist(r1, g1, b1, r2, g2, b2);

if (colorDiff < threshold) {
matchX = x;
matchY = y;

counter++;
}
}
}

//if it found a blue pixel...
if(counter > 0){

fill(trackingColor);
ellipse(matchX, matchY, 40, 40);
}
for(int i = 0; i <2; i++){
fill(255, 0, 0);
ellipse(triggerX1, triggerY1, 40, 40);
}
if(dist(matchX, matchY, triggerX1, triggerY1) < 20){
score++;
background(0);
textSize(20);
text(score, width/2, height/2);
}


}
