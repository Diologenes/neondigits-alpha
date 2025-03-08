import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WatchApp extends Application.AppBase {
  
  function initialize() { 
    AppBase.initialize(); 
  }

  function onStart(state as Dictionary?) as Void {
  }

  function onStop(state as Dictionary?) as Void {
  }

  function getInitialView() as[Views] or [Views, InputDelegates] { 
    Settings.initialize();
    return [new WatchView()];
  }

  function onSettingsChanged() as Void {
    Settings.loadProps();    
    WatchUi.requestUpdate(); 
  }

  function getSettingsView() {
    return [new WatchSettingsMenu(), new WatchSettingsDelegate()];
  }

}

function getApp() as WatchApp { 
  return Application.getApp() as WatchApp; 
}