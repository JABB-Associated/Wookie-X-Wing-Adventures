//initialize Crosshairs class
class Crosshairs {

  Crosshairs () {
  } 

  void make () {
    //Initialize and assign value to control the size of the cursor based on distance firing
    float sz = 100/(1 - ((-3*height/ ((2*frameRate)*sq (zfire))*frameRate)/2078));
    //color the crosshair red
    stroke (255, 0, 0);
    fill (255, 0, 0);

    //Make crosshair display independently of ship's motion
    translate (-movex, -movey, -movez);

    //rotateX(-rotatey);
    //rotateY(-rotatex);

    //Create the crosshair in the middle of the map
    ellipse (width/2, height/2, sz/3, sz/3);

    //Creates an empty ring wihtin the red circle to create crosshair effect
    noFill ();
    ellipse (width/2, height/2, sz, sz);

    //Make crosshair display independently of ship's motion
    translate (movex, movey, movez);

    //rotateX(rotatey);
    //rotateY(rotatex);

    noStroke ();
  }
}

