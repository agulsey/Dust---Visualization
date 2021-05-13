import controlP5.*;
ControlP5 cp5;

boolean debug = false;

int slider = 1000;
int flow = 50;
int dates = 0;
int maxValue = 5000;
int minValue = 0;
int tableMax = 0;
int day;
PFont RMono;
Table table;
PImage img;

String curDate;

int dateIndex = 0;

float speed = .8; 
float value = 0.0;
int MAX = 255;

Data pm25;
Data pm10;
String [] month = "January, February, March, April, May, June, July, August, September, October, November, December".split(", ");

void setup() {
  size(1200, 800);
  RMono = createFont("RobotoMono-Light.ttf", 14);
  table = loadData();
  pm25 = new Data(table, "pm25", 3, 50);
  pm10 = new Data(table, "pm10", 8, 25);
  img = loadImage("dust_01.png");


  //cp5= new ControlP5(this);
  //cp5.addSlider("dates").setPosition(20, height-60).setSize(300, 10).setRange(table.getRowCount(), 0).setValue(dates);
  dateIndex = table.getRowCount() - 1;
  addDate(); 
  background(0);
  smooth();
  textFont(RMono); 
  textSize(20);
}

void draw() {
  if (frameCount % 50 == 0) {
    addDate();
  }
  background(0);
  pm25.run();
  pm10.run();
  //print(frameRate);
  //print(curDate);\

  //Shows only the first day of the month, then the text disappears.
  int[] day = int(split(curDate, '.'));
  String my = month[day[1]-1] + " | " + day[2];
  if (day[0] < 6) { 
    //Fade in and out of the text
    value+=speed;
    float fade = sin(radians(value))*MAX;
    fill(255, fade); 
    text(my, 20, height-40);
    //print(fade);
  }
  else{
  value = 0.0;
  }

}

Table loadData() {
  //return loadTable("beijing-air-quality.csv", "header");
  return loadTable("london-air-quality.csv", "header");
}

void dates(int date) {
  pm25.updateValue(date);
  pm10.updateValue(date);

  TableRow row = table.getRow(date);
  curDate = row.getString("date");
}

void addDate() {
  this.dates(dateIndex);
  dateIndex--;
  if (dateIndex < 0) dateIndex = table.getRowCount()-1;
}
