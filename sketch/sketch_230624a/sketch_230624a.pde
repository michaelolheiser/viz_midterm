import ddf.minim.*;

Minim minim;
AudioPlayer player;

import java.io.*;

Table table;            
int currentIndex;      
boolean animationDone;  

PImage backgroundImage;
PImage populationImage;
PImage agegroupImage;
PImage genImage;
PImage askforhelpImage;
PImage bubbleImage;
PImage barplotImage;
PImage suicideInfographic;
PImage demographicsImage;
PImage askforhelpTextbox;
PImage friendsfamTextbox;

boolean isHoveringLeft = false;
boolean isHoveringRight = false;
boolean isHoveringBottomLeft = false;
boolean isHoveringBottomRight = false;
boolean isHoveringBottomMiddle = false;

float popImageSize = 350;
float askImageSize = 400;
float ageImageSize = 300;
float genImageSize = 300;
float demImageSize = 300;
float dir = 1;

void setup() {
  size(945, 945);
  textAlign(CENTER, CENTER);
  textSize(20);

  // Load images
  populationImage = loadImage("population.png");
  backgroundImage = loadImage("background.png");
  agegroupImage = loadImage("age_group.png");
  genImage = loadImage("suicide_by_year.png");
  askforhelpImage = loadImage("askhelp.png");
  bubbleImage = loadImage("bubbleplot.png");
  barplotImage = loadImage("barplot.png");
  suicideInfographic = loadImage("suicideInfographic.png"); 
  demographicsImage = loadImage("demographics.png"); 
  askforhelpTextbox = loadImage("AskHelpTextbox.png");
  friendsfamTextbox = loadImage("FriendsFamilyTextbox.png"); 


  askforhelpImage.resize(400, 400);
  populationImage.resize(350, 350);
  agegroupImage.resize(300, 300);
  genImage.resize(300, 300);
  suicideInfographic.resize(350, 400);
  demographicsImage.resize(300, 300);

  // Initialize the Minim library
 // minim = new Minim(this);

  // Load the MP3 file
  player = minim.loadFile("Logic_1800.wav");
 
  // Load the data from the CSV file
  table = loadTable("suicide_rates_usa.csv", "header");
  currentIndex = 0;
  animationDone = false;
  frameRate(5);
}

void draw() {
  // Set the loaded image as the background
  background(backgroundImage);

  // Check if the mouse is within the boundaries of the left top corner
  if (mouseX >= 0 && mouseX <= populationImage.width &&
    mouseY >= 0 && mouseY <= populationImage.height) {
    isHoveringLeft = true;
  } else {
    isHoveringLeft = false;
  }

  // Check if the mouse is within the boundaries of the right top corner
  if (mouseX >= width - 400 && mouseX <= width &&
    mouseY >= 0 && mouseY <= 200) {
    isHoveringRight = true;
  } else {
    isHoveringRight = false;
  }

  // Check if the mouse is within the boundaries of the bottom left corner
  if (mouseX >= 0 && mouseX <= populationImage.width &&
    mouseY >= height - 200 && mouseY <= height) {
    isHoveringBottomLeft = true;
  } else {
    isHoveringBottomLeft = false;
  }

  // Check if the mouse is within the boundaries of the bottom right corner
  if (mouseX >= width - 400 && mouseX <= width &&
    mouseY >= height - 200 && mouseY <= height) {
    isHoveringBottomRight = true;
  } else {
    isHoveringBottomRight = false;
  }

  // Check if the mouse is in the middle bottom of the screen
  float middleBottomX = width / 2;
  float middleBottomY = height - 100; // Adjust the Y-coordinate as per your needs

  if (mouseX >= middleBottomX - 200 && mouseX <= middleBottomX + 200 &&
    mouseY >= middleBottomY && mouseY <= height) {
    isHoveringBottomMiddle = true;
  } else {
    isHoveringBottomMiddle = false;
  }

  // Draw the population image at the top left corner
  image(populationImage, -50, -50, popImageSize, popImageSize);

  // Draw the friendsFamilyImage at the top right corner
  image(agegroupImage, width - agegroupImage.width + 40, -25, ageImageSize, ageImageSize);

  // Draw the socialMediaImage at the bottom left corner
  image(genImage, -25, height - genImage.height + 25, genImageSize, genImageSize);

  // Draw the demographicsImage at the bottom right corner
  image(demographicsImage, 680, height - genImage.height + 25, demImageSize, demImageSize);

  // Draw the askforhelpImage at the bottom middle of the screen with a slight offset
  float askImageX = width / 2 - askforhelpImage.width / 2;
  float askImageY = height - askforhelpImage.height + 100; // Adjust the offset as per your needs
  image(askforhelpImage, askImageX, askImageY, askImageSize, askImageSize);

  // Breathing effect for hover icons
  if (popImageSize < 350) {
    dir = 1;
  } else if (popImageSize > 360) {
    dir = -1;
  }

  popImageSize += 0.15 * dir;
  askImageSize += 0.15 * dir;
  ageImageSize += 0.15 * dir;
  genImageSize += 0.15 * dir;
  demImageSize += 0.15 * dir;

  // Draw the text box for left top corner hover
  if (isHoveringLeft) {
    fill(255); // White color for the text box
    rect(mouseX, mouseY, 600, 450); // Adjust the dimensions as per your needs
    fill(0); // Black color for the text
    textAlign(CENTER, CENTER);
    text("There is a profound impact of friends and family in supporting and uplifting those battling depression. They offer understanding, a safe space to express oneself, and unwavering support. Their love and care are boundless, providing strength and laughter in the face of darkness. They remind us that we are not alone, advocate for our mental health, and inspire us to seek professional help when needed. Let us cherish these relationships and spread awareness, for together, we can create a compassionate world.", mouseX, mouseY, 600, 450); // Adjust the position and dimensions of the text box
  }

  // Draw the image for right top corner hover
  if (isHoveringRight) {
    bubbleImage.resize(850, 700);
    image(bubbleImage, width / 2 - bubbleImage.width / 2, height / 2 - bubbleImage.height / 2);
}

  // Draw the image for bottom left corner hover
  if (isHoveringBottomLeft) {
   background(255);
  
  // Check if animation is complete
  if (currentIndex >= table.getRowCount()) {
    animationDone = true;
  }
  
  // Plot the data points up to the current index
  if (!animationDone) {
    plotDataPoints(currentIndex);
    currentIndex++;
  }
  
    if (animationDone) {
    plotDataPoints(18);
  }
  
  // Draw labels and values
  drawLabels();
  }


  // Draw the image for bottom right corner hover
  if (isHoveringBottomRight) {
    // Draw the demographicsImage at the bottom right corner
    image(suicideInfographic, mouseX - 400, mouseY - 250, suicideInfographic.width, suicideInfographic.height);
  }

  // Draw the text box for bottom right corner hover
  if (isHoveringBottomMiddle) {

    image(askforhelpTextbox, 300, 500, askforhelpTextbox.width, askforhelpTextbox.height);

  }
}

