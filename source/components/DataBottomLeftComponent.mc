import Toybox.Graphics;

class DataBottomLeftComponent extends DataAbstractComponent {

  function initialize(params) { 
    DataAbstractComponent.initialize(params);
  }

  function draw(dc as Dc) {
    dataIdentifier = "dataFieldTypeBottomLeft";
    yOffset = 85;
    xOffset = getXOffset();
    textAlignment = Graphics.TEXT_JUSTIFY_RIGHT;
    DataAbstractComponent.draw(dc);
  }

  private function getXOffset() {
    return Settings.get("useSeconds") ? -60 : -25;
  }

}