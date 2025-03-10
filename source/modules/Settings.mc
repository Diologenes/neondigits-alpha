import Toybox.Lang;
import Toybox.Application;
import Toybox.System;
import Toybox.Graphics;

module Settings {

  var settings as Dictionary<String, Object | Null> = {};

  function initialize() {
    var width = System.getDeviceSettings().screenWidth;
    var height = System.getDeviceSettings().screenHeight;
    var centerX = width / 2;
    var centerY = height / 2;

    // fonts 
    settings["fontTime"] = Application.loadResource(Rez.Fonts.TimeFont);
    settings["fontSeconds"] = Application.loadResource(Rez.Fonts.SecondsFont);
    settings["fontText"] = Application.loadResource(Rez.Fonts.TextFont);

    // misc
    settings["updateInterval"] = 3;

    // base dimentions / points
    settings["width"] = width;
    settings["height"] = height;
    settings["centerX"] = centerX;
    settings["centerY"] = centerY;

    // positioning
    settings["yOffsetLine1"] = 60;
    settings["yOffsetLine2"] = 110;

    // color themes
    settings["colorTheme_lemon"] = 0xa0bf41;
    settings["colorTheme_gold"] = 0xC4BF5C;
    settings["colorTheme_orange"] = 0xed7f2b;
    settings["colorTheme_yellow"] = 0xede734;
    settings["colorTheme_green"] = 0x00ff6e;
    settings["colorTheme_mint"] = 0x1BE098;
    settings["colorTheme_bluegray"] = 0x49678a;
    settings["colorTheme_blue"] = 0x317cb5;
    settings["colorTheme_pink"] = 0xde456e;
    settings["colorTheme_red"] = 0xC43B3B;

    // base colors
    settings["colorBlack"] = Graphics.COLOR_BLACK;
    settings["colorWhite"] = Graphics.createColor(250, 190, 190, 190);
    settings["colorValue"] = Graphics.createColor(255, 140, 140, 140);
    settings["colorGrayLight"] = Graphics.createColor(255, 110, 110, 110);
    settings["colorGrayDark"] = Graphics.createColor(255, 80, 80, 80);
    settings["colorLow"] = Graphics.createColor(245, 207, 202, 178);
    settings["colorModerate"] = Graphics.createColor(245, 179, 160, 66);
    settings["colorWarning"] = Graphics.createColor(245, 224, 196, 54);
    settings["colorAlert"] = Graphics.createColor(254, 185, 30, 30);
    settings["colorTransparent"] = Graphics.COLOR_TRANSPARENT;
  
    // switches
    settings["highPowerMode"] = true;

    // fixed data types
    settings["dataFieldTypeBottomRight"] = FIELD_TYPE_BATTERY_STATUS;
    settings["dataFieldTypeBottom"] = FIELD_TYPE_HEART_RATE;

    loadProps();
  }
  
  function loadProps() {
    settings["useMetricSystem"] = System.getDeviceSettings().distanceUnits == System.UNIT_METRIC;
    settings["colorTheme"] = Application.Properties.getValue("colorTheme") as Number;
    settings["useSeconds"] = Application.Properties.getValue("useSeconds") as Boolean;
    settings["useBatteryPercentage"] = Application.Properties.getValue("useBatteryPercentage") as Boolean;
    settings["dataFieldTypeTopLeft"] = Application.Properties.getValue("dataFieldTypeTopLeft") as Number;
    settings["dataFieldTypeTopRight"] = Application.Properties.getValue("dataFieldTypeTopRight") as Number;
    settings["dataFieldTypeBottomLeft"] = Application.Properties.getValue("dataFieldTypeBottomLeft") as Number;
    settings["timeCircleType"] = Application.Properties.getValue("timeCircleType") as Number;
  }

  function get(key as String) {
    return settings[key];
  }

  function set(key, value) {
    Application.Properties.setValue(key, value);
    settings[key] = value;
  }

  function setHighPowerMode(value as Boolean) {
    settings["highPowerMode"] = value;
  }
}