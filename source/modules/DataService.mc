import Toybox.Lang;
import Toybox.Weather;
import Toybox.Activity;
import Toybox.System;
import Toybox.ActivityMonitor;
import Toybox.Graphics;

typedef DataFieldResponse as {
  :icon as String or Null,
  :iconColor as Graphics.ColorValue,
  :value as String
}; 

enum {
  FIELD_TYPE_CALORIES = 10,
  FIELD_TYPE_STEPS = 20,
  FIELD_TYPE_DISTANCE = 30,
  FIELD_TYPE_ACTIVE_MINUTES_DAY = 40,
  FIELD_TYPE_HEART_RATE = 50,
  FIELD_TYPE_STRESS_SCORE = 60,
  FIELD_TYPE_TIME_TO_RECOVERY = 70,
  FIELD_TYPE_CURRENT_TEMPERATURE = 200,
  FIELD_TYPE_BATTERY_STATUS = 300,

  TIME_CIRCLE_TYPE_SECONDS_CIRCLE = 1000,
  TIME_CIRCLE_TYPE_SECONDS_DOT = 1010,
  TIME_CIRCLE_TYPE_DISABLED = 1099
}

module DataService {

  function getDataByFieldType(fieldType as String) as DataFieldResponse or Null {
    switch(fieldType) {
      case FIELD_TYPE_CALORIES: 
        return getCalories();          
      case FIELD_TYPE_STEPS: 
        return getSteps();  
      case FIELD_TYPE_DISTANCE: 
        return getDistance();            
      case FIELD_TYPE_ACTIVE_MINUTES_DAY: 
        return getActiveMinutesDay();  
      case FIELD_TYPE_HEART_RATE: 
        return getHeatRate();           
      case FIELD_TYPE_CURRENT_TEMPERATURE: 
        return getCurrentTemperature();
      case FIELD_TYPE_BATTERY_STATUS: 
        return getBatteryStatus();
      case FIELD_TYPE_STRESS_SCORE: 
        return getStressScore();    
      case FIELD_TYPE_TIME_TO_RECOVERY: 
        return getTimeToRecovery();   
    }
    return null;
  }

  function getHeatRate() as DataFieldResponse {
    var heartRate = "";

    if (ActivityMonitor has :getHeartRateHistory && Activity has :getActivityInfo) {
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
      :iconColor => Settings.getColor("colorValue"),
      :value => heartRate
    };
  }

  function getCalories() as DataFieldResponse {
    var value = ActivityMonitor.getInfo().calories;
    return {
      :icon => "calories",
      :iconColor => Settings.getColor("colorValue"),
      :value => value != null ? value.toString() : "--"
    };
  }

  function getDistance() as DataFieldResponse {
    var useMetricSystem = Settings.getBoolean("useMetricSystem");
    var distance = ActivityMonitor.getInfo().distance;

    var value = "--";
    if (distance != null) {
      var distanceKm = Utilities.cmToKm(distance);
      if (useMetricSystem) {
        value = distanceKm.format("%.1f") + " km";
      } else {
        value = Utilities.kilometersToMiles(distanceKm).format("%.1f") + " mi";
      }
    }
 
    return {
      :icon => null,
      :iconColor => Settings.getColor("colorValue"),
      :value => value
    };
  }

  function getSteps() as DataFieldResponse {
    var value = ActivityMonitor.getInfo().steps;
    return {
      :icon => "steps",
      :iconColor => Settings.getColor("colorValue"),
      :value => value != null ? value.toString() : "--"
    };
  }

  function getStressScore() as DataFieldResponse {
    var stressScore = ActivityMonitor.getInfo().stressScore;
    var iconColor = null;
    if (stressScore != null) {
      iconColor = Settings.getColor("colorLow");
      if (stressScore > 25) {
        iconColor = Settings.getColor("colorModerate");
      } else if (stressScore > 50) {
        iconColor = Settings.getColor("colorWarning");
      } else if (stressScore > 75) {
        iconColor = Settings.getColor("colorAlert");
      } 
    } 

    return {
      :icon => "stress",
      :iconColor => iconColor != null ? iconColor : Settings.getColor("colorValue"),
      :value => stressScore != null ? stressScore.toString() : "--"
    };
  }

  function getTimeToRecovery() as DataFieldResponse {
    var timeToRecovery = ActivityMonitor.getInfo().timeToRecovery;
    var value = ""; 
    if (timeToRecovery) {
      value = timeToRecovery + " h";
    } else {
      value = "--";
    }

    return {
      :icon => "recovery",
      :iconColor => Settings.getColor("colorValue"),
      :value => value
    };
  }

  function getActiveMinutesDay() as DataFieldResponse {
    var totalMinutes = ActivityMonitor.getInfo().activeMinutesDay.total;
    var hours = totalMinutes / 60;
    var remainingMinutes = totalMinutes % 60;

    var value = hours.format("%02d") + ":" + remainingMinutes.format("%02d");

    return {
      :icon => "clock",
      :iconColor => Settings.getColor("colorValue"),
      :value => value
    };
  }

  function getBatteryStatus() as DataFieldResponse {
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
    
    var batteryColor = Settings.getColor("colorValue");
    if (batteryInPercent < 10) {
      batteryColor = Settings.getColor("colorAlert");
    } else if (batteryInPercent < 20) {
      batteryColor = Settings.getColor("colorWarning");
    }

    var usePercentage = Settings.getBoolean("useBatteryPercentage");
    var value = Lang.format("$1$$2$", [usePercentage ? systemStats.battery.toNumber() : systemStats.batteryInDays.toNumber(), usePercentage ? "%" : "d"]);
    return {
      :icon => batteryIcon,
      :iconColor => batteryColor,
      :value => value
    };
  }

  function getCurrentTemperature() as DataFieldResponse {
    var value = "--";
    var currentConditions = Weather.getCurrentConditions();
    if (currentConditions != null) {
      var useMetricSystem = Settings.getBoolean("useMetricSystem");
      value = Lang.format("$1$", [useMetricSystem ?  currentConditions.temperature.toNumber() + " °C" : Utilities.celsiusToFahrenheit(currentConditions.temperature).toNumber() + " °F" ]);
    }
    return {
     :icon => null,
      :iconColor => Settings.getColor("colorValue"),
     :value => value
    };
  }
}
