//  Author: Ryan Brigden
//  This program simulates charged particles in an environment with electromagnetic forces at play.

//  External Sources:
//  https://processing.org/examples/polartocartesian.html
//  https://processing.org/examples/bounce.html
//  https://processing.org/examples/spring.html
//  https://processing.org/examples/multipleparticlesystems.html
//  https://processing.org/examples/button.html
//  http://www.lagers.org.uk/g4p/
//  https://processing.org/tutorials/data/
//  Asked Jake Herman about implementing multiple particles in simulation, advised me to separate update and draw methods.
//  He also helped me implement a technique to update the acceleration many times between frames in order to increase accuracy.
//  Abhinav Venigalla taught me how to change the color of specific objects (in this case the particles) by turning the fill on
//  before drawing and then switching it off immediately afterwards.

// Class Constructors:
// Particle (xpos, ypos, xspeed, yspeed, charge, mass)
// MagneticField (xpos, ypos, height, width, strength)
// ElectricField (xpos, ypos, height, width, strength, direction (boolean) )

// GUI package for Processing
import g4p_controls.*;


GSlider sdr;

ArrayList<Particle> particles;
ArrayList<MagneticField> mag_fields;
ArrayList<ElectricField> electric_fields;

boolean inCycle;
boolean withAverageVelocity;


void setup() {
  // initialize particle and field lists
  particles = new ArrayList<Particle>();
  mag_fields = new ArrayList<MagneticField>();
  electric_fields = new ArrayList<ElectricField>();

  // draw canvas
  size(1280, 640);
  stroke(255);

  // demo system
//  demo();
  
  // cyclotron system
//  cyclotron();

  // custom system
  custom();

  // displays average velocity
//  withAverageVelocity(particles);

  // add particles to the system
  float xi = width/2;
  float yi = height/2;

  // create data file
  
}

int count = 0;

void draw() {
  
  background(155);

  // build  and update magnetic fields
  for (MagneticField field : mag_fields) {
    field.buildField();
    if (inCycle)
      field.updateStrength(sdr.getValueF());
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
  
  // display velocity of particle for cyclotron
  if (inCycle)
  {
    Particle p = particles.get(0);
    String str = "Speed: " + getMagnitude(p.xspeed, p.yspeed);
    textSize(32);
    fill(0, 102, 153);
    text(str, 100, 100); 
    if (p.xpos > width - 5 || p.xpos < 10 || p.ypos > height - 10 || p.ypos < 10)
    {
      textSize(40);
      fill(250, 0, 0);
      String response = p.halt();
      text(response, width/2 - 150, height/2); 
    }
    textSize(18);
    fill(0, 102, 153);
    String multiplier = "Field Multiplier: " + sdr.getValueF();
    text(multiplier, 70, height - 110  );    
  }
  
  // display average velocity of particles
  if (withAverageVelocity)
  {
    float avgVel = getAverageVelocity(particles);
    String str = "Average velocity = " + avgVel;
    textSize(32);
    fill(0, 102, 153);
    text(str, 100, 100); 
//    writer.println(count + "," + avgVel);
//    if (count == 10000000)
//    {
//      writer.close();
//    }
//    count++;
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

// magnitude of a vector
float getMagnitude(float a, float b){
    return (float) Math.sqrt(a * a + b * b);
}

// Below are a series of different field systems

void demo()
{
  // add magnetic fields to the system
  mag_fields.add(new MagneticField(0, 160, 320, 400, 1));
  mag_fields.add(new MagneticField(880, 160, 320, 400, 1));

  // add electric fields to the system
  electric_fields.add(new ElectricField(width/4 + 150, height/4, 300, 400, 5, true));
  
  addRandomParticles(4);
}

void cyclotron()
{
  inCycle = true;
  // add magnetic fields to system
  mag_fields.add(new MagneticField(0, 0, 640, 500, 6));
  mag_fields.add(new MagneticField(750, 0, 640, 500, 6)); 
  
  // add electric fields to system
  electric_fields.add(new ElectricField(540, 10, 300, 215, 5, false));
  electric_fields.add(new ElectricField(540, 310, 300, 215, 5, true));
  
  // add particles
  particles.add(new Particle(600, 300, -4, 0, 1, 20));
  
  // configure slider
  sdr = new GSlider(this, 55, height - 100, 200, 100, 15);  
  sdr.setLocalColorScheme(5); 
  sdr.setLimits(1,1.01);
  sdr.setOpaque(false); 
  sdr.setValue(1); 
  sdr.setNbrTicks(2); 
  sdr.setShowLimits(false); 
  sdr.setShowValue(false); 
  sdr.setShowTicks(false); 
  sdr.setStickToTicks(false); 
  sdr.setEasing(1.0); 
  sdr.setRotation(0.0, GControlMode.CENTER); 

}

// custom system
void custom(){
  withAverageVelocity = true;
  // add magnetic fields to the system
//  mag_fields.add(new MagneticField(0, 160, 320, 400, 1));
//  mag_fields.add(new MagneticField(880, 160, 320, 400, 1));
//
//  // add electric fields to the system
//  electric_fields.add(new ElectricField(width/4 + 150, height/4, 300, 400, 5, true));
  addRandomParticles(10);


}

float getAverageVelocity(ArrayList<Particle> particles)
{
  float total = 0;
  for (Particle p : particles)
  {
    total += getMagnitude(p.xspeed, p.yspeed);
  }
  return total / (float) particles.size();
}








