import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;


class DataTopComponent extends WatchUi.Drawable {
  var centerX;
  var centerY;
  var colorGrayDark;
  var colorTransparent;
  var colorTheme;
  var radius;

  function initialize(params) { 
    Drawable.initialize(params); 
    centerX = Settings.get("centerX");
    centerY = Settings.get("centerY");
    colorGrayDark = Settings.get("colorGrayDark");
    colorTransparent = Settings.get("colorTransparent");
    radius = Settings.get("width") / 2.0 - 15;
  }

  function draw(dc as Dc) {
    colorTheme = Settings.get("colorTheme");

    if (Settings.get("highPowerMode")) {
      drawTimeLime(dc);
    }
  }

  private function drawTimeLime(dc) {
    var clockTime = System.getClockTime();
    var hourToMin = (clockTime.hour * 60) + clockTime.min;
    // 0.000694444 = 1 / 1440 (max minutes a day)
    var minutesOfDayPercent = ((hourToMin * 0.000694444) * 100).toNumber(); 

    var startDegree = 135;
    var endDegree = 45;
    var spanDegree = startDegree - endDegree; 
    var diff = ((minutesOfDayPercent * 0.01) * spanDegree).toNumber();
    var activeEndDegree = startDegree - diff;
    if (diff == 0) {
      activeEndDegree = startDegree - 1;
    }
    
    dc.setPenWidth(3);
    dc.setColor(colorTheme, colorTransparent);
    dc.drawArc(centerX, centerY, radius, Graphics.ARC_CLOCKWISE, startDegree, activeEndDegree);

    dc.setColor(colorGrayDark, colorTransparent);
    dc.drawArc(centerX, centerY, radius, Graphics.ARC_CLOCKWISE, activeEndDegree, endDegree);
    dc.setPenWidth(1);
  }
}