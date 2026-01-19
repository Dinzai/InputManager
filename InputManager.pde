
float previousTime;
float deltaTime;

Manager m;
Game g;

void setup()
{
  m = new Manager();
  size(400, 400);
  g = new Game();
  g.Load();
  
}



void draw()
{
  CalculateDeltaTime();
  g.Update();
  g.Draw();
}


void CalculateDeltaTime()
{
  float currentTime = millis();
  deltaTime = (currentTime - previousTime) / 1000.0;
  previousTime = currentTime;
}
