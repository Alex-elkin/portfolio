class Rock {
  //Member Variables
  int x, y, diam, speed;
  PImage rock1;
  //Constructor
  Rock() {
    x= int(random(width));
    y =-100;
    diam = int(random(10, 100));
    speed=int(random(1, 10));
    if (random(10)>7) {
      rock1 =  loadImage("Rock1.png");
    } else if (random(10)>5) {
      rock1 =  loadImage("Rock2.png");
    } else {
      rock1 =  loadImage("Rock3.png");
    } 
  }

  //Member Methods
  void display() {
    imageMode(CENTER);


    
    rock1.resize(diam, diam);
    if(diam<1){
      diam = 10;
    }
    image(rock1,x,y);

  }
  void move() {
    y = y + speed;
  }

  boolean reachedBottom() {
    if (y>height+10) {
      return true;
    } else {
      return false;
    }
  }
}
