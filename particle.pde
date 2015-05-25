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
  
  // constant 1/(4piE_0)
  float k = 900; 
 
  
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
  
  
  public void update(float dt, ArrayList<MagneticField> mag_fields, ArrayList<ElectricField> electric_fields, ArrayList<Particle> particles){
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
      

    for (Particle particle : particles)
    {
      accelerateInChargeField(dt, particle);
    }

    bounceOffSides();
    xpos += xspeed * dt;
    ypos += yspeed * dt;
  }
  
  
  private void bounceOffSides(){
  
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
    // if field is not in the rightward direction
    if (!field.right){
      xacc *= -1;
    }
    
    xspeed += xacc * dt;   
  }
  
  // accelerate this particle by the reactionary electric force of another
  private void accelerateInChargeField(float dt, Particle other)
  {
    float r = getDist(xpos, ypos, other.xpos, other.ypos);
    
    if (!Float.isNaN(r))
    {
      float rx = 0;
      float ry = 0;
      //  unit vector
      if (r > 1){
      rx = (xpos - other.xpos) / r;
      ry = (ypos - other.ypos) / r;
      }
      // magnitude of acceleration 
      float acc = 0;
      if (r > 1){
      acc = k * (charge * other.charge)/(r*r);
      }
      // accelearation in the direction of the radius unit vector
      xspeed += acc * rx * dt;
      yspeed += acc * ry * dt;
    }
  }
  
  // magnitude of the acceleration caused by the magnetic field
  private float getMagAcc(MagneticField field){
    float speed = getMagnitude(xspeed, yspeed);
    return (charge * speed * field.strength * -1) / mass;
  }
  
  // get the distance between two points
  private float getDist(float x1, float y1, float x2, float y2)
  {
    return (float) Math.sqrt(Math.pow(x2-x1, 2) + Math.pow(y2-y1, 2));
  }
  
  // magnitude of a vector
  private float getMagnitude(float a, float b){
      return (float) Math.sqrt(a * a + b * b);
  }
  
}

