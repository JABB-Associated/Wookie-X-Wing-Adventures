//CONTAINS TESTING CODE IN ADDITION TO FINAL CODE
//TESTING CODE IS COMMENTED OUT

//Audio Files
import ddf.minim.*;
AudioPlayer DuelofFates; //Game Music
AudioPlayer IntroMusic; //Intro Music
//AudioPlayer VictoryMusic; //Victory Music
Minim minim;

//////////////////////////////////////////////
//NOTE: All fc variables are timer variables//
//NOTE: Make void was used to make objects  //
//////////////////////////////////////////////

//Credits Variables
int x1; //x of scrolling text
int credittime = 0; //Timer during Credits
int y1 [] = new int [20]; //Array for controlling y-coordinates of credits
StringList credits; //Contains credits text
boolean creditstart = false; //Boolean to Start Credits
float fc7 = 0; //Timer variable for level transition
boolean fren = false; //Variable used to test a single condition for level transition


int health = 1000; //Ship health

//PShape deathstar; 
//PShape Boss1;

PShape Destroyer; //Star Destroyer
PShape Tiebomber; //Tie Bomber ship
PShape Tiefighter; //Tiefighter

PImage Ewok; //Ewok

//PImage cockpit;

//Initialize for Start Button
ArrayList<Start> START = new ArrayList <Start>();

//Initialize for Mouse Effect
ArrayList <MouseEffect> Shimmer = new ArrayList <MouseEffect> ();
ArrayList <Elaser> elasers = new ArrayList <Elaser> ();

//Initialize for Lasers, enemy ships, and missiles
ArrayList <Laser> lasers = new ArrayList <Laser> ();
ArrayList <Eship> eships = new ArrayList <Eship> ();
ArrayList <Missile> missiles = new ArrayList <Missile> ();

int missilecount = 0; //Number of missiles

//float fc=0;
//fcs are timers
float fc1 = -20;
float fc2 = -50;

int score = 0; //Score

//boolean shipoff=false;

int movex = 0; //Move variables control movement of ship
int movey = 0;
int movez = 0;

//Rotating View
//int rotatex;
//int rotatey;

boolean keys [] = new boolean [255]; //Managing Keyboard Inputs

Crosshairs ch = new Crosshairs (); //Crosshair

boolean addmiss = true; //Checks for duplicate missile addition

float zfire = (tan(PI/6)); //Sets angle of laser firing in Z-direction

int level = -1; //Controls level of game

boolean makeships = true; //Tells whether to make ships

float fc8 = 0; //Timer

boolean restart = false; //Restart Boolean

int pscore = 0; //For telling to skip levels

//Tells to reset matrix in instruction screen
// boolean reset = false;

float instructionscreen = 0; //Times between instruction screen and scrolling text
int x; //X Location of Scroll Text
int y [] = new int [7]; //Y Location of Scroll Text
int z [] = new int [7]; //Z Location of Scroll Text
StringList starwarstext; //Contains Scroll Text

//Skip Level Timer for Testing Purposes
//int f9 = 0; 

void setup() { 
  noCursor();
  noStroke();

  //Audio
  minim = new Minim (this);
  DuelofFates = minim.loadFile ("Duel of Fates.mp3", 512);
  IntroMusic = minim.loadFile ("IntroMusic.mp3", 5048);
  //VictoryMusic = minim.loadFile ("StarWarsVictoryEnding.mp3", 512);

  //Enemy Ships
  Tiefighter = loadShape ("Tiefighter.obj");
  Tiebomber = loadShape ("Tie Super.obj");
  Destroyer = loadShape ("Imperial Class Destroyer.obj");

  Ewok = loadImage ("Ewok.png");

  //cockpit = loadImage("maxresdefault.png");
  size (displayWidth, displayHeight, P3D);
  START.add (new Start());
  x = width/2;

  for (int i = 0; i < y.length; i++) {
    y [i] = 3*height/2 + 140*i;
    z [i] = -10*i; //initialize variables for scrolling text
  }
}

