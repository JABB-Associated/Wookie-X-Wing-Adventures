//Initialize for start button
ArrayList<Start> START = new ArrayList<Start>();
//Initialize for mouse effect
ArrayList<MouseEffect> Shimmer = new ArrayList<MouseEffect>();
int x1;

int y1[] = new int [20];
StringList credits;

void setup () {
  size (displayWidth, displayHeight);
  textAlign (CENTER, CENTER); 
  textSize (40);
  START.add (new Start ());


  credits = new StringList();

  credits.append ("Credits");
  credits.append (" ");
  credits.append ("Josh Bochner - Project Manager");
  credits.append ("Bruno Avritzer - Lead Programmer");
  credits.append ("Ben Liang - Graphics and UI Designer");
  credits.append ("Adel Setoodehnia - QA Tester");
  credits.append (" ");
  credits.append ("Intro to Programming - Ms. Gerstein");
  credits.append (" ");
  credits.append ("Inspired by George Lucas' 'Star Wars'");
  credits.append ("Special Thanks to the Internet for Images");
  credits.append (" ");
  credits.append ("Shout Out To:");
  credits.append (" ");
  credits.append ("Jay Patel - Photoshop");
  credits.append ("Marcus Moore - 3DS Max");
  credits.append ("Eric Matrone - Batman");
  credits.append ("Pavan Patel - Head Custodian");
  credits.append (" ");
  credits.append("John Williams - Music (Used Without Permission)");
  credits.append(" ");
  credits.append ("THE END");

  x1 = width/2;
  for (int i=0; i<20; i++) {
    y1[i] = height + 60*i;
  }
}

void draw () {
  
 
  background (0);
   text(frameCount, 500,500);
  //create the mouse effect
  for (int i = 0; i < 15; i++) {
    Shimmer.add (new MouseEffect ());
  }
  for (int i = 0; i < Shimmer.size (); i++) {
    MouseEffect sparkles = Shimmer.get(i);
    sparkles.display();
    sparkles.move();
    //remove older mouse effects
    if (sparkles.disappear()) {
      Shimmer.remove(i);
    }
  }
  //create start button, title, and background stars
  for (int i = 0; i < START.size (); i++) { 
    Start alpha = START.get(i); 
    alpha.display();
    //remove stars (this causes the blinking)
    if (START.size ()> 50) {
      START.remove(i);
    }
  }
  fill (255, 255, 0);
  for (int i=0; i<20; i++) {

    if (i==0) {
      fill (0, 255, 255);
      textSize (60);
    }

    if (i==2) {
      fill (255, 255, 0);
      textSize (40);
    }

    if (i==12) {
      fill (0, 255, 255);
      textSize (50);
    }

    if (i==14) {
      fill (255, 255, 0);
      textSize (30);
    }
    
    if (i==19) {
      fill (0, 255, 255);
      textSize (70);
    }

    String line = credits.get(i);
    text (line, x1, y1[i]);
    y1[i] -= 2;
  }
}

