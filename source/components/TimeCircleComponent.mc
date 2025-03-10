import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;


class TimeCircleComponent extends WatchUi.Drawable {
  private var _centerX;
  private var _centerY;
  private var _colorTransparent;
  private var _colorTheme;
  private var _radius;
  private var _clockTime;

  function initialize(params) { 
    Drawable.initialize(params); 
    _centerX = Settings.get("centerX");
    _centerY = Settings.get("centerY");
    _colorTransparent = Settings.get("colorTransparent");
    _radius = Settings.get("width") / 2.0 - 3;
  }

  function draw(dc as Dc) {
    var timeCircleType = Settings.get("timeCircleType");
    if (Settings.get("highPowerMode") && timeCircleType != TIME_CIRCLE_TYPE_DISABLED) {
      _colorTheme = Settings.get("colorTheme");
      _clockTime = System.getClockTime();

      switch(timeCircleType) {
        case TIME_CIRCLE_TYPE_SECONDS_CIRCLE: drawSecondsCircle(dc); break;
        case TIME_CIRCLE_TYPE_SECONDS_DOT: drawSecondsDot(dc); break;
      }
    }
  }

  private function drawSecondsCircle(dc) {
    var response = getDegreeValuesForSeconds() as Dictionary<Symbol, Number>;

    dc.setPenWidth(2);
    dc.setColor(_colorTheme, _colorTransparent);
    dc.drawArc(_centerX, _centerY, _radius, Graphics.ARC_CLOCKWISE, response[:startDegree], response[:endDegree]);
    dc.setPenWidth(1);
  }

  private function drawSecondsDot(dc) {
    var response = getDegreeValuesForSeconds() as Dictionary<Symbol, Number>;

    dc.setPenWidth(6);
    dc.setColor(_colorTheme, _colorTransparent);
    dc.drawArc(_centerX, _centerY, _radius, Graphics.ARC_CLOCKWISE, (response[:endDegree] + 3), (response[:endDegree] - 2));
    dc.setPenWidth(1);
  }

  private function getDegreeValuesForSeconds() {
    var percentage = _clockTime.sec / 60.0 * 100;
    var startDegree = 90;
    var diff = ((percentage * 0.01) * 360).toNumber();

    return {
      :startDegree => startDegree,
      :endDegree => startDegree - diff
    };
  }
}