import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SecondsComponent extends WatchUi.Drawable {
  private var _yOffset as Number = 85;
  private var _squareSize as Number = 80; 
  private var _halfSquareSize as Number = _squareSize / 2;
  private var _centerX as Number;
  private var _centerY as Number;
  private var _x as Number;
  private var _y as Number;
  private var _colorBlack as Graphics.ColorValue;
  private var _colorGrayDark as Graphics.ColorValue;
  private var _colorTransparent as Graphics.ColorValue;
  private var _colorValue as Graphics.ColorValue;
  private var _font as Graphics.FontType;

  function initialize(params as Dictionary) {
    Drawable.initialize(params);
    _centerX = Settings.getNumber("centerX");
    _centerY = Settings.getNumber("centerY");
    _x = Settings.getNumber("centerX") - _halfSquareSize;
    _y = Settings.getNumber("centerY") - _halfSquareSize + _yOffset;  
    _colorBlack = Settings.getColor("colorBlack");
    _colorGrayDark = Settings.getColor("colorGrayDark");
    _colorTransparent = Settings.getColor("colorTransparent");
    _colorValue = Settings.getColor("colorValue");
    _font = Settings.getFont("fontSeconds");
  }

  function draw(dc as Dc) {
    if (Settings.getBoolean("useSeconds") && Settings.getBoolean("highPowerMode")) {
      drawBackground(dc); 
      drawSeconds(dc);
    }
  }

  private function drawBackground(dc as Dc) as Void {
    dc.setColor(_colorBlack, _colorBlack);
    dc.fillRectangle(_x, _y, _squareSize, _squareSize);
    
    dc.setColor(_colorGrayDark, _colorTransparent);
    dc.setPenWidth(2);
    dc.drawRectangle(_x , _y, _squareSize, _squareSize);
    dc.clear();
  }

  private function drawSeconds(dc as Dc) as Void {
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