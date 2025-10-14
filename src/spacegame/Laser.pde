class Laser {
  //Member Variables
  int x, y, w, h, speed;
  //PImage laser;
  //Constructor
  Laser(int x, int y) {
    this.x=x;
    this.y=y;
    w=6;
    h=12;
    speed=5;
    //ship = loadImage("");
  }
  //Member Methods
  void display() {
    //laser = loadImage("laser.png");
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  void move() {
    y = y -speed;
  }

 

  boolean reachedTop() {
    if (y<-20) {
      return true;
    } else {
      return false;
    }
  }

  void fire() {

  }

  boolean intersect(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<50) {
      return true;
    } else
      return false;
  }
}
