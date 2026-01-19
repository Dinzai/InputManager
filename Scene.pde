

class Vec2
{
  Vec2(float x, float y)
  {
    this.x = x;
    this.y = y;
  }

   float x;
   float y;
}

interface Actionable
{
  void OnInput(Character keys);
}


class Entity implements Actionable
{
  Entity(float x, float y, float w, float h)
  {
    position = new Vec2(x, y);
    size = new Vec2(w, h);
    direction = new Vec2(0,0);
    accleration = new Vec2(5, 5);
    p = new Physics(this);
  }

  void OnInput(Character keys)
  {
    Move(keys);
  }

  void Move(Character keys)
  {
    if (keys == 'w')
    {
      direction = new Vec2(0, -1);
      
    }
    else if (keys == 's')
    {
      direction = new Vec2(0, 1);
    }
    else if (keys == 'a')
    {
      direction = new Vec2(-1, 0);
    }
    else if (keys == 'd')
    {
      direction = new Vec2(1, 0);
    }
    else
    {
      direction = new Vec2(0, 0);
    }
    p.Acclerate(direction, deltaTime);
  }

  void Render()
  {
    fill(255, 0, 0);
    rect(position.x, position.y, size.x, size.y);
  }

  Vec2 position;
  Vec2 size;
  Vec2 accleration;
  Physics p;
  Vec2 direction;
  
}

class Physics
{

  Physics(Entity e)
  {
    position = e.position;
    velocity = new Vec2(0, 0);
    accleration = e.accleration;
  }

  void Acclerate(Vec2 direction, float deltaTime)
  {
    velocity.x = accleration.x * direction.x;
    velocity.y = accleration.y * direction.y;

    position.x += velocity.x * deltaTime;
    position.y += velocity.y * deltaTime;
    
    
  }
  
  void Friction()
  {
    
  }



  Vec2 position;
  Vec2 velocity;
  Vec2 accleration;
}


class Manager
{
  Manager()
  {
    listeners = new ArrayList<Entity>();
    keyList = new ArrayList<Character>();
  }

  void AddListener(Entity e)
  {
    listeners.add(e);
  }

  void KeyDown(char keyType)
  {
    keyList.add(keyType);
  }

  void KeyUp(char keyType)
  {
    keyList.remove(keyType);
  }

  void NotifyListeners()
  {
    for (Entity e : listeners)
    {
      for (char c : keyList)
      {
        e.OnInput(c);
      }
    }
  }


  ArrayList<Entity> listeners;

  ArrayList<Character> keyList;
}

enum Layers
{
  BASE,
    MID,
    END
}

class Scene
{
  
  Scene()  
  {
    all = new HashMap<Layers, ArrayList<Entity>>();
    for(Layers layer : Layers.values())
    {
      all.put(layer, new ArrayList<>());
    }
  }
  
  void Clear()
  {
    background(55);
  }
  
  void AddTolayer(Layers layer, ArrayList<Entity> e)
  {
    all.get(layer).addAll(e);
  }
  
  void RenderLayers()
  {
    Clear();
    for (Layers layer : Layers.values()) {
      if (all.containsKey(layer)) {
        for (Entity e : all.get(layer)) {
          e.Render();
        }
      }
    }
  }

  HashMap<Layers, ArrayList<Entity>> all;
}





class Game
{
  Game()
  {
    s = new Scene();
    allEntity = new ArrayList<Entity>();
  }
  
  void Load()
  {
    Entity e = new Entity(200,200, 20, 20);
    m.AddListener(e);
    allEntity.add(e);
    
    s.AddTolayer(Layers.BASE, allEntity);
  }
  
  
  void Update()
  {
    m.NotifyListeners();
  }
  
  void Draw()
  {
    s.RenderLayers();
  }
  
  Scene s;
  
  ArrayList<Entity> allEntity;
  
}






void keyPressed()
{
  m.KeyDown(key);
}

void keyReleased()
{
  m.KeyDown(key);
}
