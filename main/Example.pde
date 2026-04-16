//this is an example of the use case
//A Button can be interacted with, and Rendered
class Button implements Renderable, MouseListener
{

  Button(float x, float y, float w, float h)
  {
    colour = new Colour[4];//make the array

    for (int i = 0; i < 4; i++)
    {
      colour[i] = new Colour();//allocate
    }

    colour[0].SetColour(30, 30, 30, 255);//Base Colour
    colour[1].SetColour(0, 200, 200, 255);//Hovered Colour
    colour[2].SetColour(255, 100, 100, 255);//Clicked Colour
    colour[3].SetColour(colour[0]);//Current Colour

    transform.position.x = x;
    transform.position.y = y;

    transform.size.x = w;
    transform.size.y = h;
  }

  boolean OnHovered()
  {
    return (mouseX > transform.position.x - transform.size.x / 2 && mouseX < transform.position.x + transform.size.x / 2
      && mouseY > transform.position.y - transform.size.y / 2 && mouseY < transform.position.y + transform.size.y / 2);
  }

  void OnClick(HashSet<Integer> clicked)
  {
    if (OnHovered() && !clicked.contains(LEFT))
    {
      colour[3].SetColour(colour[1]);
    }
    if (OnHovered() && clicked.contains(LEFT))
    {
      colour[3].SetColour(colour[2]);
    }
    if (!OnHovered())
    {
      colour[3].SetColour(colour[0]);
    }
  }

  void OnPressed(HashSet<Integer> held)
  {
    if (OnHovered() && held.contains(LEFT)) 
    {
      transform.SetPosition(mouseX, mouseY);
    }
  }


  void DrawToScreen()
  {
    fill(colour[3].red, colour[3].green, colour[3].blue, colour[3].alpha);
    rect(transform.position.x - transform.size.x / 2, transform.position.y - transform.size.y / 2, transform.size.x, transform.size.y);
  }

  Transform transform = new Transform();
  Colour[] colour;
}

//c Style struct
class Transform
{

  void SetPosition(float x, float y)
  {
    position.x = x;
    position.y = y;
  }

  void SetSize(float w, float h)
  {
    size.x = w;
    size.y = h;
  }

  PVector position = new PVector();
  PVector size = new PVector();
}

class Colour
{
  void SetColour(int r, int g, int b, int a)
  {
    red = r;
    green = g;
    blue = b;
    alpha = a;
  }

  void SetColour(Colour c)
  {
    red = c.red;
    green = c.green;
    blue = c.blue;
    alpha = c.alpha;
  }

  int red;
  int green;
  int blue;
  int alpha;
}
