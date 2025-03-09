import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Graphics;
import Toybox.System;
import Toybox.Lang;

class WatchSettingsMenu extends WatchUi.Menu2 {
  function initialize() {
  
    Menu2.initialize({ :title => WatchUi.loadResource(Rez.Strings.SettingsMenu)});

    Menu2.addItem(
      toggleItem(
        "useSeconds",
        WatchUi.loadResource(Rez.Strings.UseSeconds),
        WatchUi.loadResource(Rez.Strings.ToggleEnable),
        WatchUi.loadResource(Rez.Strings.ToggleDisable)
      )
    );

    Menu2.addItem(
      toggleItem(
        "useBatteryPercentage",
        WatchUi.loadResource(Rez.Strings.UseBatteryPercentage),
        WatchUi.loadResource(Rez.Strings.ToggleEnable),
        WatchUi.loadResource(Rez.Strings.ToggleDisable)
      )
    );

    Menu2.addItem(createMenuItem("submenuTheme", Rez.Strings.SubmenuColorTheme));

    Menu2.addItem(createMenuItem("submenuDataTopLeft", Rez.Strings.DataFieldTypeTopLeft));

    Menu2.addItem(createMenuItem("submenuDataTopRight", Rez.Strings.DataFieldTypeTopRight));

    Menu2.addItem(createMenuItem("submenuDataBottomLeft", Rez.Strings.DataFieldTypeBottomLeft));

    Menu2.addItem(createMenuItem("submenuTimeCircleType", Rez.Strings.TimeCircleType));
  }

}

class WatchSettingsDelegate extends WatchUi.Menu2InputDelegate {

  function initialize() {
    Menu2InputDelegate.initialize();
  }

  function onSelect(menuItem) {
    var menuId = menuItem.getId();

    // on toggles
    if (menuItem instanceof WatchUi.ToggleMenuItem) {
        var value = menuItem.isEnabled() as Boolean;
        Settings.set(menuId, value);
        return;
    } 
    
    // on arc type menu click
    if (menuId.equals("submenuTimeCircleType")) {
      timeCircleTypeMenu();
      return;
    }

    // on color theme menu click
    if (menuId.equals("submenuTheme")) {
      colorThemeMenu();
      return;
    }

    // on submenuDataTopLeft
    if (menuId.equals("submenuDataTopLeft")) {
      dataTopLeftMenu();
      return;
    }

    // on submenuDataTopRight
    if (menuId.equals("submenuDataTopRight")) {
      dataTopRightMenu();
      return;
    }

    // on submenuDataBottomLeft
    if (menuId.equals("submenuDataBottomLeft")) {
      dataBottomLeftMenu();
      return;
    }

        // on time circle type selection
    if (menuId.toString().find("timeCircleType_") != null) {
      Settings.set("timeCircleType", getValueFromString(menuId.toString()).toNumber());
      WatchUi.showToast(WatchUi.loadResource(Rez.Strings.Saved), null);
      onBack();
      return;
    }

    // on color theme selection
    if (menuId.toString().find("colorTheme_") != null) {
      Settings.set("colorTheme", Settings.get(menuId.toString()));
      WatchUi.showToast(WatchUi.loadResource(Rez.Strings.Saved), null);
      onBack();
      return;
    }

    // on data top left selection
    if (menuId.toString().find("dataFieldTypeTopLeft_") != null) {
      Settings.set("dataFieldTypeTopLeft", getValueFromString(menuId.toString()).toNumber());
      WatchUi.showToast(WatchUi.loadResource(Rez.Strings.Saved), null);
      onBack();
      return;
    }

    // on data top right selection
    if (menuId.toString().find("dataFieldTypeTopRight_") != null) {
      Settings.set("dataFieldTypeTopRight", getValueFromString(menuId.toString()).toNumber());
      WatchUi.showToast(WatchUi.loadResource(Rez.Strings.Saved), null);
      onBack();
      return;
    }

    // on data bottom left selection
    if (menuId.toString().find("dataFieldTypeBottomLeft_") != null) {
      Settings.set("dataFieldTypeBottomLeft", getValueFromString(menuId.toString()).toNumber());
      WatchUi.showToast(WatchUi.loadResource(Rez.Strings.Saved), null);
      onBack();
      return;
    }
  }

  private function timeCircleTypeMenu() {
    var menu = new WatchUi.Menu2({ :title => WatchUi.loadResource(Rez.Strings.TimeCircleType) });
    getSelectableTimeCircleTypes(menu, "timeCircleType");
    WatchUi.pushView(menu, new WatchSettingsDelegate(), WatchUi.SLIDE_LEFT);
  } 

