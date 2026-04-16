import java.util.HashSet;

//Brett Rogers March 25th, 2026


//This would be implmented by something that uses keys
interface KeyListener
{
  void OnClick(HashSet<Character> clickedKeys);//single input result
  void OnHeld(HashSet<Character> heldKeys);//while held
}

//this would be implmented by something that uses the mouse
interface MouseListener
{
  boolean OnHovered();
  void OnClick(HashSet<Integer> clicked);//once clicked
  void OnPressed(HashSet<Integer> held);//while held
}
//this input manager works by Listening to a list of listeners, and managing those resolutions
class InputManager
{
  InputManager()
  {
    keyListeners = new ArrayList<KeyListener>();
    mouseListeners = new ArrayList<MouseListener>();

    keysClicked = new HashSet<Character>();
    keysHeld = new HashSet<Character>();
    
    mouseClicked = new HashSet<Integer>();
    mouseHeld = new HashSet<Integer>();
    
  }
//keys and mouse listeners are added and removed
  void AddKeyListener(KeyListener k)
  {
    keyListeners.add(k);
  }

  void RemoveKeyListener(KeyListener k)
  {
    keyListeners.remove(k);
  }

  void AddMouseListener(MouseListener m)
  {
    mouseListeners.add(m);
  }

  void RemoveMouseListener(MouseListener m)
  {
    mouseListeners.remove(m);
  }
// When a key is pressed, it will add to keys clicked once, and added to keys held while held
//the mouse works the same way
  void KeyDown(char key)
  {
        
    if (!keysHeld.contains(key))
    {
      keysClicked.add(key);
    }

    keysHeld.add(key);
    
  }

  void KeyUp(char key)
  {
    keysHeld.remove(key);
  }

  void MouseDown(int button)
  {
    if (!mouseHeld.contains(button))
    {
      mouseClicked.add(button);
    }

    mouseHeld.add(button);
  }

  void MouseUp(int button)
  {
    mouseHeld.remove(button);
  }
//notify event is being checked in the main draw loop
//changed these to itterate over a copy, since we will be adding/removing on transitions
  void NotifyEvent()
  {
    for (KeyListener k : new ArrayList<KeyListener>(keyListeners))
    {
      k.OnHeld(keysHeld);
      k.OnClick(keysClicked);
    }

    for (MouseListener m : new ArrayList<MouseListener>(mouseListeners))
    {
      m.OnHovered();
      m.OnPressed(mouseHeld);
      m.OnClick(mouseClicked);
    }

    mouseClicked.clear();
  }

  ArrayList<KeyListener> keyListeners;
  ArrayList<MouseListener> mouseListeners;

  HashSet<Character> keysHeld;
  HashSet<Character> keysClicked;
  
  HashSet<Integer> mouseHeld;
  HashSet<Integer> mouseClicked;
}
//Global 
InputManager Input = new InputManager();


void keyPressed()
{
  Input.KeyDown(key);
}

void keyReleased()
{
  Input.KeyUp(key);
}

void mousePressed()
{
  Input.MouseDown(mouseButton);
}

void mouseReleased()
{
  Input.MouseUp(mouseButton);
}
