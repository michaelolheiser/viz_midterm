import ddf.minim.*;

Minim minim;
AudioPlayer player;

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
  genImage = loadImage("generations.png");
  askforhelpImage = loadImage("askhelp.png");
  bubbleImage = loadImage("bubbleplot.png");
  barplotImage = loadImage("barplot.png");
  suicideInfographic = loadImage("suicideInfographic.png"); 
  demographicsImage = loadImage("demographics.png"); 
  demographicsImage = loadImage("demographics.png"); 
  askforhelpTextbox = loadImage("AskHelpTextbox.png");
  friendsfamTextbox = loadImage("FriendsFamilyTextbox.png"); 


  askforhelpImage.resize(400, 400);
  populationImage.resize(350, 350);
  agegroupImage.resize(300, 300);
  genImage.resize(300, 300);
  suicideInfographic.resize(350,400);
  demographicsImage.resize(300, 300);
  
  //plot images using center coords
  //imageMode(CENTER);
  
  // Initialize the Minim library
  minim = new Minim(this);
  
  // Load the MP3 file
  player = minim.loadFile("Logic_1800.wav");
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
  image(agegroupImage, width - agegroupImage.width +40, -25, ageImageSize, ageImageSize);

  // Draw the socialMediaImage at the bottom left corner
  image(genImage, -25, height - genImage.height + 25, genImageSize, genImageSize);
  
  // Draw the demographicsImage at the bottom right corner
  image(demographicsImage,680, height - genImage.height + 25, demImageSize, demImageSize);

  // Draw the askforhelpImage at the bottom middle of the screen with a slight offset
  float askImageX = width / 2 - askforhelpImage.width / 2;
  float askImageY = height - askforhelpImage.height + 100; // Adjust the offset as per your needs
  image(askforhelpImage, askImageX, askImageY, askImageSize, askImageSize);
  
  //breathing effect for hover icons
  if(popImageSize < 350) {
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
    barplotImage.resize(550, 800);
    // Adjust the X-coordinate to move the image to the right
    var offsetX = 50; // Change this value to adjust the amount of rightward movement
    image(barplotImage, width / 2 - barplotImage.width / 2 + offsetX, height / 2 - barplotImage.height / 2);
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
  if (mouseX > 300 && mouseX < 645 && mouseY > 650 && mouseY < 750) {
    // If the mouse is within the area, play the MP3 file
    player.play();
  }
}

void mouseClicked() {
  // Print the x and y coordinates of the mouse click
  println("Mouse clicked at (" + mouseX + ", " + mouseY + ")");
}