void mousePressed() {
  // Check if the mouse is within a specific area (e.g., a rectangle)
 // if (mouseX > 300 && mouseX < 645 && mouseY > 650 && mouseY < 750) {
    // Toggle audio playback
    if (player.isPlaying()) {
      player.pause(); // If the player is already playing, pause it
    } else {
      player.play(); // If the player is paused, play the audio
    }
  }
}

void mouseClicked() {
  // Print the x and y coordinates of the mouse click
  println("Mouse clicked at (" + mouseX + ", " + mouseY + ")");
}

void plotDataPoints(int endIndex) {
  // Set up variables for plotting
  float xInterval = (width - 200) / table.getRowCount();
  float yScale = (height-200) / getMaxRate();
    int grid = 10;

  // Plot each data point up to the specified end index
  for (int i = 0; i <= endIndex; i++) {
    TableRow row = table.getRow(i);
    int year = row.getInt("Year");
    float rate = row.getFloat("Rate");
    // Calculate the position of the data point
    float x = map(i, 0, table.getRowCount() - 1, 100, width - 100);
    float y = map(rate, 0, getMaxRate(), height + 100, 100);

    
    // Draw a circle at the data point
    noStroke();
    fill(255, 191, 0);
    ellipse(x, y, 15, 15);
    stroke(0, 100, 200);
    strokeWeight(5);
    // axes
    line(50, 400, 50, 100);
    line(50, 400, width-50, 400);

  }
}

void drawLabels() {
  // Draw the year label
  fill(50);
  textAlign(CENTER, CENTER);
  textSize(25);
  
  if (animationDone) {
    text("Year: 2018", width / 2, 450);
  } else {
    TableRow row = table.getRow(currentIndex - 1);
    int year = row.getInt("Year");
    text("Year: " + year, width / 2, 450);
  }
  
  // Draw the rate label
  textAlign(CENTER, TOP);
  textSize(25);
  
  if (animationDone) {
    TableRow row = table.getRow(table.getRowCount()-1);
    float rate = row.getFloat("Rate");
    text("Suicide Rate per 100K in the US: " + rate, width / 2, 50);
  } else {
    TableRow row = table.getRow(currentIndex - 1);
    float rate = row.getFloat("Rate");
    text("Suicide Rate per 100K in the US: " + rate, width / 2, 50);
  }
}

float getMaxRate() {
  // Find the maximum suicide rate in the data
  float maxRate = 0;
  
  for (int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    float rate = row.getFloat("Rate");
    
    if (rate > maxRate) {
      maxRate = rate;
    }
  }
  
  return maxRate;
}
