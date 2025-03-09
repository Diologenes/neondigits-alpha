import Toybox.Lang;
import Toybox.Application;
import Toybox.System;
import Toybox.Graphics;

module Settings {

  var _settings as Dictionary<String, Object | Null> = {};

  function initialize() {
    var width = System.getDeviceSettings().screenWidth;
    var height = System.getDeviceSettings().screenHeight;
    var centerX = width / 2;
    var centerY = height / 2;

    // fonts 
    _settings["fontTime"] = Application.loadResource(Rez.Fonts.TimeFont);
    _settings["fontSeconds"] = Application.loadResource(Rez.Fonts.SecondsFont);
    _settings["fontText"] = Application.loadResource(Rez.Fonts.TextFont);

    // misc
    _settings["updateInterval"] = 3;

    // base dimentions / points
    _settings["width"] = width;
    _settings["height"] = height;
    _settings["centerX"] = centerX;
    _settings["centerY"] = centerY;

    // positioning
    _settings["yOffsetLine1"] = 60;
    _settings["yOffsetLine2"] = 110;

    // color themes
    _settings["colorTheme_lemon"] = 0xa0bf41;
    _settings["colorTheme_gold"] = 0xC4BF5C;
    _settings["colorTheme_orange"] = 0xed7f2b;
    _settings["colorTheme_yellow"] = 0xede734;
    _settings["colorTheme_green"] = 0x00ff6e;
    _settings["colorTheme_mint"] = 0x1BE098;
    _settings["colorTheme_bluegray"] = 0x49678a;
    _settings["colorTheme_blue"] = 0x317cb5;
    _settings["colorTheme_pink"] = 0xde456e;
    _settings["colorTheme_red"] = 0xC43B3B;

    // base colors
    _settings["colorBlack"] = Graphics.COLOR_BLACK;
    _settings["colorWhite"] = Graphics.createColor(250, 190, 190, 190);
    _settings["colorValue"] = Graphics.createColor(255, 140, 140, 140);
    _settings["colorGrayLight"] = Graphics.createColor(255, 110, 110, 110);
    _settings["colorGrayDark"] = Graphics.createColor(255, 80, 80, 80);
    _settings["colorWarning"] = Graphics.createColor(245, 185, 160, 60);
    _settings["colorAlert"] = Graphics.createColor(254, 185, 30, 30);
    _settings["colorTransparent"] = Graphics.COLOR_TRANSPARENT;
  
    // switches
    _settings["highPowerMode"] = true;

    // data types
    _settings["dataFieldTypeBottomLeft"] = FIELD_TYPE_CURRENT_TEMPERATURE;
    _settings["dataFieldTypeBottomRight"] = FIELD_TYPE_BATTERY_STATUS;
    _settings["dataFieldTypeBottom"] = FIELD_TYPE_HEART_RATE;

    loadProps();
  }
  
  function loadProps() {
    _settings["useMetricSystem"] = System.getDeviceSettings().distanceUnits == System.UNIT_METRIC;
    _settings["colorTheme"] = Application.Properties.getValue("colorTheme") as Number;
    _settings["useSeconds"] = Application.Properties.getValue("useSeconds") as Boolean;
    _settings["useBatteryPercentage"] = Application.Properties.getValue("useBatteryPercentage") as Boolean;
    _settings["dataFieldTypeTopLeft"] = Application.Properties.getValue("dataFieldTypeTopLeft") as Number;
    _settings["dataFieldTypeTopRight"] = Application.Properties.getValue("dataFieldTypeTopRight") as Number;
    _settings["arcType"] = Application.Properties.getValue("arcType") as Number;
  }

  function get(key as String) {
    return _settings[key];
  }

  function set(key, value) {
    Application.Properties.setValue(key, value);
    _settings[key] = value;
  }

  function setHighPowerMode(value as Boolean) {
    _settings["highPowerMode"] = value;
  }
}