class Elaser {
  PVector loc, vel, ploc;
  boolean dead;
  float created;
  float aimx;
  float aimy;
  float aimz; //These variables create a chance that the lasers miss

  Elaser(Eship shipy) {
    aimx = (random (-500, 500))/500;  //The bias factor is set. Notice that the chance of firing accurately is .5
    aimy = (random (-500, 500))/500;
    aimz = (random (-500, 500))/500;

    created = frameCount;//tells when the laser was made so it can be told to disappear after a certain time

    loc = new PVector (0, 0, 0);
    loc = shipy.loc.get (); //start at ship

    if (level == 2) {
      loc.add (-50, 50, -10); //compensates for different starting point
    }

    vel = new PVector (0, 0, 0);
    vel = loc.get ();
    vel.sub (width/2, height/2, height/(2*tan (PI/6))); //vel points toward the ship
    vel.add (movex, movey, movez); //compensate for ship movement
    vel.add ((round(aimx))*random (-500, 500), (round (aimy))*random (-500, 500), (round (aimz))*random (-500, 500)); //large/small numbers stay as 1, small ones get rounded to 0. Odds of firing accurately are 1/2.
    vel.mult (-1/frameRate); //vel is pointing in the wrong direction so it must be subtracted; also it should reach in one second.

    ploc = new PVector (0, 0, 0); //ploc is the starting point of the laser line
    ploc = loc.get ();
    ploc.sub (vel); //where the laser was one frame before-produces smoother motion
  } 

  void make () {
    //if(loc.x -width/2 <100 && loc.y- height/2<100 && loc.z-height/(2*tan(PI/6))<100){
    //println("YAYAYAYA");} //testing
    loc.add (vel);
    ploc.add (vel);

    fill (0, 255, 0);
    stroke (0, 255, 0);
    strokeWeight (5); //laser must be thick and green

    line (ploc.x, ploc.y, ploc.z, loc.x, loc.y, loc.z); //create laser

    noStroke (); //reset for other classes
    strokeWeight (1);
  }

  void hits () {
    health -= 5; //hitting the ship decreases health by 5
  }
}

