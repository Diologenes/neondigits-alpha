import Toybox.Graphics;
import Toybox.Lang;

class DataBottomRightComponent extends DataAbstractComponent {

  function initialize(params as Dictionary) { 
    DataAbstractComponent.initialize(params);
  }

  function draw(dc as Dc) {
    dataIdentifier = "dataFieldTypeBottomRight";
    yOffset = 85;
    xOffset = getXOffset();
    textAlignment = Graphics.TEXT_JUSTIFY_LEFT;
    DataAbstractComponent.draw(dc);
  }

  private function getXOffset() as Number {
    return Settings.getBoolean("useSeconds") ? 65 : 25;
  }
}