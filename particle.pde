/* Particle represents a charged particle.
   Particle(x,y,xspeed,yspeed,charge, mass
*/

class Particle{
  // position of the particle
  float xpos;
  float ypos;
  
  // speed of the particle
  float xspeed;
  float yspeed;
  
  // particle qualities
  float charge;
  float mass;
  
  
  public Particle() {
    xpos = 30;
    ypos = 310;
    xspeed = 3;
    yspeed = 0;
    charge = 1;
    mass = 0.1;
  }
  
  public Particle(float x, float y, float xspd, float yspd, float q, float m) {
    xpos = x;
    ypos = y;
    xspeed = xspd;
    yspeed = yspd;
    charge = q;
    mass = m;
    
  }
  
  
  public void update(float dt, ArrayList<MagneticField> mag_fields, ArrayList<ElectricField> electric_fields){
    // test for inclusiveness and accelerate inside the magnetic field
    for (MagneticField field : mag_fields){
      if (inMagField(field)){
          accelerateInMagField(dt, field);
        }
     }
     
     // test for inclusiveness and accelerate inside the electric field
      for (ElectricField field : electric_fields){
      if (inElectricField(field)){
          accelerateInElectricField(dt, field);
        }
     }
     
     sides();
     xpos += xspeed * dt;
     ypos += yspeed * dt;
  }
  
  private void sides(){
  
    // side window barriers
    if (xpos > width && xspeed > 0) { 
      xspeed = -1 * xspeed; 
    }
    
    if (xpos < 0 && xspeed < 0) { 
      xspeed = -1 * xspeed; 
    }
    
    // top and bottom window barriers
    if (ypos > height && yspeed > 0) { 
      yspeed = -1 * yspeed; 
    }
    
    if (ypos < 0 && yspeed < 0) { 
      yspeed = -1 * yspeed; 
    }
  }
  
  // check if this particle is within a given magnetic field
  private boolean inMagField(MagneticField field){
    float field_width = field.field_width;
    float field_height = field.field_height;
    float x1 = field.x1;
    float y1 = field.y1;
    return xpos > x1 && xpos < (x1 + field_width) && ypos > y1 && ypos < (y1 + field_height);
  }
  
  // check if this particle is within a given electric field
  private boolean inElectricField(ElectricField field){
    float field_width = field.field_width;
    float field_height = field.field_height;
    float x1 = field.x1;
    float y1 = field.y1;
    return xpos > x1 && xpos < (x1 + field_width) && ypos > y1 && ypos < (y1 + field_height);
  }
  
  // accelerate this particle in a given magnetic field
  private void accelerateInMagField(float dt, MagneticField field){
    float speed = getMagnitude(xspeed, yspeed);
    float acc = getMagAcc(field);
    
    float yacc = ((xspeed / speed) * acc);
    float xacc = ((yspeed / speed) * acc) * -1;
   
    xspeed += xacc * dt;
    yspeed += yacc * dt;
  }
  
  // accelerate this particle in a given electric field
  private void accelerateInElectricField(float dt, ElectricField field){
    float xacc = (field.strength * charge) / mass;
    if (!field.right){
      xacc *= -1;
    }
    
    xspeed += xacc * dt;   
  }
  
  
  
  // magnitude of a vector
  private float getMagnitude(float a, float b){
      return (float) Math.sqrt(a * a + b * b);
  }
  
  // magnitude of the acceleration caused by the magnetic field
  private float getMagAcc(MagneticField field){
    float speed = getMagnitude(xspeed, yspeed);
    return (charge * speed * field.strength * -1) / mass;
  }
  
}

