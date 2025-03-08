import Toybox.Lang;
import Toybox.System;

module Utilities {

  function celsiusToFahrenheit(tempC as Float or Number) as Number {
    return ((tempC * 9.0 / 5.0) + 32).toNumber();
  }

  function cmToKm(value as Float or Number) as Float {
    return value / 100000.0;
  }

  function kilometersToMiles(value as Float or Number) as Float {
    return value * 0.6214;
  }

}