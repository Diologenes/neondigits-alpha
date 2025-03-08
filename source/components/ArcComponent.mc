import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;


class ArcComponent extends WatchUi.Drawable {
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
    radius = Settings.get("width") / 2.0 - 8;
  }

  function draw(dc as Dc) {
    var arcType = Settings.get("arcType");
    if (Settings.get("highPowerMode") && arcType != ARC_TYPE_DISABLED) {
      colorTheme = Settings.get("colorTheme");
      clockTime = System.getClockTime();

      switch(arcType) {
        case ARC_TYPE_SECONDS_CIRCLE: drawSecondsCircle(dc); break;
        case ARC_TYPE_SECONDS_DOT: drawSecondsDot(dc); break;
        case ARC_TYPE_DAY: drawDayCycle(dc); break;
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

  private function drawDayCycle(dc) {
    var response = getDegreeValuesForDay() as Dictionary<Symbol, Number>;
    var arcRadius = radius - 4;
    dc.setPenWidth(3);
    dc.setColor(colorTheme, colorTransparent);
    dc.drawArc(centerX, centerY, arcRadius, Graphics.ARC_CLOCKWISE, response[:startDegree], response[:activeDegree]);

    dc.setColor(colorGrayDark, colorTransparent);
    dc.drawArc(centerX, centerY, arcRadius, Graphics.ARC_CLOCKWISE, response[:activeDegree], response[:endDegree]);
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

  private function getDegreeValuesForDay() {
    var hourToMin = (clockTime.hour * 60) + clockTime.min;
    var minutesOfDayPercent = ((hourToMin * 0.000694444) * 100).toNumber(); // 0.000694444 = 1 / 1440 (max minutes a day)

    var startDegree = 135;
    var endDegree = 45;
    var spanDegree = startDegree - endDegree; 
    var diff = ((minutesOfDayPercent * 0.01) * spanDegree).toNumber();
    var activeDegree = startDegree - diff;
    if (diff == 0) {
      activeDegree = startDegree - 1;
    }

    return {
      :startDegree => startDegree,
      :endDegree => endDegree,
      :activeDegree => activeDegree
    };
  }
}