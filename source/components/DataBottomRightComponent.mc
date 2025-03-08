import Toybox.Graphics;

class DataBottomRightComponent extends DataAbstractComponent {

  function initialize(params) { 
    DataAbstractComponent.initialize(params);
  }

  function draw(dc as Dc) {
    dataIdentifier = "dataFieldTypeBottomRight";
    yOffset = 85;
    xOffset = getXOffset();
    textAlignment = Graphics.TEXT_JUSTIFY_LEFT;
    DataAbstractComponent.draw(dc);
  }

  private function getXOffset() {
    return Settings.get("useSeconds") ? 60 : 25;
  }
}