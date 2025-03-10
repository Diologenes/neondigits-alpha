import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class BackgroundComponent extends WatchUi.Drawable {
  private var _colorForeground as Graphics.ColorValue;
  private var _colorBackground as Graphics.ColorValue;
  private var _width as Number;
  private var _centerX as Number;
  private var _centerY as Number;
  private var _yOffsetLine1 as Number;
  private var _yOffsetLine2 as Number;

  function initialize(params as Dictionary) {
    Drawable.initialize(params);
    _colorForeground = Settings.getColor("colorGrayDark");
    _colorBackground = Settings.getColor("colorTransparent");
    _width = Settings.getNumber("width");
    _centerX = Settings.getNumber("centerX");
    _centerY = Settings.getNumber("centerY");
    _yOffsetLine1 = Settings.getNumber("yOffsetLine1");
    _yOffsetLine2 = Settings.getNumber("yOffsetLine2");
  }

  function draw(dc as Dc) {
    if (Settings.getBoolean("highPowerMode")) {
      drawStaticBackground(dc);
    }
  }

  private function drawStaticBackground(dc as Dc) as Void {
    dc.setColor(_colorForeground, _colorBackground);
    
    hDividers(dc);
    vDividerTop(dc);

    if (Settings.getBoolean("useSeconds") == false) {
      vDividerBottom(dc);  
    }
  }

  private function hDividers(dc as Dc) as Void {
    var x1 = 40;
    var x2 = _width - x1;
    var y = 0;

    y = _centerY - _yOffsetLine1;
    dc.drawLine(x1, y, x2, y);

    y = _centerY - _yOffsetLine2;
    dc.drawLine(x1 * 2, y, x2 - x1, y);

    y = _centerY + _yOffsetLine1;
    dc.drawLine(x1, y, x2, y);

    y = _centerY + _yOffsetLine2;
    dc.drawLine(x1 * 2, y, x2 - x1, y);
  }

  private function vDividerTop(dc as Dc) as Void {
    var padding = 10;
    var x = _centerX;
    var y1 = _centerY - _yOffsetLine1 - padding;
    var y2 = _centerY - _yOffsetLine2 + padding;
    dc.drawLine(x, y1, x, y2);
  }

    private function vDividerBottom(dc as Dc) as Void {
    var padding = 10;
    var x = _centerX;
    var y1 = _centerY + _yOffsetLine1 + padding;
    var y2 = _centerY + _yOffsetLine2 - padding;
    dc.drawLine(x, y1, x, y2);
  }

}


