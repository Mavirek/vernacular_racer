String [] spanish = {
  "rojo", "verde"
};
String [] english = {
  "red", "green"
};
int spo=0;
String word=spanish[spo];
int wpo=0;
char le=word.charAt(wpo);
Obstacle o1 = new Obstacle(random(150, 200), random(-300, 20), false, word, le, 1);
Obstacle o2 = new Obstacle(random(300, 350), random(-350, 20), true, word, le, 2);
Obstacle o3 = new Obstacle(random(400, 480), random(-250, 20), false, word, le, 3);
//Circle coin = new Circle(le);
PImage img, img2;
int wait = 2000;
int time;
boolean update=false;
void setup()
{
  size(600, 600);
  noStroke();
  rectMode(CENTER);
  frameRate(60);
}
int x=300;
int y=590;
int yStripe=0;
int score = 0;
int level = 1;
boolean stop = false;

class Obstacle
{
  float posx;//random(100,400)
  float posy;//random(-300,20)
  char letter;
  boolean correct;
  String word;
  int num;
  Obstacle(float pxi, float pyi, boolean c, String w, char le, int obn) 
  {
    posx=pxi;
    posy=pyi;
    num=obn;
    correct = c;
    word=w;
    if (correct)
      letter = le;
    else
      letter = (char)random(97, 122);
    //System.out.print("letter = "+letter);
  }

  void createOb()
  {
    fill(255, 255, 255);
    rect(posx, posy, 50, 65, 15);
    textSize(32);
    fill(50);
    text(letter, posx-5, posy);

    if (posy<600)
    {
      if (level==5)
        posy+=14;
      else if (level==4)
        posy+=12;
      else if (level==3)
        posy+=9;
      else if (level==2)
        posy+=7;
      else
        posy+=5;
    }
    if (posy>=600)
    {
      posy=0;
      posx=random(150, 450);
      letter=(char)random(97, 122);
    }
    if (dist(posx, posy, x, y)<=45)
    {
      if (le==letter)
      {
        update=true;
      } else if (le!=letter)
      {
        fill(255, 0, 0);
        textSize(32);
        text("You lost", 250, 150);
        stop=true;
      }
    }
  }
}
void keyPressed()
{

  if (key=='d')
    if (x<450)
      x+=30;
  if (key =='a')
    if (x>150)
      x-=30;
  if (key =='w')
    if (y>0)
      y-=40;
  if (key=='s')
    if (y<600)
      y+=40;
}
void draw()
{
  background(64, 198, 101);
  fill(0, 0, 0);
  rect(300, 350, 370, 700); //road
  fill(242, 237, 88);
  rect(300, yStripe, 20, 40); 
  fill(255, 0, 0);
  text(word, 450, 40);
  fill(255, 0, 0);
  if (wpo<word.length())
    text(word.substring(0, wpo), 450, 60);

  if (yStripe<=600)
    yStripe+=30;
  else if (yStripe>600)
    yStripe=0;
  fill(214, 54, 60);
  rect(x, y, 50, 65, 15); //car
  if (stop==true)
    noLoop();
  if (score==500)
    level=2;
  else if (score==1000)
    level=3;
  else if (score==1500)
    level=4;
  else if (score==2000)
    level=5;
  o1.createOb();
  o2.createOb();
  o3.createOb();

  if (update)
  {

    if (wpo<word.length()-1)
      wpo++;
    else if (wpo==word.length()-1)
    {
      noLoop();
      fill(255, 0, 0);
      text(word.substring(0, word.length()), 450, 60);

      textSize(32);
      text("You win!", 250, 150);
    }
    le=word.charAt(wpo);
    //System.out.println("o2 letter="+le);
    update=false;
    //o1 = new Obstacle(random(150, 200), random(-300, 20), false, word, le, 1);
    o2 = new Obstacle(random(300, 350), random(-350, 20), true, word, le, 2);
    // o3 = new Obstacle(random(400, 480), random(-250, 20), false, word, le, 3);
  }
  // coin.check();
  fill(255, 0, 0);
  textSize(32);
  //text("Score: " + score, 20, 30);
  text("Level: " + level, 250, 30);
  if (score==2500)
  {
    text("You win!", 200, 350); 
    stop=true;
  }
}

