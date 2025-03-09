import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;


class DataBottomComponent extends WatchUi.Drawable {
  var centerX;
  var centerY;
  var yOffsetLine2;
  var height;
  var colorTransparent;
  var colorValue;
  var font;
  var updateInterval;

  private var lastDataUpdate  = -1;
  private var dataSet as DataFieldResponse or Null = null;

  function initialize(params) { 
    Drawable.initialize(params); 
    centerX = Settings.get("centerX");
    centerY = Settings.get("centerY");
    yOffsetLine2 = Settings.get("yOffsetLine2");
    height = Settings.get("height");
    colorTransparent = Settings.get("colorTransparent");
    colorValue = Settings.get("colorValue");
    font = Settings.get("fontText");
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

    var yOffset = height - ((height - (centerY + yOffsetLine2)) / 2);

    Icons.drawIcon("cardio", dc, centerX - 22, yOffset, dataSet[:iconColor]);

    dc.setColor(colorValue, colorTransparent);

    dc.drawText(
      centerX, 
      yOffset,
      font, 
      value,
      Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }
}