  private function colorThemeMenu() {
    var menu = new WatchUi.Menu2({ :title => WatchUi.loadResource(Rez.Strings.SubmenuColorTheme) });
    menu.addItem(createMenuItem("colorTheme_lemon", Rez.Strings.ThemeLemon));
    menu.addItem(createMenuItem("colorTheme_gold", Rez.Strings.ThemeGold));
    menu.addItem(createMenuItem("colorTheme_orange", Rez.Strings.ThemeOrange));
    menu.addItem(createMenuItem("colorTheme_yellow", Rez.Strings.ThemeYellow));
    menu.addItem(createMenuItem("colorTheme_green", Rez.Strings.ThemeGreen));
    menu.addItem(createMenuItem("colorTheme_mint", Rez.Strings.ThemeMint));
    menu.addItem(createMenuItem("colorTheme_bluegray", Rez.Strings.ThemeBlueGray));
    menu.addItem(createMenuItem("colorTheme_blue", Rez.Strings.ThemeBlue));
    menu.addItem(createMenuItem("colorTheme_pink", Rez.Strings.ThemePink));
    menu.addItem(createMenuItem("colorTheme_red", Rez.Strings.ThemeRed));
    WatchUi.pushView(menu, new WatchSettingsDelegate(), WatchUi.SLIDE_LEFT);
  } 

  private function dataTopLeftMenu() {
    var menu = new WatchUi.Menu2({ :title => WatchUi.loadResource(Rez.Strings.DataFieldTypeTopLeft) });
    getSelectableDataSets(menu, "dataFieldTypeTopLeft");
    WatchUi.pushView(menu, new WatchSettingsDelegate(), WatchUi.SLIDE_LEFT);
  } 

  private function dataTopRightMenu() {
    var menu = new WatchUi.Menu2({ :title => WatchUi.loadResource(Rez.Strings.DataFieldTypeTopRight) });
    getSelectableDataSets(menu, "dataFieldTypeTopRight");
    WatchUi.pushView(menu, new WatchSettingsDelegate(), WatchUi.SLIDE_LEFT);
  } 

  private function dataBottomLeftMenu() {
    var menu = new WatchUi.Menu2({ :title => WatchUi.loadResource(Rez.Strings.DataFieldTypeBottomLeft) });
    getSelectableDataSets(menu, "dataFieldTypeBottomLeft");
    WatchUi.pushView(menu, new WatchSettingsDelegate(), WatchUi.SLIDE_LEFT);
  } 

  function onBack() {
    WatchUi.popView(WatchUi.SLIDE_RIGHT);
  }
}

function createMenuItem(value, stringResource) {
  return new WatchUi.MenuItem(WatchUi.loadResource(stringResource), null, value, null);
}

function toggleItem(id, label, enabledLabel, disabledLabel) {
  return new WatchUi.ToggleMenuItem(label, { :enabled => enabledLabel, :disabled => disabledLabel }, id, Settings.get(id) as Boolean, null);
}

function getSelectableDataSets(menu, position as String) {
  menu.addItem(createMenuItem(position + "_" + FIELD_TYPE_CALORIES, Rez.Strings.DataFieldValueCalories));
  menu.addItem(createMenuItem(position + "_" + FIELD_TYPE_STEPS, Rez.Strings.DataFieldValueSteps));
  menu.addItem(createMenuItem(position + "_" + FIELD_TYPE_DISTANCE, Rez.Strings.DataFieldValueDistance));
  menu.addItem(createMenuItem(position + "_" + FIELD_TYPE_ACTIVE_MINUTES_DAY, Rez.Strings.DataFieldValueActiveMinutesDay));
  menu.addItem(createMenuItem(position + "_" + FIELD_TYPE_CURRENT_TEMPERATURE, Rez.Strings.DataFieldValueCurrentTemperature));
  menu.addItem(createMenuItem(position + "_" + FIELD_TYPE_TIME_TO_RECOVERY, Rez.Strings.DataFieldValueTimeToRecovery));
  menu.addItem(createMenuItem(position + "_" + FIELD_TYPE_STRESS_SCORE, Rez.Strings.DataFieldValueStressScore));
}

function getSelectableTimeCircleTypes(menu, position as String) {
  menu.addItem(createMenuItem(position + "_" + TIME_CIRCLE_TYPE_SECONDS_CIRCLE, Rez.Strings.TimeCircleTypeSecondsCircle));
  menu.addItem(createMenuItem(position + "_" + TIME_CIRCLE_TYPE_SECONDS_DOT, Rez.Strings.TimeCircleTypeSecondsDot));
  menu.addItem(createMenuItem(position + "_" + TIME_CIRCLE_TYPE_DISABLED, Rez.Strings.TimeCircleTypeDisabled));
}

function getValueFromString(stringValue as String) {
  var startPos = stringValue.find("_") + 1;
  var length = stringValue.length();
  return stringValue.substring(startPos, length);
}