
import java.util.Map;
//Brett Rogers March 25, 2026
//feel free to add to the layer system
enum Layers
{
  BACKGROUND,
    ENTITY,
    EFFECTS,
    UI,
}

interface Renderable// a complex object needs to implment this
{
  void DrawToScreen();
}

class DrawOrder
{

  DrawOrder()
  {
    renderLayers = new HashMap<Layers, ArrayList<Renderable>>();

    for (Layers layer : Layers.values())
    {
      renderLayers.put(layer, new ArrayList<Renderable>());
    }
  }

  //call AddToLayers, pass which layer it belongs to, thats it, DrawToScreen is already called

  void AddToLayer(Layers layer, Renderable obj)
  {
    renderLayers.get(layer).add(obj);
  }

  void RemoveFromLayer(Layers layer, Renderable obj)
  {
    renderLayers.get(layer).remove(obj);
  }

  void DrawToScreen()
  {
    for (Layers layer : Layers.values())
    {
      ArrayList<Renderable> objects = renderLayers.get(layer);
      for (Renderable obj : objects)
      {
        obj.DrawToScreen();
      }
    }
  }

  HashMap<Layers, ArrayList<Renderable>> renderLayers;
}
DrawOrder render = new DrawOrder();
