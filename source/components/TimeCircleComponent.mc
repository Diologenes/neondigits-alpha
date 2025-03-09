import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;


class TimeCircleComponent extends WatchUi.Drawable {
  var centerX;
  var centerY;
  var colorGrayDark;
  var colorTransparent;
  var colorTheme;
  var radius;
  var arcType;
  var clockTime;

  function initialize(params) { 
    Drawable.initialize(params); 
    centerX = Settings.get("centerX");
    centerY = Settings.get("centerY");
    colorGrayDark = Settings.get("colorGrayDark");
    colorTransparent = Settings.get("colorTransparent");
    radius = Settings.get("width") / 2.0 - 3;
  }

  function draw(dc as Dc) {
    var timeCircleType = Settings.get("timeCircleType");
    if (Settings.get("highPowerMode") && timeCircleType != TIME_CIRCLE_TYPE_DISABLED) {
      colorTheme = Settings.get("colorTheme");
      clockTime = System.getClockTime();

      switch(timeCircleType) {
        case TIME_CIRCLE_TYPE_SECONDS_CIRCLE: drawSecondsCircle(dc); break;
        case TIME_CIRCLE_TYPE_SECONDS_DOT: drawSecondsDot(dc); break;
      }
    }
  }

  private function drawSecondsCircle(dc) {
    var response = getDegreeValuesForSeconds() as Dictionary<Symbol, Number>;

    dc.setPenWidth(2);
    dc.setColor(colorTheme, colorTransparent);
    dc.drawArc(centerX, centerY, radius, Graphics.ARC_CLOCKWISE, response[:startDegree], response[:endDegree]);
    dc.setPenWidth(1);
  }

  private function drawSecondsDot(dc) {
    var response = getDegreeValuesForSeconds() as Dictionary<Symbol, Number>;

    dc.setPenWidth(6);
    dc.setColor(colorTheme, colorTransparent);
    dc.drawArc(centerX, centerY, radius, Graphics.ARC_CLOCKWISE, (response[:endDegree] + 3), (response[:endDegree] - 2));
    dc.setPenWidth(1);
  }

  private function getDegreeValuesForSeconds() {
    var percentage = clockTime.sec / 60.0 * 100;
    var startDegree = 90;
    var diff = ((percentage * 0.01) * 360).toNumber();

    return {
      :startDegree => startDegree,
      :endDegree => startDegree - diff
    };
  }
}