import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;

module Icons {

  function drawIcon(identifier, dc, x, y, color) {
    if (identifier == null) {
        return;
    }

    var iconChar = null;
    switch(identifier) {
      case "calories": iconChar = "h"; break;
      case "cardio": iconChar = "b"; break;
      case "distance": iconChar = "i"; break;
      case "steps": iconChar = "p"; break;
      case "battery_1": iconChar = "i"; break;
      case "battery_2": iconChar = "j"; break;
      case "battery_3": iconChar = "k"; break;
      case "battery_4": iconChar = "l"; break;
      case "battery_5": iconChar = "m"; break;
      case "battery_6": iconChar = "n"; break;
      case "weather": iconChar = "d"; break;
      case "altitude": iconChar = "f"; break;
      case "vo": iconChar = "a";
      case "notification": iconChar = "d"; break;
      case "calendar": iconChar = "c"; break;
      case "clock": iconChar = "o"; break;
    }
    
    dc.setColor(color, Settings.get("colorTransparent"));
    dc.drawText(
      x, 
      y,
      Application.loadResource(Rez.Fonts.IconFont), 
      iconChar,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }
}