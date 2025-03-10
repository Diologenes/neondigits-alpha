import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;


class DataBottomComponent extends WatchUi.Drawable {
  private var _centerX as Number;
  private var _centerY as Number;
  private var _yOffsetLine2 as Number;
  private var _height as Number;
  private var _colorTransparent as Graphics.ColorValue;
  private var _colorValue as Graphics.ColorValue;
  private var _font as Graphics.FontType;
  private var _updateInterval as Number;

  private var lastDataUpdate as Number  = -1;
  private var dataSet as DataFieldResponse or Null = null;

  function initialize(params as Dictionary) { 
    Drawable.initialize(params); 
    _centerX = Settings.getNumber("centerX");
    _centerY = Settings.getNumber("centerY");
    _yOffsetLine2 = Settings.getNumber("yOffsetLine2");
    _height = Settings.getNumber("height");
    _colorTransparent = Settings.getColor("colorTransparent");
    _colorValue = Settings.getColor("colorValue");
    _font = Settings.getFont("fontText");
    _updateInterval = Settings.getNumber("updateInterval");
  }

  function draw(dc as Dc) {
    if (Settings.getBoolean("highPowerMode")) {
      updateData();
      drawContent(dc);
    }
  }

  private function updateData() as Void {
    var currentSecond = System.getClockTime().sec;
    if (lastDataUpdate == -1 || (currentSecond % _updateInterval == 0 && currentSecond != lastDataUpdate)) {
      dataSet = DataService.getDataByFieldType(Settings.getString("dataFieldTypeBottom")); 
      lastDataUpdate  = currentSecond;
    }
  }  

  private function drawContent(dc as Dc) as Void {
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