void draw() {
  if (!restart) {//if game restarts reset variables
    movex = 0;
    movey = 0;
    movez = 0;
    missilecount = 0;
    restart = true;
  }
  if (level > 3) { //if not playing game reset game variables and objects
    while (eships.size () > 0) {
      eships.remove (0);
    }
    while (elasers.size () > 0) {
      elasers.remove (0);
    }
    while (lasers.size () > 0) {
      lasers.remove (0);
    }
    while (missiles.size () > 0) {
      missiles.remove (0);
    }
  }
  frameRate (60);
  background (0);
  textAlign (LEFT, LEFT);
  // for testing

  //if (keys[UP] && frameCount-f9 >= 90) {
  //if (level < 6) {
  //  level++;
  //  f9 = frameCount;
  //  } else {
  //   level = 1;
  //  }
  //  }
  //  //more testing
  //  if(wavetime && key == 't'){
  //    bosstime = true;
  //    wavetime = false;}
  if (level < 1) { //play intro music

    if (!IntroMusic.isPlaying ()) { //loop intro music
      IntroMusic.rewind (); 
      IntroMusic.play ();
    }
  }

  if (level > 0) { //end intro music
    IntroMusic.pause ();
  }

  if (level == -1) { //start screen
    //add start button


    //create start button, title, and background stars
    for (int i = 0; i < START.size (); i++) { 
      Start alpha = START.get (i); 
      alpha.display ();
      alpha.button ();
      alpha.title ();


      //remove stars (this causes the blinking)
      if (START.size () > 50) {
        START.remove (i);
      }
    }  

    //create the mouse effect
    for (int i = 0; i < 15; i++) {
      Shimmer.add (new MouseEffect ());
    }
    for (int i = 0; i < Shimmer.size (); i++) {
      MouseEffect sparkles = Shimmer.get (i);
      sparkles.display ();
      sparkles.move ();
      //remove older mouse effects
      if (sparkles.disappear ()) {
        Shimmer.remove (i);
      }
    }
  }

  //remove shimmers and start screen after intro screens
  if (level > 0 && level <= 3) { 

    while (START.size () > 0 && level > -1) {
      START.remove (0);
    } 

    while (Shimmer.size () > 0 && level > -1) {
      Shimmer.remove (0);
    }
  }

  if (level == 0 ) { //if less than 1200 frames pass, stay on scrolling text

    if (frameCount - instructionscreen < 1200) {
      textSize (60);
      textAlign (CENTER, CENTER);

      starwarstext = new StringList();

      starwarstext.append ("The empire had seized control of the galaxy. As");
      starwarstext.append ("systems fell, one after the other, the only hope was");
      starwarstext.append ("for a hero. You are this hero, not a human, but a Wookiee.");
      starwarstext.append ("You must fight back against Darth Bruno and the Empire of"); 
      starwarstext.append ("Bruyesia. As you fly your ship through the galaxy, you must defeat");
      starwarstext.append ("your enemies as you close ever nearer to your ultimate objective.");
      starwarstext.append ("Good luck, young Wookiee, and May the Force be with you!");

      background (0);

      if (!fren) { //this boolean fren makes it so that fc7 is only updated once; fc7 serves as a timer
        fc7 = frameCount; 
        fren = true;
      }
      fill (0, 255, 255);

      if (frameCount - fc7 < 2*frameRate) { //for 2 seconds, display first text
        text ("A long time ago in a galaxy far, far away....", x, height/6, -50);
      }

      rotateX (PI/3); //slants text
      //pushMatrix();

      fill (255, 255, 0);

      for (int i = starwarstext.size () -1; i >=0; i--) {
        String mytext = starwarstext.get (i);
        text (mytext, width/2, y[i], z[i]);

        if (y[0] > -2500) { //makes text scroll up the screen
          y[i] -= 3;
          z[i] -= 1.5;
        } else { //makes text zoom up faster later on
          y[i] -= 30;
          z[i] -= 15;
        }
      }
      //popMatrix();
    } else {
      //
      //      if (!reset) {
      //        resetMatrix();
      //        reset= true;
      //      }
      textSize (24); 
      fill (255, 255, 0);
      textAlign (CENTER, CENTER);
      //display instructions
      text ("Destroy all enemies in a wave to advance to the next one. \nDefeat all three waves to win!\n Enemies will fire at you, lowering your blue health bar at the top left. \nThe top right represents the number of missiles available.\n \nMove in 3-D with 'WASD' and 'ZX' \nPress 'O' to fire lasers \nPress 'I' to fire missiles \nPress 'K' to scope in \nPress 'P' to scope out \nPress 'L' to go back to default scope. \n \nClick anywhere to continue.", width/2, height/2);

      if (mousePressed && frameCount - instructionscreen > 1200) { //if you're on instructions and mouse is pressed go to level 1
        level = 1;
      }
    }
  }

  if (level > 0 && level <= 3) {
    noCursor ();

    if (!DuelofFates.isPlaying ()) {    //Loop Duel of Fates Soundtrack for level one to three
      DuelofFates.rewind ();
      DuelofFates.play ();
    }

    if (health > 150) {
      fill (0, 0, 255); //health bar turns red on low health
    } else {
      fill (255, 0, 0);
    }

    rect (50, 120, 20, -health/10); //health bar
    fill (0, 255, 0);
    rect (width-120, 120, 20, -20*(score%5)); //shows how close to getting missiles you are

    noStroke ();
    textSize (30);
    text (score, 150, 100); //display score
    text ("MISSILES" + " " + missilecount, width - 300, 100); // display number of missiles
    textSize (15);
    text (health, 40, 15);
    textSize (20);

    text ("Range:" + -1*round (-3*height/ ((2*frameRate) *zfire)*frameRate) + "meters", width - 225, height/2);
    textSize (30);
    //image(cockpit, 0,0);

    if (score%5 == 0 && score!= 0 && addmiss == false) { //awards you with a missile if this is your first time reaching that multiple of 5 (score)
      missilecount += 2;
      addmiss = true; //addmiss is there to prevent multiple additions of missiles per enemy
    }

    update (); //updates input-based things

    translate (movex, movey, movez); //moves all objects relative to movement of controls
    //    rotateX(rotatey);
    //    rotateY(rotatex);

    if (// (frameCount - fc > 20 || shipoff) && eships.size () <= 15) {
    eships.size () + score-pscore <= 14 && makeships == true) {
      eships.add (new Eship());
      // fc=frameCount;
      //shipoff=false;
    }

    if (eships.size() == 0 && level < 4 && frameCount - fc8 > 100) {
      level++;
      makeships = true;
      fc8 = frameCount;
      pscore = score;
      movex = 0;
      movey = 0;
      movez = 0; //level up procedure; move goes to zero so ships spawn near you
    }

    //ship-laser detection loop
    for (int i = eships.size () - 1; i >= 0; i--) {
      Eship myship = eships.get (i);

      for (int j=lasers.size () - 1; j >= 0; j--) {
        Laser mylase = lasers.get (j);

        if (dist (myship.loc.x, myship.loc.y, myship.loc.z, mylase.loc.x, mylase.loc.y, mylase.loc.z) <= myship.sz) {
          mylase.hits (myship);
        }
      }

      //ship-missile detection loop
      for (int k = missiles.size () - 1; k >= 0; k--) {
        Missile mymiss = missiles.get (k);
        fill (0, 255, 0);

        if (dist (mymiss.loc.x, mymiss.loc.y, mymiss.loc.z, myship.loc.x, myship.loc.y, myship.loc.z) <= myship.sz + mymiss.sz) {
          mymiss.hits (myship);
          mymiss.exploding = true; //missiles explode if they hit a ship
        }
      }
    }

    for (int i = eships.size () - 1; i>=0; i--) {
      Eship myship = eships.get (i);
      myship.make ();

      //if ship dies remove it
      if (myship.dead) {
        eships.remove (myship);
      }

      //if ship goes beonda certain point reverse velocity
      if (myship.loc.z >= 6*height/(2*tan(PI/6)) ) {
        myship.vel.z = -abs(myship.vel.z);
      }

      if (myship.loc.z <= -6*height/(2*tan(PI/6))) {
        myship.vel.z = abs(myship.vel.z);
      }

      if (frameCount - myship.firingtimer > 60) { //fire every 60 frames
        elasers.add (new Elaser(myship));
        myship.firingtimer = frameCount;
      }
    }

    for (int j=lasers.size () - 1; j > 1; j--) { //make my lasers
      Laser mylase = lasers.get(j);
      mylase.make ();

      if (frameCount - mylase.create > (mylase.framerater) || mylase.death) { //if laser is on screen too long get rid of it
        lasers.remove (mylase);
      }

      stroke (255, 0, 0);
      strokeWeight (1);//reset stroke for crosshairs
      ch.make ();
    }

    for (int k = missiles.size () - 1; k >= 0; k--) {
      Missile mymiss=missiles.get (k);
      mymiss.make ();

      if (frameCount - mymiss.fc > 80 || mymiss.exploding == true) { //after 80 frames if exploding explode
        mymiss.exploding ();

        if (frameCount - mymiss.fc > 120) { //missile dies after 120 frames
          missiles.remove (mymiss);
        }
      }
    }

    for ( int i = elasers.size () - 1; i >= 0; i--) {
      Elaser elase = elasers.get (i);
      elase.make ();

      if (dist (elase.loc.x, elase.loc.y, elase.loc.z, width/2 - movex, height/2 - movey, height/(2*tan(PI/6))- movez) < 50) { //elaser hits if it gets close enough to you
        elase.hits ();
      }

      if (frameCount - elase.created > 5*frameRate) { //remove lasers after 5 seconds
        elasers.remove (elase);
      }
    }

    stroke (255, 0, 0);
    strokeWeight (1);
    ch.make ();

    if (health <= 0) {
      level = 5;
    }
  }

  if (level == 5) {

    if (START.size ()== 0) {
      START.add (new Start());
    }

    Start mystart = START.get (0);

    mystart.death ();
  }

  if (level == 4) {
    
    //VictoryMusic.play();  //play victory music

    if (frameCount - credittime >= 0 && START.size () == 0) { // add start for credits
      START.add (new Start());
    }

    if (!creditstart) { //display credits
      credittime = frameCount;
      credits = new StringList ();
      textAlign (CENTER, CENTER);

      credits.append ("Credits");
      credits.append (" ");
      credits.append ("Josh Bochner - Project Manager");
      credits.append ("Bruno Avritzer - Lead Programmer");
      credits.append ("Ben Liang - Graphics and UI Designer");
      credits.append ("Adel Setoodehnia - QA Tester");
      credits.append (" ");
      credits.append ("Intro to Programming - Mrs. Gerstein");
      credits.append (" ");
      credits.append ("Inspired by George Lucas' 'Star Wars'");
      credits.append ("Special Thanks to the Internet for Images");
      credits.append (" ");
      credits.append ("Shout Out To:");
      credits.append (" ");
      credits.append ("Jay Patel - Photoshop");
      credits.append ("Marcus Moore - 3DS Max");
      credits.append ("Pavan and Eric - Custodial Staff");
      credits.append ("John Williams - Music - Used Without Permission");
      credits.append (" ");
      credits.append ("THE END");

      x1 = width/2;

      for (int i = 0; i < 20; i++) { //space font along lines
        y1[i] = height + 60*i;
      }

      creditstart = true; //only displays credits once
    }

    textAlign (CENTER, CENTER);

    //create the mouse effect
    for (int i = 0; i < 15; i++) {
      Shimmer.add (new MouseEffect ());
    }

    for (int i = 0; i < Shimmer.size (); i++) {
      MouseEffect sparkles = Shimmer.get (i);
      sparkles.display ();
      sparkles.move ();
      //remove older mouse effects
      if (sparkles.disappear ()) {
        Shimmer.remove (i);
      }
    }

    //use previous method of creating the start button, title, and background stars JUST to display the background stars
    for (int i = 0; i < START.size (); i++) { 
      Start alpha = START.get (i); 
      alpha.display ();

      //remove stars (this causes the blinking)
      if (START.size () > 50) {
        START.remove (i);
      }
    }

    fill (255, 255, 0);

    for (int i = 0; i < 20; i++) { //size depends on line

      if (i== 0) {
        fill (0, 255, 255);
        textSize (60);
      }

      if (i == 2) {
        fill (255, 255, 0);
        textSize (40);
      }

      if (i == 12) {
        fill (0, 255, 255);
        textSize (50);
      }

      if (i == 14) {
        fill (255, 255, 0);
        textSize (30);
      }

      if (i == 19) {
        fill (0, 255, 255);
        textSize (70);
      }

      String line = credits.get (i); //display credits
      text (line, x1, y1[i]);
      y1[i] -= 2; //scroll up
    }

    if (frameCount - credittime > 1200) { //Display Ultimate Goal
      text ("You Saved the Ewok King!", width/2, height/5);
      image (Ewok, width/2, height/2);
    }

    if (frameCount - credittime > 1500) { //After 1500 frames exit game from credits
      exit();
    }
  }
}



