import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

class DateComponent extends WatchUi.Drawable {
  private var _centerX as Number;
  private var _centerY as Number;
  private var _height as Number;
  private var _yOffsetLine2 as Number;
  private var _colorValue as Graphics.ColorValue;
  private var _colorTransparent as Graphics.ColorValue;
  private var _font as Graphics.FontType;

  function initialize(params as Dictionary) {
    Drawable.initialize(params);
    _centerX = Settings.getNumber("centerX");
    _centerY = Settings.getNumber("centerY");
    _height = Settings.getNumber("height");
    _yOffsetLine2 = Settings.getNumber("yOffsetLine2");
    _colorValue = Settings.getColor("colorValue");
    _colorTransparent = Settings.getColor("colorTransparent");    
    _font = Settings.getFont("fontText");
  }

  function draw(dc) {  
    if (Settings.getBoolean("highPowerMode")) {
      drawContent(dc);
    }
  }

  private function drawContent(dc as Dc) as Void {
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

  private function getDate() as String {
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