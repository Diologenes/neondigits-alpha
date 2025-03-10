import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;

module Icons {

  function drawIcon(identifier as String or Null, dc as Dc, x as Number, y as Number, color as Graphics.ColorValue) as Void {
    if (identifier == null) {
        return;
    }

    var iconChar = null;
    switch(identifier) {
      case "calories": iconChar = (61269).toChar(); break;
      case "cardio": iconChar = (57659).toChar(); break;
      case "distance": iconChar = (59928).toChar(); break;
      case "steps": iconChar = (63601).toChar(); break;
      case "battery_1": iconChar = (61596).toChar(); break;
      case "battery_2": iconChar = (61597).toChar(); break;
      case "battery_3": iconChar = (61598).toChar(); break;
      case "battery_4": iconChar = (61599).toChar(); break;
      case "battery_5": iconChar = (61600).toChar(); break;
      case "battery_6": iconChar = (61601).toChar(); break;
      case "vo2": iconChar = (57636).toChar(); break;
      case "notification": iconChar = (59380).toChar(); break;
      case "calendar": iconChar = (58902).toChar(); break;
      case "elevate": iconChar = (59621).toChar(); break;
      case "clock": iconChar = (59480).toChar(); break;
      case "passedTime": iconChar = (59996).toChar(); break;
      case "stress": iconChar = (60024).toChar(); break;
      case "shield": iconChar = (62471).toChar(); break;
      case "stairs": iconChar = (62572).toChar(); break;
      case "time": iconChar = (63270).toChar(); break;
      case "recovery": iconChar = (62657).toChar(); break;

    }
    
    dc.setColor(color, Settings.getColor("colorTransparent"));
    dc.drawText(
      x, 
      y,
      Application.loadResource(Rez.Fonts.IconFont), 
      iconChar,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }
}