import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class TimeComponent extends WatchUi.Drawable {
  var font;
  var xOffset = 0;
  var yOffset = 0;
  var centerX;
  var centerY;
  var lastMinute = -1;
  var colorDefault;
  var colorWhite;
  var colorTransparent;
  var colorTheme;

  function initialize(params) {
    Drawable.initialize(params);
    centerX = Settings.get("centerX");
    centerY = Settings.get("centerY");    
    colorDefault = Settings.get("colorGrayLight");
    colorWhite = Settings.get("colorWhite");
    colorTransparent = Settings.get("colorTransparent");
    font = Settings.getTimeFont();
  }

  function draw(dc as Dc) {
    var clockTime = System.getClockTime();
    colorTheme = Settings.get("colorTheme");

    if (!Settings.get("highPowerMode") && clockTime.min != lastMinute) {
      generateOffset();
      lastMinute = clockTime.min;
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

    var color = Settings.get("highPowerMode") ? colorWhite : colorDefault;
    dc.setColor(color, colorTransparent);

    dc.drawText(
      centerX - 80 + xOffset, 
      centerY + yOffset,
      self.font,
      firstDigit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
    dc.drawText(
      centerX - 30 + xOffset, 
      centerY + yOffset,
      self.font,
      secondDigit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  private function drawMinutes(dc, clockTime) {
    var value = clockTime.min.format("%02d");
    var firstDigit = value.substring(0, 1);
    var secondDigit = value.substring(1, 2);

    var color = Settings.get("highPowerMode") ? colorTheme : colorDefault;
    dc.setColor(color, colorTransparent);

    dc.drawText(
      centerX + 30 + xOffset, 
      centerY + yOffset,
      self.font,
      firstDigit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
    dc.drawText(
      centerX + 80 + xOffset, 
      centerY + yOffset,
      self.font,
      secondDigit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  private function generateOffset() {
    self.xOffset = Math.rand() % 11 - 5;
    self.yOffset = Math.rand() % 11 - 5;
  }
}