import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;


class TimeCircleComponent extends WatchUi.Drawable {
  private var _centerX as Number;
  private var _centerY as Number;
  private var _colorTransparent as Graphics.ColorValue;
  private var _colorTheme as Graphics.ColorValue;
  private var _radius as Float;
  private var _clockTime as System.ClockTime?;

  function initialize(params) { 
    Drawable.initialize(params); 
    _centerX = Settings.getNumber("centerX");
    _centerY = Settings.getNumber("centerY");
    _colorTransparent = Settings.getColor("colorTransparent");
    _colorTheme = Settings.getColor("colorTheme");
    _radius = Settings.getNumber("width") / 2.0 - 3;
  }

  function draw(dc as Dc) {
    var timeCircleType = Settings.getString("timeCircleType");
    if (Settings.getBoolean("highPowerMode") && timeCircleType != TIME_CIRCLE_TYPE_DISABLED) {
      _colorTheme = Settings.getColor("colorTheme");
      _clockTime = System.getClockTime();

      switch(timeCircleType) {
        case TIME_CIRCLE_TYPE_SECONDS_CIRCLE: drawSecondsCircle(dc); break;
        case TIME_CIRCLE_TYPE_SECONDS_DOT: drawSecondsDot(dc); break;
      }
    }
  }

  private function drawSecondsCircle(dc as Dc) as Void {
    var response = getDegreeValuesForSeconds() as Dictionary<Symbol, Number>;

    dc.setPenWidth(2);
    dc.setColor(_colorTheme, _colorTransparent);
    dc.drawArc(_centerX, _centerY, _radius, Graphics.ARC_CLOCKWISE, response[:startDegree], response[:endDegree]);
    dc.setPenWidth(1);
  }

  private function drawSecondsDot(dc as Dc) as Void {
    var response = getDegreeValuesForSeconds() as Dictionary<Symbol, Number>;

    dc.setPenWidth(6);
    dc.setColor(_colorTheme, _colorTransparent);
    dc.drawArc(_centerX, _centerY, _radius, Graphics.ARC_CLOCKWISE, (response[:endDegree] + 3), (response[:endDegree] - 2));
    dc.setPenWidth(1);
  }

  private function getDegreeValuesForSeconds() as Dictionary<Symbol, Number> {
    var percentage = _clockTime != null ? _clockTime.sec / 60.0 * 100 : 0;
    var startDegree = 90;
    var diff = ((percentage * 0.01) * 360).toNumber();

    return {
      :startDegree => startDegree,
      :endDegree => startDegree - diff
    };
  }
}