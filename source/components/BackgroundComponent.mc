import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class BackgroundComponent extends WatchUi.Drawable {
  private var _dc;
  private var _colorForeground;
  private var _colorBackground;
  private var _width;
  private var _centerX;
  private var _centerY;
  private var _yOffsetLine1;
  private var _yOffsetLine2;

  function initialize(params) {
    Drawable.initialize(params);
    _colorForeground = Settings.get("colorGrayDark");
    _colorBackground = Settings.get("colorTransparent");
    _width = Settings.get("width");
    _centerX = Settings.get("centerX");
    _centerY = Settings.get("centerY");
    _yOffsetLine1 = Settings.get("yOffsetLine1");
    _yOffsetLine2 = Settings.get("yOffsetLine2");
  }

  function draw(dc) {
    if (Settings.get("highPowerMode")) {
      self._dc = dc;
      drawStaticBackground();
    }
  }

  private function drawStaticBackground() {
    self._dc.setColor(_colorForeground, _colorBackground);
    
    self.hDividers();
    self.vDividerTop();

    if (Settings.get("useSeconds") == false) {
      self.vDividerBottom();  
    }
  }

  private function hDividers() {
    var x1 = 40;
    var x2 = _width - x1;
    var y = 0;

    y = _centerY - _yOffsetLine1;
    self._dc.drawLine(x1, y, x2, y);

    y = _centerY - _yOffsetLine2;
    self._dc.drawLine(x1 * 2, y, x2 - x1, y);

    y = _centerY + _yOffsetLine1;
    self._dc.drawLine(x1, y, x2, y);

    y = _centerY + _yOffsetLine2;
    self._dc.drawLine(x1 * 2, y, x2 - x1, y);
  }

  private function vDividerTop() {
    var padding = 10;
    var x = _centerX;
    var y1 = _centerY - _yOffsetLine1 - padding;
    var y2 = _centerY - _yOffsetLine2 + padding;
    self._dc.drawLine(x, y1, x, y2);
  }

    private function vDividerBottom() {
    var padding = 10;
    var x = _centerX;
    var y1 = _centerY + _yOffsetLine1 + padding;
    var y2 = _centerY + _yOffsetLine2 - padding;
    self._dc.drawLine(x, y1, x, y2);
  }

}


