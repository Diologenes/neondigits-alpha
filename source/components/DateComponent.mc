import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

class DateComponent extends WatchUi.Drawable {
  var centerX;
  var centerY;
  var height;
  var yOffsetLine2;
  var colorValue;
  var colorTransparent;
  var font;

  function initialize(params) {
    Drawable.initialize(params);
    centerX = Settings.get("centerX");
    centerY = Settings.get("centerY");
    height = Settings.get("height");
    yOffsetLine2 = Settings.get("yOffsetLine2");
    colorValue = Settings.get("colorValue");
    colorTransparent = Settings.get("colorTransparent");    
    font = Settings.getTextFont();
  }

  function draw(dc) {  
    if (Settings.get("highPowerMode")) {
      drawContent(dc);
    }
  }

  private function drawContent(dc) {
    dc.setColor(colorValue, colorTransparent);

    var yOffset = ((height - (centerY + yOffsetLine2)) / 2) + 5;

    dc.drawText(
      centerX, 
      yOffset,
      font, 
      getDate(),
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  private function getDate() {
    var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    return Lang.format(
        "$1$ $2$",
        [
            today.month,
            today.day,
        ]
    );
  }
}