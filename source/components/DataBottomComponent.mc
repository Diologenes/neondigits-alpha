import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;


class DataBottomComponent extends WatchUi.Drawable {
  private var _centerX;
  private var _centerY;
  private var _yOffsetLine2;
  private var _height;
  private var _colorTransparent;
  private var _colorValue;
  private var _font;
  private var _updateInterval;

  private var lastDataUpdate  = -1;
  private var dataSet as DataFieldResponse or Null = null;

  function initialize(params) { 
    Drawable.initialize(params); 
    _centerX = Settings.get("centerX");
    _centerY = Settings.get("centerY");
    _yOffsetLine2 = Settings.get("yOffsetLine2");
    _height = Settings.get("height");
    _colorTransparent = Settings.get("colorTransparent");
    _colorValue = Settings.get("colorValue");
    _font = Settings.get("fontText");
    _updateInterval = Settings.get("updateInterval");
  }

  function draw(dc as Dc) {
    if (Settings.get("highPowerMode")) {
      updateData();
      drawContent(dc);
    }
  }

  private function updateData() {
    var currentSecond = System.getClockTime().sec;
    if (lastDataUpdate == -1 || (currentSecond % _updateInterval == 0 && currentSecond != lastDataUpdate)) {
      dataSet = DataService.getDataByFieldType(Settings.get("dataFieldTypeBottom"));
      lastDataUpdate  = currentSecond;
    }
  }  

  private function drawContent(dc) {
    if (dataSet == null) { 
      return;
    }

    var value = dataSet[:value];
    if (value == null) {
      return;
    } 

    var yOffset = _height - ((_height - (_centerY + _yOffsetLine2)) / 2);

    Icons.drawIcon("cardio", dc, _centerX - 22, yOffset, dataSet[:iconColor]);

    dc.setColor(_colorValue, _colorTransparent);

    dc.drawText(
      _centerX, 
      yOffset,
      _font, 
      value,
      Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }
}