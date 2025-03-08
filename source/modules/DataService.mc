import Toybox.Lang;
import Toybox.Weather;
import Toybox.Activity;
import Toybox.System;
import Toybox.ActivityMonitor;

typedef DataFieldResponse as {
  :icon as String,
  :iconColor as String,
  :value as String or Null
}; 

module DataService {

  function getDataByFieldType(fieldType) as DataFieldResponse or Null {
    switch(fieldType) {
      case 10: 
        return getCalories();          
      case 20: 
        return getSteps();  
      case 30: 
        return getDistance();            
      case 40: 
        return getActiveMinutesDay();  
      case 50: 
        return getHeatRate();           
      case 200: 
        return getCurrentTemperature();
      case 300: 
        return getBatteryStatus();        
    }
    return null;
  }

  function getHeatRate() as DataFieldResponse {
    var heartRate = null;

    if (ActivityMonitor has :getHeartRateHistory) {
      heartRate = Activity.getActivityInfo().currentHeartRate;
      if (heartRate == null) {
        var HRH = ActivityMonitor.getHeartRateHistory(1, true);
        var HRS = HRH.next();
        if (HRS != null && HRS.heartRate != ActivityMonitor.INVALID_HR_SAMPLE){
          heartRate = HRS.heartRate;
        }
      }

      if (heartRate != null) {
        heartRate = heartRate.toString();
      }

      else {
        heartRate = "--";
      }
    }

    return {
      :icon => "cario",
      :iconColor => Settings.get("colorValue"),
      :value => heartRate
    };
  }

  function getCalories() {
    return {
      :icon => "calories",
      :iconColor => Settings.get("colorValue"),
      :value => ActivityMonitor.getInfo().calories
    };
  }

  function getDistance() {
    var useMetricSystem = Settings.get("useMetricSystem");
    var distance = ActivityMonitor.getInfo().distance;

    var value = "--";
    if (distance != null) {
      var distanceKm = Utilities.cmToKm(distance);
      if (useMetricSystem) {
        value = distanceKm.format("%.2f") + " km";
      } else {
        value = Utilities.kilometersToMiles(distanceKm).format("%.2f") + " mi";
      }
    }
 
    return {
      :icon => null,
      :iconColor => Settings.get("colorValue"),
      :value => value
    };
  }

  function getSteps() {
    return {
      :icon => "steps",
      :iconColor => Settings.get("colorValue"),
      :value => ActivityMonitor.getInfo().steps
    };
  }

  function getActiveMinutesDay() {
    var totalMinutes = ActivityMonitor.getInfo().activeMinutesDay.total;
    var hours = totalMinutes / 60;
    var remainingMinutes = totalMinutes % 60;

    var value = hours.format("%02d") + ":" + remainingMinutes.format("%02d");

    return {
      :icon => "clock",
      :iconColor => Settings.get("colorValue"),
      :value => value
    };
  }

  function getBatteryStatus() {
    var systemStats = System.getSystemStats();
    var batteryInPercent = systemStats.battery.toNumber();
    var batteryIcon = "";

    if (batteryInPercent > 90) {
      batteryIcon = "battery_6";
    } else if (batteryInPercent > 80) {
      batteryIcon = "battery_5";
    } else if (batteryInPercent > 60) {
      batteryIcon = "battery_4";
    } else if (batteryInPercent > 50) {
      batteryIcon = "battery_3";
    } else if (batteryInPercent > 40) {
      batteryIcon = "battery_2";
    } else {
      batteryIcon = "battery_1";
    }
    
    var batteryColor = Settings.get("colorValue");
    if (batteryInPercent < 10) {
      batteryColor = Settings.get("colorAlert");
    } else if (batteryInPercent < 20) {
      batteryColor = Settings.get("colorWarning");
    }

    var usePercentage = Settings.get("useBatteryPercentage");
    var value = Lang.format("$1$$2$", [usePercentage ? systemStats.battery.toNumber() : systemStats.batteryInDays.toNumber(), usePercentage ? "%" : "d"]);
    return {
      :icon => batteryIcon,
      :iconColor => batteryColor,
      :value => value
    };
  }

  function getCurrentTemperature() {
    var value = "--";
    var currentConditions = Weather.getCurrentConditions();
    if (currentConditions != null) {
      var useMetricSystem = Settings.get("useMetricSystem");
      value = Lang.format("$1$", [useMetricSystem ?  currentConditions.temperature.toNumber() + " °C" : Utilities.celsiusToFahrenheit(currentConditions.temperature).toNumber() + " °F" ]);
    }
    return {
     :icon => null,
      :iconColor => Settings.get("colorValue"),
     :value => value
    };
  }
}
