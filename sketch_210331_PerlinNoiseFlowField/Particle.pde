public class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  float maxSpeed;
  boolean visible;
  int MAX2 = 70;
  float valuePar = 0.0;

  Particle(PVector start, float maxspeed) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    visible = true;
  }
  void run(float particleSize) {
    update();
    edges();
    show(particleSize);
  }
  void update() {
    pos.add(vel);
    vel.limit(maxSpeed);
    vel.add(acc);
    acc.mult(0);
  }
  void applyForce(PVector force) {
    acc.add(force);
  }
  void show(float particleSize) {
    if (visible) {
      //img = loadImage("dust_01.png");
      if (valuePar < MAX2) {
        valuePar+=speed;
        float fadePar = sin(radians(valuePar))*MAX2;
        stroke(255, fadePar);
      } else {
        stroke(255, 70);
      }
      particleSize = particleSize + (random(4) - 2);
      strokeWeight(particleSize);
      point(pos.x, pos.y);
      //int ps = int(particleSize);
      //img.resize(10,10);
      //image(img,pos.x, pos.y );
    }
  }
  void display() {
    visible = true;
  }
  void hide() {
    visible = false;
  }
  void edges() {
    if (pos.x > width) {
      pos.x = 0;
    }
    if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y > height) {
      pos.y = 0;
    }
    if (pos.y < 0) {
      pos.y = height;
    }
  }
  void follow(FlowField flowfield) {
    int x = floor(pos.x / flowfield.scl);
    int y = floor(pos.y / flowfield.scl);
    int index = x + y * flowfield.cols;

    PVector force = flowfield.vectors[index];
    applyForce(force);
  }
}
