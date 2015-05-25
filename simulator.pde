//  Author: Ryan Brigden
//  This program simulates charged particles in an environment with electromagnetic forces at play.

//  External Sources:
//  https://processing.org/examples/polartocartesian.html
//  https://processing.org/examples/bounce.html
//  https://processing.org/examples/spring.html
//  https://processing.org/examples/multipleparticlesystems.html
//  https://processing.org/examples/button.html
//  Asked Jake Herman about implementing multiple particles in simulation, advised me to separate update and draw methods.
//  He also helped me implement a technique to update the acceleration many times between frames in order to increase accuracy.
//  Abhinav Venigalla taught me how to change the color of specific objects (in this case the particles) by turning the fill on
//  before drawing and then switching it off immediately afterwards.

// Class Descriptions:
// Particle (xpos, ypos, xspeed, yspeed, charge, mass)
// MagneticField (xpos, ypos, height, width, strength)
// ElectricField (xpos, ypos, height, width, strength, direction (boolean) )

ArrayList<Particle> particles;
ArrayList<MagneticField> mag_fields;
ArrayList<ElectricField> electric_fields;

void setup() {
  // initialize particles and fields
  particles = new ArrayList<Particle>();
  mag_fields = new ArrayList<MagneticField>();
  electric_fields = new ArrayList<ElectricField>();

  // draw canvas
  size(1280, 640);
  stroke(255);

  // add magnetic fields to the system
  mag_fields.add(new MagneticField(0, 160, 320, 400, 1));
  mag_fields.add(new MagneticField(880, 160, 320, 400, 1));

  // add electric fields to the system
  electric_fields.add(new ElectricField(width/4 + 150, height/4, 300, 400, 5, true));

  // add particles to the system
  float xi = width/2;
  float yi = height/2;

//  particles.add(new Particle(20, 50, 4, -2, 1, 20));
//  particles.add(new Particle(width - 20, 50, -4, -2, 1, 20));
//  particles.add(new Particle(20, 500, 4, 0, -1, 20));
//  particles.add(new Particle(width - 20, 500 , 8, -2, -1, 20));
  
  addRandomParticles(4);

}

void draw() {
  background(155);

  // build magnetic fields
  for (MagneticField field : mag_fields) {
    field.buildField();
  }

  // build electric fields
  for (ElectricField field : electric_fields) {
    field.buildField();
  }

  int rad = 10;
  float dt = 0.001;

  for (Particle p : particles) {
    for (int i = 0; i < 1000; i++) {
      ArrayList<Particle> temp = new ArrayList<Particle>();
      for (Particle p2 : particles)
      {
        if (p2 != p) {
          temp.add(p2);
        }
      }
      p.update(dt, mag_fields, electric_fields, temp);
//      System.out.println(p.xpos + " " + p.ypos);
    }

    // if negatively charged
    if (p.charge < 0) {
      fill(#12D1FF);
      stroke(#12D1FF);
      ellipse(p.xpos, p.ypos, rad, rad);
      fill(155);
      stroke(255);
    }
    // if positively charged
    else if (p.charge > 0) {
      fill(#FF1515);
      stroke(#FF1515);
      ellipse(p.xpos, p.ypos, rad, rad);
      fill(155);
      stroke(255);
    }
    // if neutrally charged
    else {
      ellipse(p.xpos, p.ypos, rad, rad);
    }
  }
}

void addRandomParticles(int num)
{
  for (int i = 0; i < num; i++)
  {
    particles.add(new Particle((float) Math.random() * width, (float) Math.random() * height, (float) (Math.random() - 0.5) * 10, (float) (Math.random() - 0.5) * 10,
    (Math.random() > 0.5) ? -1.0 : 1.0, 20));
  }
}

