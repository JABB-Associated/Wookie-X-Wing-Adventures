//Initialize Laser class
class Laser {
  //Initialize variables to control the position and movement of the lasers
  PVector loc, vel, ploc;
  float create;

  //Initialize variables to control the disappearance of the lasers and the destruction of enemies
  boolean death = false;
  boolean moved = false;

  //Initialize variable to compensate for lag
  float framerater;

  Laser (int lasernum) {
    //Assign value to variable to compensate for lag
    framerater = frameRate; //note that this is an approximation for lag

    //CREATE AND MOVE LASERS FROM FOUR CORNERS
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (lasernum == 1) { //Bottom Right Corner, Move Left and Up
      loc = new PVector(width - movex, height - movey, height/(2*zfire) - movez);
      vel = new PVector(-1*width/(2*framerater), -1*height/(2*framerater), -3*height/((2*framerater)*zfire));  
      ploc= new PVector(loc.x + width/(2*framerater), loc.y + height/(2*framerater), loc.z + 3*height/((2*framerater)*zfire));
    }

    if (lasernum == 2) { //Bottom Left Corner, Move Right and Up
      loc = new PVector(0 - movex, height - movey, height/(2* zfire) - movez);
      vel = new PVector(width/(2*framerater), -1*height/(2*framerater), -3*height/((2*framerater)*zfire));
      ploc= new PVector(loc.x - width/(2*framerater), loc.y + height/(2*framerater), loc.z + 3*height/((2*framerater)*zfire));
    }

    if (lasernum == 3) { //Top Left Corner, Move Right and Down
      loc = new PVector(0 - movex, 0 - movey, height/(2* zfire) - movez);
      vel = new PVector(width/(2*framerater), height/(2*framerater), -3*height/((2*framerater)*zfire)); 
      ploc= new PVector(loc.x - width/(2*framerater), loc.y - height/(2*framerater), loc.z + 3*height/((2*framerater)*zfire));
    }

    if (lasernum == 4) { //Top Right Corner, Move Left and Down
      loc = new PVector(width - movex, 0 - movey, height/(2* zfire) - movez);
      vel = new PVector(-1*width/(2*framerater), height/(2*framerater), -3*height/((2*framerater)*zfire));
      ploc= new PVector(loc.x + width/(2*framerater), loc.y - height/(2*framerater), loc.z + 3*height/((2*framerater)*zfire));
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Assign value to help with removal of lasers
    create = frameCount;
  }

  void make () {
    //Adjust the appearance of the lasers' thickness
    strokeWeight (4);

    //Move the Lasers
    loc.add (vel);
    ploc.add (vel);

    //Make the lasers red
    fill (255, 0, 0);
    stroke (255, 0, 0);

    //Draw the lasers
    line (ploc.x, ploc.y, ploc.z, loc.x, loc.y, loc.z); 

    strokeWeight (1);
    noStroke ();
  }

  void hits (Eship tship) {
    //If the laser hits an enemy ship, subtract from the enemy shields and remove the laser
    tship.shield--;
    death = true;
  }
}

