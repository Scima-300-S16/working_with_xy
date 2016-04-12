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

float xspeed = 0.02;

void setup() {
  size(640, 400);
  mapImage = loadImage("map.png");

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
  x0 = 485;
  y0 = 240;
  x1 = 85;
  y1 = 185;
  x2 = 162;
  y2 = 209;
  x3 = 85;
  y3 = 215;
  x4 = 480;
  y4 = 250;
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
    fill(0);
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
    radius = map(value, 0, dataMax, 1.5, 15); 
    //and make it this color
    float newcolor = map(value, 0, dataMax, 0, 255);
  fill(newcolor, newcolor-255, newcolor+10);

  } else {
    //otherwise, if the number is negative, make it this color.
    radius = map(value, 0, dataMin, 1.5, 15);
    fill(#FFEB2E);
  }
  //make a circle at the x and y locations using the radius values assigned above
  ellipseMode(RADIUS);
  ellipse(x, y, radius, radius);
    fill (#FFEB2E);


  float d = dist(x, y, mouseX, mouseY);
 
//if the mouse is hovering over circle, show information as text
  if ((d<radius+2) && (d<closestDist)) {
    closestDist = d;
    String name = amountsTable.getString(id, 1);
    closestText = name +" "+value;
    closestTextX = x;
    closestTextY = y-radius-4;
    line(x,y,200,200);
  }
  
  ellipse (x0, y0, 6, 6); 
  fill (#FFEB2E);
 x0 = x0 - xspeed;

 
  if (x0 != 485){
    x0 -= 1;
}
  if (x0 <= 85){
    x0 = 85;
  }
   if (x0 <= 85){
     y0 -=1;
   }
   if (y0 <= 185){
     y0 = 185;
   }
   
   ellipse(x1,y1,6,6);
     fill (#FFEB2E);

   if (x0<=85 && y0<=185){
     x1 += 3;
     y1 += 1;
   }
  if (x1 >= 162){
    x1 = 162;
    y1 = 209;
  }
  
  ellipse(x2,y2,6,6);
    fill (#FFEB2E);

  if(x1>=162 && y1>=209){
    x2-=9;
    y2+=.5;
  }
  if (x2<=85){
    x2=85;
    y2=215;
  }
  
  ellipse(x3,y3,6,6);
    fill (#FFEB2E);

  if(x2<=85 && y2>=215){
    x3+=1;
  }
  if(x3>=480){
    x3=480;
  }
  if(x3>=480){
    y3+=1;
  }
  if (y3>=250){
    y3=250;
  }
//}
//  float newcolor = map(value, 0, dataMax, 0, 255);
 // fill(newcolor, newcolor-255, newcolor+10);
}