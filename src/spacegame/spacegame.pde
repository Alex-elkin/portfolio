// Alex Elkin | 23 Sept 2025 | SpaceGame
Spaceship s1;
import processing.sound.*;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<PowerUp> powups = new ArrayList <PowerUp>();
Timer puTimer;
Timer rockTimer;
int score, rocksPassed, level, rtime;
boolean play;
PImage startscreen;
SoundFile laser, gameover, explosion;

void setup() {
  size(500, 500);
  startscreen= loadImage("startscreen.png");
  rtime = 2000;
  background(22);
  s1 = new Spaceship();
  puTimer = new Timer (5000);
  puTimer.start();
  rockTimer = new Timer(rtime);
  rockTimer.start();
  score = 0;
  rocksPassed = 0;
  play = false;
  level = 1;
  startscreen = loadImage("startscreen.png");
  laser = new SoundFile (this, "laser.wav");
  gameover = new SoundFile(this, "gameover.wav");
  explosion = new SoundFile(this, "explosion.wav");
}
void draw() {
  if (play == false) {
    startScreen();
  } else {
    background(22);

    //distributes a powerup on a timer
    if (puTimer.isFinished()) {
      powups.add(new PowerUp());
      puTimer.start();
    }
    stars.add(new Star());

    //Distributing rocks on timer
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockTimer.start();
    }

    for ( int i = 0; i < powups.size(); i++) {
      PowerUp pu = powups.get(i);
      pu.move();
      pu.display();

      if (pu.intersect(s1)) {
        // remove power up
        powups.remove(pu);
        // Based on type, benefit player
        if (pu.type == 'H') {
          s1.health+=100;
        } else if (pu.type == 'T') {
          s1.turretCount+=1;
          if (s1.turretCount>5) {
            s1.turretCount = 5;
          }
        } else if (pu.type == 'A') {
          s1.laserCount+=100;
        }
      }
      if (pu.reachedBottom()) {
        powups.remove(pu);
      }
    }
    //display of rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      //collision detection between rock and ship

      rock.display();
      rock.move();
      if (s1.intersect(rock)) {
        // remove rock
        rocks.remove(rock);
        //influence score
        score=score + rock.diam;
        //lower health of ship
        s1.health-= rock.diam;
      }
      if (rock.reachedBottom()==true) {
        rocks.remove(rock);
        i--;
        rocksPassed++;
      }
    }

    //display of strs
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      star.display();
      star.move();
      if (star.reachedBottom()) {
        stars.remove(star);
      }
    }
    //display of lasers
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      for (int j = 0; j<rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (laser.intersect(r)) {
          //reduce hitpoints on rock
          r.diam = r.diam-40;
          if (r.diam<5) {
            rocks.remove(r);
            score = score+1;
          }

          //remove the laser
          lasers.remove(laser);
        }
      }
      laser.display();
      laser.move();
      if (laser.reachedTop()==true) {
        lasers.remove(laser);
      }
    }
    //println(rocks.size);



    s1.display();
    s1.move(mouseX, mouseY);

    infoPanel();
  }
  if (s1.health<1) {
    gameOver();
  }
  if (rocksPassed>10) {
    level ++;
    rtime -=10;
  } else if (rocksPassed>20) {
    level++;
  }
}


void mousePressed() {
  if (laser.isPlaying()) {
    laser.stop();
  } else {
    laser.play();
    if (s1.turretCount == 1) {
      lasers.add(new Laser(s1.x, s1.y));
    } else if (s1.turretCount == 2) {
      lasers.add(new Laser(s1.x-10, s1.y));
      lasers.add(new Laser(s1.x+10, s1.y));
    } else if (s1.turretCount == 3) {
      lasers.add(new Laser(s1.x-10, s1.y));
      lasers.add(new Laser(s1.x+10, s1.y));
      lasers.add(new Laser(s1.x, s1.y));
    }
  }
}
void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  rect(width/2, height-25, width, 50);
  textSize(25);
  fill(255);
  text("Health: " +s1.health, 350, height-20);
  text("Ammo:"+s1.laserCount, 200, height -20);
  text("Score:" + score, 30, width-470);
  text("Passed Rocks: "+rocksPassed, width-200, 30);
  text("Turrets: " + s1.turretCount, width-180, 475);
}

void startScreen() {
  image(startscreen, 0, 0);
  fill(255);
  text("click to start", width/2, height/2);
  if (mousePressed) {
  }
  play = true;
}
void gameOver() {

  background(0);
  fill(255);
  text("Game Over!", width/2, height/2);
  gameover.play();
  noLoop();
}
