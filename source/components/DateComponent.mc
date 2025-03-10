import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

class DateComponent extends WatchUi.Drawable {
  private var _centerX;
  private var _centerY;
  private var _height;
  private var _yOffsetLine2;
  private var _colorValue;
  private var _colorTransparent;
  private var _font;

  function initialize(params) {
    Drawable.initialize(params);
    _centerX = Settings.get("centerX");
    _centerY = Settings.get("centerY");
    _height = Settings.get("height");
    _yOffsetLine2 = Settings.get("yOffsetLine2");
    _colorValue = Settings.get("colorValue");
    _colorTransparent = Settings.get("colorTransparent");    
    _font = Settings.get("fontText");
  }

  function draw(dc) {  
    if (Settings.get("highPowerMode")) {
      drawContent(dc);
    }
  }

  private function drawContent(dc) {
    dc.setColor(_colorValue, _colorTransparent);

    var yOffset = ((_height - (_centerY + _yOffsetLine2)) / 2) + 5;

    dc.drawText(
      _centerX, 
      yOffset,
      _font, 
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