void keyPressed() {
  if (level > 0) {

    if (keyPressed) {

      if ((key == 'O' || key== 'o') && frameCount - fc1 >= 10) { //make lasers if o pressed
        //Blaster.rewind ();
        //Blaster.play ();
        lasers.add (new Laser (1));
        lasers.add (new Laser (2));
        lasers.add (new Laser (3));
        lasers.add (new Laser (4));
        fc1 = frameCount;
      }

      if ((key == 'I' || key == 'i') && frameCount - fc2 >= 50 && missilecount >= 1) { //shoot with i, but obviously has to wait
        missiles.add (new Missile());
        fc2 = frameCount;

        if (missilecount > 0) {
          missilecount--;
        }
      }

      if (key!= CODED) { //stops errors with keys boolean from unwanted type & register key input
        keys [key] = true;
      }

      if (key == CODED) { //stop errors with keys boolean unwanted type & register key input
        keys [keyCode] = true;
      }
    }
  }
}

void keyReleased () {
  if (level > 0) {

    if (key!= CODED) {
      keys [key] =false;
    }

    if (key == CODED) {
      keys [keyCode] = false;
    }
  }
}

void update () {
  if (level > 0) {

    if ((keys ['k'] || keys ['K']) && zfire - tan (PI/6) <= 250) { //if k pressed scope in to a certain limit

      if (3*height/ ((2*frameRate)*zfire)*frameRate > 500) {
        zfire *= 1.0157;
      } else { //makes transition smoother for scoping (not linear)
        zfire *= 1.09;
      }
    }

    if ((keys ['P'] || keys ['p']) && zfire - tan (PI/6) >= .004) { //if p pressed scope out to certain limit

      if (3*height/ ((2*frameRate)*zfire)*frameRate > 500) {
        zfire /= 1.0157;
      } else {//makes transition smoother for scoping (not linear)
        zfire /= 1.09;
      }
    }

    if (keys ['l'] || keys ['L']) { //l resets default scope
      zfire = tan (PI/6) ;
    }

    if (keys ['w'] || keys ['W']) { //w move up
      movey += 10;
    }

    if (keys ['s'] || keys ['S']) { // s moves down
      movey -= 10;
    }

    if (keys ['d'] || keys ['D']) { //d moves right
      movex -= 10;
    }

    if (keys ['a'] || keys ['A']) { //a moves left
      movex += 10;
    }

    if (keys ['z'] || keys ['Z']) { //z moves in
      movez += 10;
    }

    if (keys ['x'] || keys ['X']) { //x moves out
      movez -= 10;
    }

    //    if (keys[UP]) {
    //      rotatey+=PI/6;
    //    }
    //
    //    if (keys[DOWN]) {
    //      rotatey-=PI/6;
    //    }
    //
    //    if (keys[LEFT]) {
    //      rotatex-=PI/6;
    //    }
    //
    //    if (keys[RIGHT]) {
    //      rotatex+=PI/6;
    //    }
  }
}

