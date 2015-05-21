public class ElectricField{
  
  // electric field anchor points
  float x1;
  float y1; 
  float x2;
  float y2;
  
  // strength of the electric field: E
  float strength;
  
  // field faces right if true; left if false
  boolean right;

  // field dimensions
  float field_height;
  float field_width;
  
  // default electric field
  public ElectricField(){
    field_height = 250;
    field_width = 250;
    x1 = 250;
    y1 = 250;
    x2 = x1 + field_width;
    y2 = 250;
    right = true;
    strength = 1;
  }
    
  // custom electric field
  public ElectricField(float x, float y, float h, float w, float s, boolean r){
    field_height = h;
    field_width = w;
    x1 = x;
    y1 = y;
    x2 = x1 + w;
    y2 = y;
    strength = s;
    right = r;
  }
  
  // draw the electric field
  void buildField(){
    line(x1, y1, x1, y1 + field_height);
    line(x2, y1, x2, y1 + field_height);
    
    for (int i = 0; i <= (int) field_height/30 ; i++)
    {
      float y = y1 + 30 * i;
      line(x1, y, x2, y);
      float midx = (x1 + x2) / 2; 
      if (right){
        line(midx, y, midx - 5, y + 5);
        line(midx, y, midx - 5, y - 5);
      }
      else{
        line(midx, y, midx + 5, y + 5);
        line(midx, y, midx + 5, y - 5);
      }
      
      
    }
  
  }
  
 
    
  
  
}

