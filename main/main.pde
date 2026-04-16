//Interactable, and Renderable are meant to be a template

//Main is our entry point

Button b;
Button b2;

int WindowWidth = 800;
int WindowHeight = 600;


void settings()
{    
  size(WindowWidth, WindowHeight);

}

void setup()
{
  b = new Button(WindowWidth / 2, WindowHeight / 2, 100, 100);
  b2 = new Button(WindowWidth / 2 + 40, WindowHeight / 2, 30, 30);
  
  render.AddToLayer(Layers.BACKGROUND, b);
  Input.AddMouseListener(b);
  
  render.AddToLayer(Layers.ENTITY, b2);
  Input.AddMouseListener(b2);

}

void draw()
{
  
  background(55);

  //== FIXED UPDATE ======================
  Input.NotifyEvent();

  //== UPDATE ======================

  //== DRAW ======================
  render.DrawToScreen();

}
