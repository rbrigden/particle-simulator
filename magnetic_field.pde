class MagneticField {
  
  // draw magnetic field points
  float x1; // = 250;
  float y1; // = 150;
  float x2;
  float y2;
  
  // initial values
  float x1_0; 
  float y1_0;
  float x2_0; 
  float y2_0;
  
  // field dimensions
  float field_height;
  float field_width;
  
  // strength of the field: B
  float strength;
  
  // default magnetic field
  public MagneticField(){
    x1 = 250;
    y1 = 250;
    x2 = x1 + 5;
    y2 = y1 + 5;
    x1_0 = x1;
    y1_0 = y1;
    x2_0 = x2;
    y2_0 = y2;
    
    field_height = 400;
    field_width = 800;
  }
  
  // custom magnetic field
  public MagneticField(float x, float y, float h, float w, float b){
    x1 = x;
    y1 = y;
    x2 = x + 5;
    y2 = y + 5;
    x1_0 = x1;
    y1_0 = y1;
    x2_0 = x2;
    y2_0 = y2;
    
    field_height = h;
    field_width = w;
    
    strength = b;
  }
  
  // draw the inward facing magnetic field (x)
  void buildField(){
    for (int i = 0; i <= (int) field_height/30 ; i++)
    {
      for (int k = 0; k <= (int) field_width/30; k++)
      {
        x1 += 30;
        x2 += 30;
        line(x1,y1,x2,y2);
        line(x1,y2,x2,y1);
      }
      y1 += 30;
      y2 += 30;
      x1 = x1_0;
      x2 = x2_0;
    }
    y1 = y1_0;
    y2 = y2_0;  
  }
  
  void updateStrength(float multiplier)
  {
    strength *= multiplier;
  }
  
}
