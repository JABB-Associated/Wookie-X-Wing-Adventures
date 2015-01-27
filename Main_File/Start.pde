//Initialize Start class
class Start {
  //Initialize variable for size of the stars
  PVector loc;
  float sz;

  //Initialize variables for location and size of start button
  int rectX, rectY, W, H;

  //Initialize arrays to store star locations
  float[] starX = new float [(width*height)/20000]; //Set number of stars proportional to the size of the screen
  float[] starY = new float [starX.length];

  //Initialize variables to make stars fade
  float transparency;

  //Initialize images
  PImage title;

  Start () {
    //Set random location for the stars
    loc =  new PVector (random (0, width), random (0, height));

    //Set size of the stars
    sz = 5;

    //Set size and position of the start button
    W = 200;
    H = 75;
    rectX = width/2 - W/2;
    rectY = 2*height/3;

    //Load images displaying titles
    title = loadImage ("MergedTitleLQ.png");
    transparency = 0;
  }

  void display () {
    //Display white stars at location
    fill (255);

    if ((frameCount%35) == 0) {
      //Set random location for stars
      for (int i = 0; i < starX.length; i++) {
        starX [i] = random (width);
        starY [i] = random (height);
      }
    }
    //Increase transparency of stars
    for (int i = 0; i < starX.length; i++) {
      transparency += 4;
      //Reset transparency
      if (transparency > 100) {
        transparency = 0;
      }
      //Make stars white and display
      fill (255, 255, 255, transparency);
      ellipse (starX [i], starY [i], sz, sz);
    }
  }

  void button () {
    //Set settings for text
    textAlign (CENTER, CENTER);
    textSize (50);

    //Change color of start button if moused over
    if (mouseX > rectX && mouseX < rectX + W && mouseY > rectY && mouseY < rectY + H) {
      fill (0, 255, 0);

      //If the mouse is pressed over the button, proceed to level 0
      if (mousePressed) {
        level = 0;
        instructionscreen = frameCount;
      }
    } else {
      fill (255, 0, 0);
    }

    //Create rectangle for start button
    rect (rectX, rectY, W, H);
    fill (0);

    //Display text for start button
    text ("START", width/2, 2*H/5 + rectY);
  }

  void title () {
    //Display images for titles
    imageMode (CENTER);
    image (title, width/2, height/2);
  }

  void death () {
    //Set text settings
    textAlign (CENTER, CENTER);
    textSize (40);

    cursor (HAND);

    //Change color of start button if moused over
    if (mouseX > rectX && mouseX < rectX + W && mouseY > rectY && mouseY < rectY + H) {
      fill (0, 255, 0);
      //If the mouse is pressed over the button, reset to level 1
      if (mousePressed) {
        level = 1;
        health = 1000;
        restart = false;
      }
    } else {
      fill (255, 0, 0);
    }
    //Create button for rectangle
    rect (rectX, rectY, W, H);

    //Display text for restart button
    fill (0);
    text ("RESTART", width/2, 3*H/7 + rectY);
    fill (255, 255, 0);
    textSize (150);
    text ("YOU LOSE!", width/2, height/5); //Fun end game message
  }
}

