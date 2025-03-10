import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class DataAbstractComponent extends WatchUi.Drawable {
  var dataIdentifier as String = "";
  var xOffset as Number = 0;
  var yOffset as Number = 0;
  var textAlignment;

  private var _textFont;
  private var _centerX;
  private var _centerY;
  private var _colorValue;
  private var _colorTransparent;
  private var _updateInterval;
  
  private var lastDataUpdate  = -1;
  private var dataSet as DataFieldResponse or Null = null;

  function initialize(params) { 
    WatchUi.Drawable.initialize(params); 
    _textFont = Settings.get("fontText");
    _centerX = Settings.get("centerX");
    _centerY = Settings.get("centerY");
    _colorValue = Settings.get("colorValue");
    _colorTransparent = Settings.get("colorTransparent");
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
      dataSet = DataService.getDataByFieldType(Settings.get(dataIdentifier));
      lastDataUpdate  = currentSecond;
    }
  }  

  private function drawContent(dc) {
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