int sizeX = 700;
int sizeY = 500;

int numberOfBalls = 11;
PVector [] ball_pos = new PVector[numberOfBalls];
PVector [] ball_speed = new PVector[numberOfBalls];
color [] ball_color = new color[numberOfBalls];
float [] ball_size = new float[numberOfBalls];

float hue = 150;
float saturation = 255;
float brightness= 210;
float transparency = 200;

int maxSpeed = 5;
int minSpeed = 1 ;

int f = 0;




void setup(){
  size(700,500);
  colorMode(HSB, 255);
  stroke(255,50);
  
  for(int i = 0 ; i < ball_pos.length;i++){
    
    //individual ball speed between 1 and 5 
    
    ball_speed[i] = new PVector((int)random(maxSpeed)+minSpeed,(int)random(maxSpeed-minSpeed)+minSpeed);
    //individual ball size based on speed
    //slow balls are bigger while faster balls are smaller
    float ball_speed_max = max(ball_speed[i].x,ball_speed[i].y);
    float ball_speed_range = (ball_speed_max - minSpeed)/maxSpeed;//LERP PREPARATION
    ball_size[i] = lerp(120,0.1,ball_speed_range); //lerp(value if 0, value if 1, rate of change);
    
    
    //individual ball position = random but greater than surrounding borders
    ball_pos[i] = new PVector(random(sizeX/2)+sizeX/4,random(sizeY/2)+sizeX/4); 
    
    //randomize direction
    if(i%2==0)ball_speed[i].x *= -1;
    if(i%3==0)ball_speed[i].y *= -1;
    
    //initial color
    ball_color[i] = color(hue,random(100)+155,brightness,transparency);
    
  }
}

void draw(){
  f+=1;
  
  clear();
  background(hue,saturation,brightness);
  if(mousePressed){
    background(255);
  }
  
  
  for(int i = 0 ; i < ball_pos.length;i++){
    
    fill(ball_color[i]);
    //draw ball[i]
    
    float ballsizeX = ball_size[i]+(sin((f+i)*0.1)*10);
    float ballsizeY = ball_size[i]+(sin((f+i)*0.1)*10);
    ellipse(ball_pos[i].x,ball_pos[i].y,ballsizeX,ballsizeX);
    
   
    //if hit top or bottom walls
    //change y direction 
    //change color
    if(ball_pos[i].y > sizeY+ball_size[i] || ball_pos[i].y < -ball_size[i]){
      ball_speed[i].y *= -1;
      ball_color[i] = color(hue,(int)random(50)+100,brightness,transparency);
      ball_pos[i].x = random(sizeX/2)+sizeX/4;
    }
    //if hit left or right walls
    //change x direction
    if(ball_pos[i].x > sizeX+ball_size[i] || ball_pos[i].x < -ball_size[i]){
       ball_color[i] = color(hue,random(100)+155,brightness,transparency);
       ball_speed[i].x *= -1;
       ball_pos[i].y = random(sizeY/2)+sizeY/4;
       
    }
      
    ball_pos[i].x += ball_speed[i].x;
    ball_pos[i].y += ball_speed[i].y;
    
  }
}
