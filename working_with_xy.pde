// Be sure to put locations.tsv and names.tsv
// from b_getting_locations into your current data folder!


//introduce variables and objects
PImage mapImage;
Table locationTable; //this is using the Table object
Table amountsTable; //this is using the Table object
int rowCount;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;

//global variables assigned values in drawData()
float closestDist;
String closestText;
float closestTextX;
float closestTextY;

float x0, y0;//starting position of ball
float x1, y1;
float x2, y2;
float x3, y3;
float x4, y4;
float x5, y5;

float xspeed = 0.2;

void setup() {
  size(670, 600);
  mapImage = loadImage("chinamap.jpg");

  //assign tables to object
  locationTable = new Table("locations.tsv");  
  amountsTable = new Table("amounts.tsv");

  // get number of rows and store in a variable called rowCount
  rowCount = locationTable.getRowCount();
  //count through rows to find max and min values in random.tsv and store values in variables
  for (int row = 0; row< rowCount; row++) {
    //get the value of the second field in each row (1)
    float value = amountsTable.getFloat(row, 1);
    //if the highest # in the table is higher than what is stored in the 
    //dataMax variable, set value = dataMax
    if (value>dataMax) {
      dataMax = value;
    }
    //same for dataMin
    if (value<dataMin) {
      dataMin = value;
    }
  }
  //set the starting position of the shape
  x0 = 477;
  y0 = 488;
  x1 = 450;
  y1 = 505;
  x2 = 315;
  y2 = 364;
  x3 = 557;
  y3 = 352;
  x4 = 489;
  y4 = 213;
  x5 = 424;
  y5 = 272;
}

void draw() {
  background(255);
  image(mapImage, 0, 0);

  closestDist = MAX_FLOAT;
  


//count through rows of location table, 
  for (int row = 0; row<rowCount; row++) {
    //assign id values to variable called id
    String id = amountsTable.getRowName(row);
    //get the 2nd and 3rd fields and assign them to
    float x = locationTable.getFloat(id, 1);
    float y = locationTable.getFloat(id, 2);
    //use the drawData function (written below) to position and visualize
    drawData(x, y, id);
  }

//if the closestDist variable does not equal the maximum float variable....
  if (closestDist != MAX_FLOAT) {
    fill(#FF74EF);
    textAlign(CENTER);
    text(closestText, closestTextX, closestTextY);
  }
}

//we write this function to visualize our data 
// it takes 3 arguments: x, y and id
void drawData(float x, float y, String id) {
//value variable equals second field in row
  float value = amountsTable.getFloat(id, 1);
  float radius = 0;
//if the value variable holds a float greater than or equal to 0
  if (value>=0) {
    //remap the value to a range between 1.5 and 15
    radius = map(value, 0, dataMax, 5, 15); 
    
    float newcolor = map (value, 0, dataMax, 0, 255);
    //and make it this color
    fill(newcolor, newcolor-138,newcolor+50);
  
  } else {
    //otherwise, if the number is negative, make it this color.
    radius = map(value, 0, dataMin, 5, 15); 
    //newvariable = Map (variable,0,50, 50, 0) - varibale = initial value/ 0,50 = initial range/ 50,0 = desired range
    
    fill(#FF4422);
  }
  //make a circle at the x and y locations using the radius values assigned above
  ellipseMode(RADIUS);
  ellipse(x, y, radius, radius);
  fill (#FF74EF);

  float d = dist(x, y, mouseX, mouseY);

//if the mouse is hovering over circle, show information as text
  if ((d<radius+2) && (d<closestDist)) {
    closestDist = d;
    String name = amountsTable.getString(id, 1);
    closestText = name +" "+value;
    closestTextX = x;
    closestTextY = y-radius-4;
  }
  
  ellipse (x0, y0, 10, 10); 
  fill (#FF74EF);
 x0 = x0 - xspeed;

 
  if (x0 != 477){
    x0 -= 1;
    y0 +=37/23;
  }
  
  if (y0 >= 505){
    x0 = 450;
    y0 = 505;
  }

  ellipse (x1, y1, 12, 12);
  
  if (x0 <= 450 && y0 <= 505){
    x1 -= 1;
    y1 -= 141/80;
  }
  
  if (y1 <= 364){
    x1 = 317;
    y1 = 362;
  }
  
   ellipse (x2, y2, 9, 9);

  if (x1 <= 317 && y1 <= 362){
    x2 += 1;
    y2 -= 12/142;
  }

  if (x2 >= 557){
    x2 = 557;
    y2 = 352;
  }
  
  ellipse (x3, y3, 8, 8);
  
  if (x2 >= 557 && y2 <= 352){
    x3 -= 1;
    y3 -= 139/68;
  }
  if (y3 <= 213){
    x3 = 489;
    y3 = 213;
  }
   ellipse (x4, y4, 6, 6);
   
   if (x3 <= 489 && y3 <= 213){
     x4 -= 1;
     y4 += 120/65;
   }
   if (y4 >= 272){
     x4 = 424;
     y4 = 272;
   }
   
   ellipse (x5, y5, 15, 15);
   
   if (x4 <= 424 && y4 <= 272){
     x5 += 1;
     y5 += 216/53;
   }
   if (x5 >= 477){
     x5 = 477;
     y5 = 488;
   }
}