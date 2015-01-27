//Initialize Missle class
class Missile {
  //Initialize variables to control movement and explosion of the missle
  PVector loc, vel;
  int sz = 25;
  float fc = 0;
  boolean exploding = false;

  Missile() {
    //Assign values to variables to control motion and explosion of the missle
    loc = new PVector(width/2 - movex, 4*height/5 - movey, height/(2* tan(PI/6)) - movez);
    vel = new PVector(0, 0, -20);
    fc = frameCount;
  }

  void make () {
    //Move the Missile
    if (frameCount - fc<80) {
      loc.add (vel);
    }

    translate (loc.x, loc.y, loc.z);
    fill (0, 255, 0 );

    //Change the color of the missle if it is exploding
    if (exploding) {
      fill (255, 0, 0);
    }

    //Display the Missile
    sphere (sz);
    translate (-1*loc.x, -1*loc.y, -1*loc.z);
  }

  void exploding() {
    //Make the missle grow in size when it explodes
    if (sz <= 250) {
      sz += 15;
    }
  }

  void hits (Eship tempship) {
    //If the missle hits an enemy ship, destroy the enemy ship
    tempship.shield = 0;
  }
}

