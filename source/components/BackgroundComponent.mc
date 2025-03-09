import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class BackgroundComponent extends WatchUi.Drawable {
  var dc;
  var colorForeground;
  var colorBackground;
  var width;
  var centerX;
  var centerY;
  var yOffsetLine1;
  var yOffsetLine2;

  function initialize(params) {
    Drawable.initialize(params);
    colorForeground = Settings.get("colorGrayDark");
    colorBackground = Settings.get("colorTransparent");
    width = Settings.get("width");
    centerX = Settings.get("centerX");
    centerY = Settings.get("centerY");
    yOffsetLine1 = Settings.get("yOffsetLine1");
    yOffsetLine2 = Settings.get("yOffsetLine2");
  }

  function draw(dc) {
    if (Settings.get("highPowerMode") == false) {
      self.dc = dc;
      drawStaticBackground();
    }
  }

  private function drawStaticBackground() {
    self.dc.setColor(colorForeground, colorBackground);
    
    self.hDividers();
    self.vDividerTop();

    if (Settings.get("useSeconds") == false) {
      self.vDividerBottom();  
    }
  }

  private function hDividers() {
    var x1 = 40;
    var x2 = width - x1;
    var y = 0;

    y = centerY - yOffsetLine1;
    self.dc.drawLine(x1, y, x2, y);

    y = centerY - yOffsetLine2;
    self.dc.drawLine(x1 * 2, y, x2 - x1, y);

    y = centerY + yOffsetLine1;
    self.dc.drawLine(x1, y, x2, y);

    y = centerY + yOffsetLine2;
    self.dc.drawLine(x1 * 2, y, x2 - x1, y);
  }

  private function vDividerTop() {
    var padding = 10;
    var x = centerX;
    var y1 = centerY - yOffsetLine1 - padding;
    var y2 = centerY - yOffsetLine2 + padding;
    self.dc.drawLine(x, y1, x, y2);
  }

    private function vDividerBottom() {
    var padding = 10;
    var x = centerX;
    var y1 = centerY + yOffsetLine1 + padding;
    var y2 = centerY + yOffsetLine2 - padding;
    self.dc.drawLine(x, y1, x, y2);
  }

}


