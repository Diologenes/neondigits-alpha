import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class DataAbstractComponent extends WatchUi.Drawable {
  var dataIdentifier as String = "";
  var xOffset as Number = 0;
  var yOffset as Number = 0;
  var textAlignment as Graphics.TextJustification?;

  private var _textFont as Graphics.FontType;
  private var _colorTransparent as Graphics.ColorValue;
  private var _centerX as Number;
  private var _centerY as Number;
  private var _colorValue as Number;
  private var _updateInterval as Number;
  
  private var lastDataUpdate as Number = -1;
  private var dataSet as DataFieldResponse or Null = null;

  function initialize(params as Dictionary) { 
    WatchUi.Drawable.initialize(params); 
    _textFont = Settings.getFont("fontText");
    _centerX = Settings.getNumber("centerX");
    _centerY = Settings.getNumber("centerY");
    _colorValue = Settings.getColor("colorValue");
    _updateInterval = Settings.getNumber("updateInterval");
    _colorTransparent = Settings.getColor("colorTransparent");
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
      dataSet = DataService.getDataByFieldType(Settings.getString(dataIdentifier));
      lastDataUpdate  = currentSecond;
    }
  }  

  private function drawContent(dc as Dc) as Void {
    if (dataSet == null) { 
      return;
    }

    var yPos = _centerY + yOffset;
    var textOffset = xOffset;
    if (dataSet[:icon]) {
      Icons.drawIcon(dataSet[:icon], dc, _centerX + xOffset, yPos, dataSet[:iconColor]);
      textOffset = getTextOffsetOnIcon(xOffset);
    }

    dc.setColor(_colorValue, _colorTransparent);
    dc.drawText(
      _centerX + textOffset, 
      yPos,
      _textFont, 
      dataSet[:value],
      textAlignment | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  private function getTextOffsetOnIcon(xOffset as Number) as Number {
      var textPadding = 25; 
      if (xOffset >= 0) {
        textPadding = xOffset + textPadding;
      } else {
        textPadding = xOffset - textPadding;
      }
      return textPadding;
  }

}