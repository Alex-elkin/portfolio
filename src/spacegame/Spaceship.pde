class Spaceship {
  //Member Variables
  int x, y, w, laserCount, turretCount, health;
  //PImage ship;
  //Constructor
  Spaceship() {
    x = width/2;
    y = height/2;
    w = 100;
    laserCount = 10;
    turretCount = 1;
    health = 10;
    //ship = loadImage("");
  }
  //Member Methods
  void display() {
    imageMode(CENTER);
    //image(ship,x,y);
    stroke(222);
    strokeWeight(3);
    stroke(255, 0, 0);
    fill(255, 0, 0);
    triangle(x-10, y+35, x+10, y+35, x, y+65);
    stroke(250, 136, 32);
    fill(250, 136, 32);
    triangle(x-7, y+40, x+7, y+40, x, y+67);
    stroke(250, 214, 32);
    fill(250, 214, 32);
    triangle(x-2, y+50, x+2, y+50, x, y+65);
    stroke(222);
    fill(255);
    triangle(x, y-15, x-30, y+35, x+30, y+35);
    fill(150);
    stroke(120);
    ellipse(x-15, y+10, 15, 60);
    ellipse(x+15, y+10, 15, 60);
    stroke(222);
    fill(255);
    ellipse(x, y, 20, 80);
    fill(89, 191, 240);
    strokeWeight(1);
    stroke(56, 137, 214);
    ellipse(x, y-30, 12, 10);
  }

  void move(int x, int y) {
    this.x = x;
    this.y =y;
  }

  boolean fire() {
    if (laserCount>0) {
      return true;
    } else {
      return false;
    }
  }

   boolean intersect(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<50) {
      return true;
    } else
      return false;
  }
}
