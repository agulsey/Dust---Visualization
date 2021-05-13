class ParticleSystem {
  ArrayList<Particle> particles;
  FlowField flowfield;
  float particleSize;
  ParticleSystem(FlowField ff, float _particleSize) {
    flowfield = ff;
    particleSize = _particleSize;
    particles = new ArrayList<Particle>();
  }


  void addParticle() {
    PVector start = new PVector(random(width), random(height));
    particles.add(new Particle(start, random(0.2, 3)));
  }

  void showParticles(int nextAmount) {
    int curAmount = particles.size();
    float diff = nextAmount - curAmount;
    if (diff > 0) {
      for (int i = 0; i < diff; i++) {
        PVector start = new PVector(random(width), random(height));
        particles.add(new Particle(start, random(0.2, 3)));
      }
    } else {
      for (int i = curAmount-1; i > curAmount+diff; i--) {
        particles.remove(i);
      }
    }
  }

  void run() {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.follow(flowfield);
      p.run(particleSize);
    }
  }
}
