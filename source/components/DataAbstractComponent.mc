import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class DataAbstractComponent extends WatchUi.Drawable {
  var dataIdentifier as String = "";
  var xOffset as Number = 0;
  var yOffset as Number = 0;
  var textAlignment;
  var textFont;
  var centerX;
  var centerY;
  var colorValue;
  var colorTransparent;
  var updateInterval;
  
  private var lastDataUpdate  = -1;
  private var dataSet as DataFieldResponse or Null = null;

  function initialize(params) { 
    WatchUi.Drawable.initialize(params); 
    textFont = Settings.get("fontText");
    centerX = Settings.get("centerX");
    centerY = Settings.get("centerY");
    colorValue = Settings.get("colorValue");
    colorTransparent = Settings.get("colorTransparent");
    updateInterval = Settings.get("updateInterval");
  }

  function draw(dc as Dc) {
    if (Settings.get("highPowerMode")) {
      updateData();
      drawContent(dc);
    }
  }

  private function updateData() {
    var currentSecond = System.getClockTime().sec;
    if (lastDataUpdate == -1 || (currentSecond % updateInterval == 0 && currentSecond != lastDataUpdate)) {
      dataSet = DataService.getDataByFieldType(Settings.get(dataIdentifier));
      lastDataUpdate  = currentSecond;
    }
  }  

  private function drawContent(dc) {
    if (dataSet == null) { 
      return;
    }

    var yPos = centerY + yOffset;
    var textOffset = xOffset;
    if (dataSet[:icon]) {
      Icons.drawIcon(dataSet[:icon], dc, centerX + xOffset, yPos, dataSet[:iconColor]);
      textOffset = getTextOffsetOnIcon(xOffset);
    }

    dc.setColor(colorValue, colorTransparent);
    dc.drawText(
      centerX + textOffset, 
      yPos,
      textFont, 
      dataSet[:value],
      textAlignment | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  private function getTextOffsetOnIcon(xOffset as Number) as Number {
      var textPadding = 20; 
      if (xOffset >= 0) {
        textPadding = xOffset + textPadding;
      } else {
        textPadding = xOffset - textPadding;
      }
      return textPadding;
  }

}