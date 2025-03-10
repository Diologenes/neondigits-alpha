import Toybox.Graphics;
import Toybox.Lang;

class DataBottomLeftComponent extends DataAbstractComponent {

  function initialize(params as Dictionary) { 
    DataAbstractComponent.initialize(params);
  }

  function draw(dc as Dc) {
    dataIdentifier = "dataFieldTypeBottomLeft";
    yOffset = 85;
    xOffset = getXOffset();
    textAlignment = Graphics.TEXT_JUSTIFY_RIGHT;
    DataAbstractComponent.draw(dc);
  }

  private function getXOffset() as Number {
    return Settings.getBoolean("useSeconds") ? -65 : -25;
  }

}