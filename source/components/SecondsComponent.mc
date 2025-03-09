import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SecondsComponent extends WatchUi.Drawable {
  var yOffset as Number = 85;
  var squareSize = 80; 
  var halfSquareSize = squareSize / 2;
  var centerX;
  var centerY;
  var x;
  var y;
  var colorBlack;
  var colorGrayDark;
  var colorTransparent;
  var colorValue;
  var font;

  function initialize(params) {
    Drawable.initialize(params);
    centerX = Settings.get("centerX");
    centerY = Settings.get("centerY");
    x = Settings.get("centerX") - halfSquareSize;
    y = Settings.get("centerY") - halfSquareSize + yOffset;  
    colorBlack = Settings.get("colorBlack");
    colorGrayDark = Settings.get("colorGrayDark");
    colorTransparent = Settings.get("colorTransparent");
    colorValue = Settings.get("colorValue");
    font = Settings.get("fontSeconds");
  }

  function draw(dc as Dc) {
    if (Settings.get("useSeconds") && Settings.get("highPowerMode")) {
      drawBackground(dc); 
      drawSeconds(dc);
    }
  }

  private function drawBackground(dc) {
    dc.setColor(colorBlack, colorBlack);
    dc.fillRectangle(x, y, squareSize, squareSize);
    
    dc.setColor(colorGrayDark, colorTransparent);
    dc.setPenWidth(2);
    dc.drawRectangle(x , y, squareSize, squareSize);
    dc.clear();
  }

  private function drawSeconds(dc) {
    var clockTime = System.getClockTime();

    dc.setColor(colorValue, colorTransparent);
    dc.drawText(
      centerX, 
      centerY + yOffset,
      font, 
      clockTime.sec.format("%02d"),
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }
}