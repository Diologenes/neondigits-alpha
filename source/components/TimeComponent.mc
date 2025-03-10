import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class TimeComponent extends WatchUi.Drawable {
  private var _font;
  private var _xOffset = 0;
  private var _yOffset = 0;
  private var _centerX;
  private var _centerY;
  private var _lastMinute = -1;
  private var _colorDefault;
  private var _colorWhite;
  private var _colorTransparent;
  private var _colorTheme;

  function initialize(params) {
    Drawable.initialize(params);
    _centerX = Settings.get("centerX");
    _centerY = Settings.get("centerY");    
    _colorDefault = Settings.get("colorGrayLight");
    _colorWhite = Settings.get("colorWhite");
    _colorTransparent = Settings.get("colorTransparent");
    _font = Settings.get("fontTime");
  }

  function draw(dc as Dc) {
    var clockTime = System.getClockTime();
    _colorTheme = Settings.get("colorTheme");

    if (!Settings.get("highPowerMode")) {
      if (clockTime.min != _lastMinute) {
        generateOffset();
        _lastMinute = clockTime.min;
      }
    } else {
      _xOffset = 0;
      _yOffset = 0;
    }

    drawHours(dc, clockTime);
    drawMinutes(dc, clockTime);
  }

  private function drawHours(dc, clockTime) {
    var hours = clockTime.hour;
    if (!System.getDeviceSettings().is24Hour) {
      if (hours > 12) {
        hours = hours - 12;
      } 
    }

    var value = hours.format("%02d");
    var firstDigit = value.substring(0, 1);
    var secondDigit = value.substring(1, 2);

    var color = Settings.get("highPowerMode") ? _colorWhite : _colorDefault;
    dc.setColor(color, _colorTransparent);

    dc.drawText(
      _centerX - 80 + _xOffset, 
      _centerY + _yOffset,
      _font,
      firstDigit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
    dc.drawText(
      _centerX - 30 + _xOffset, 
      _centerY + _yOffset,
      _font,
      secondDigit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  private function drawMinutes(dc, clockTime) {
    var value = clockTime.min.format("%02d");
    var firstDigit = value.substring(0, 1);
    var secondDigit = value.substring(1, 2);

    var color = Settings.get("highPowerMode") ? _colorTheme : _colorDefault;
    dc.setColor(color, _colorTransparent);

    dc.drawText(
      _centerX + 30 + _xOffset, 
      _centerY + _yOffset,
      _font,
      firstDigit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
    dc.drawText(
      _centerX + 80 + _xOffset, 
      _centerY + _yOffset,
      _font,
      secondDigit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  private function generateOffset() {
    _xOffset = (Math.rand() % 41) - 20;
    _yOffset = (Math.rand() % 41) - 20;
  }
}