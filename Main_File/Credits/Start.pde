//initialize Start class
class Start {
  //initialize variable for size of the stars
  PVector loc;
  float sz;
  //initialize variables for location and size of start button
  int rectX, rectY, W, H;
  //initialize arrays to store star locations
  float[] starX = new float[(width*height)/20000];
  float[] starY = new float[starX.length];
  //initialize variables to make stars fade
  float transparency;
  //initialize images
  PImage title;

  Start () {
    //set random location for the stars
    loc =  new PVector(random (0, width), random (0, height));
    //set size of the stars
    sz = 5;
    //set size and position of the start button
    W = 200;
    H = 75;
    rectX = width/2 - W/2;
    rectY = 2*height/3;
    //load images displaying titles
    title = loadImage ("MergedTitleLQ.png");
    transparency = 0;
  }

  void display () {
    //display white stars at location
    fill (255);
    if ((frameCount%35)==0) {
      for (int i = 0; i < starX.length; i++) {
        starX[i] = random(width);
        starY[i] = random(height);
      }
    }
    for (int i = 0; i < starX.length; i++) {
      transparency += 4;
      if(transparency>100){
       transparency = 0; 
      }
      fill(255,255,255,transparency);
      ellipse (starX[i], starY[i], sz, sz);
    }
  }

  void button () {
    //set settings for text
    textAlign (CENTER, CENTER);
    textSize (50);
    //change color of start button if moused over
    if (mouseX > rectX && mouseX < rectX + W && mouseY > rectY && mouseY < rectY + H) {
      fill (0, 255, 0);
    } else {
      fill (255, 0, 0);
    }
    //create rectangle for start button
    rect (rectX, rectY, W, H);
    fill (0);
    //display text for start button
    text ("START", width/2, 2*H/5 + rectY);
  }

  void title () {
    //display images for titles
    imageMode(CENTER);
    image (title, width/2, height/2);
  }
}

