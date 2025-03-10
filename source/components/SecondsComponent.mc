import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SecondsComponent extends WatchUi.Drawable {
  private var _yOffset as Number = 85;
  private var _squareSize = 80; 
  private var _halfSquareSize = _squareSize / 2;
  private var _centerX;
  private var _centerY;
  private var _x;
  private var _y;
  private var _colorBlack;
  private var _colorGrayDark;
  private var _colorTransparent;
  private var _colorValue;
  private var _font;

  function initialize(params) {
    Drawable.initialize(params);
    _centerX = Settings.get("centerX");
    _centerY = Settings.get("centerY");
    _x = Settings.get("centerX") - _halfSquareSize;
    _y = Settings.get("centerY") - _halfSquareSize + _yOffset;  
    _colorBlack = Settings.get("colorBlack");
    _colorGrayDark = Settings.get("colorGrayDark");
    _colorTransparent = Settings.get("colorTransparent");
    _colorValue = Settings.get("colorValue");
    _font = Settings.get("fontSeconds");
  }

  function draw(dc as Dc) {
    if (Settings.get("useSeconds") && Settings.get("highPowerMode")) {
      drawBackground(dc); 
      drawSeconds(dc);
    }
  }

  private function drawBackground(dc) {
    dc.setColor(_colorBlack, _colorBlack);
    dc.fillRectangle(_x, _y, _squareSize, _squareSize);
    
    dc.setColor(_colorGrayDark, _colorTransparent);
    dc.setPenWidth(2);
    dc.drawRectangle(_x , _y, _squareSize, _squareSize);
    dc.clear();
  }

  private function drawSeconds(dc) {
    var clockTime = System.getClockTime();

    dc.setColor(_colorValue, _colorTransparent);
    dc.drawText(
      _centerX, 
      _centerY + _yOffset,
      _font, 
      clockTime.sec.format("%02d"),
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }
}