import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WatchView extends WatchUi.WatchFace {

  function initialize() {
    WatchFace.initialize();
  }

  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
  }

  function onShow() as Void {}

  function onUpdate(dc as Dc) as Void {
    View.onUpdate(dc);
  }

  function onHide() as Void {}

  function onExitSleep() as Void {
    Settings.setHighPowerMode(true);
    WatchUi.requestUpdate(); 
  }

  function onEnterSleep() as Void {
    Settings.setHighPowerMode(false);
    WatchUi.requestUpdate(); 
  }
}