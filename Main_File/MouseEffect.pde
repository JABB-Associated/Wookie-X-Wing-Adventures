//Initialize MouseEffect class
class MouseEffect {
  //Initialize variables for the effect
  PVector loc, vel;
  float sz;

  //Initialize variable to remove the effect after time
  float timecapture;

  MouseEffect() {
    //Give the particle a position at the mouse and a random direction to move
    loc = new PVector (mouseX, mouseY);
    vel = new PVector (random(-1, 1), random(-1, 1));
    sz = 4;

    //Capture the time the particle was created
    timecapture = frameCount;
  }

  void display() {
    //Create the particle
    fill (255, 199, 103);
    ellipse (loc.x, loc.y, sz, sz);
  }

  void move () {
    //Move the particle
    loc.add (vel);
  }

  boolean disappear() {
    //If time has passed since the creation of the particle, return true for removal
    if ((frameCount - timecapture) > 10) {
      return true;
    } else {
      return false;
    }
  }
}

