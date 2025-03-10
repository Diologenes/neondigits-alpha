import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class TimeComponent extends WatchUi.Drawable {
  private var _font as Graphics.FontType;
  private var _xOffset as Number = 0;
  private var _yOffset as Number = 0;
  private var _centerX as Number;
  private var _centerY as Number;
  private var _lastMinute as Number = -1;
  private var _colorDefault as Graphics.ColorValue;
  private var _colorWhite as Graphics.ColorValue;
  private var _colorTransparent as Graphics.ColorValue;
  private var _colorTheme as Graphics.ColorValue;

  function initialize(params as Dictionary) {
    Drawable.initialize(params);
    _centerX = Settings.getNumber("centerX");
    _centerY = Settings.getNumber("centerY");    
    _colorDefault = Settings.getColor("colorGrayLight");
    _colorWhite = Settings.getColor("colorWhite");
    _colorTransparent = Settings.getColor("colorTransparent");
    _font = Settings.getFont("fontTime");
    _colorTheme = Settings.getColor("colorTheme");
  }

  function draw(dc as Dc) {
    var clockTime = System.getClockTime();
    _colorTheme = Settings.getColor("colorTheme");

    if (!Settings.getBoolean("highPowerMode")) {
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

  private function drawHours(dc as Dc, clockTime as System.ClockTime) as Void {
    var hours = clockTime.hour;
    if (!System.getDeviceSettings().is24Hour) {
      if (hours > 12) {
        hours = hours - 12;
      } 
    }

    var value = hours.format("%02d");
    var firstDigit = value.substring(0, 1);
    var secondDigit = value.substring(1, 2);

    var color = Settings.getBoolean("highPowerMode") ? _colorWhite : _colorDefault;
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

  private function drawMinutes(dc as Dc, clockTime as System.ClockTime) as Void {
    var value = clockTime.min.format("%02d");
    var firstDigit = value.substring(0, 1);
    var secondDigit = value.substring(1, 2);

    var color = Settings.getBoolean("highPowerMode") ? _colorTheme : _colorDefault;
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

  private function generateOffset() as Void {
    _xOffset = (Math.rand() % 41) - 20;
    _yOffset = (Math.rand() % 41) - 20;
  }
}