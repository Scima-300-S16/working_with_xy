// Be sure to put locations.tsv and names.tsv
// from b_getting_locations into your current data folder!


//introduce variables and objects
PImage mapImage;
Table locationTable; //this is using the Table object
Table amountsTable; //this is using the Table object
Table nameTable;
int rowCount;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;

//global variables assigned values in drawData()
float closestDist;
String closestText;
float closestTextX;
float closestTextY;

float x0,y0;
float x1,y1;
float x2,y2;

float xspeed=10;
float yspeed=10;

void setup() {
  size(1200, 1023);
  mapImage = loadImage("SF Map.JPG");

  //assign tables to object
  locationTable = new Table("locations.tsv");  
  amountsTable = new Table("amounts.tsv");
  nameTable = new Table ("name.tsv");
  
  x0=800;
  y0=800;
  x1=300;
  y1=500;
  x2=600;
  y2=600;
  

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
    text("Home",570,630);
    textAlign(CENTER);
    text(closestText, closestTextX, closestTextY);
  }
}

//we write this function to visualize our data 
// it takes 3 arguments: x, y and id
void drawData(float x, float y, String id) {
//value variable equals second field in row
  float value = amountsTable.getFloat(id, 1);
  float radius = map(value, 0, dataMax, 3, 15);
  fill(0,189,238);

  //make a circle at the x and y locations using the radius values assigned above
  

  ellipseMode(RADIUS);
  ellipse(x, y, radius, radius);

  float d = dist(x, y, mouseX, mouseY);
  

//if the mouse is hovering over circle, show information as text
  if ((d<radius+2) && (d<closestDist)) {
    closestDist = d;
    String name = nameTable.getString(id, 1);
    String location = locationTable.getString(id, 1);
    closestText = name +" location/min "+value +location;
    closestTextX = x;
    closestTextY = y-radius-6;
    textSize(21);
    ellipse(570,650,7,7);
    line(x,y,570,650);
    
    ellipse(x0,y0, 30,30);
    x0= x0-xspeed;
    
    if(x0 !=800){
      x0 += 1;
      y0 -=6;
          
    }
   if(x0 <= 400){
   x0=x1;
   y0=y1;
   }
    
    
  }
}