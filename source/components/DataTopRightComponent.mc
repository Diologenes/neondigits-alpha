import Toybox.Graphics;
import Toybox.Lang;

class DataTopRightComponent extends DataAbstractComponent {

  function initialize(params as Dictionary) { 
    DataAbstractComponent.initialize(params);
  }

  function draw(dc as Dc) {
    dataIdentifier = "dataFieldTypeTopRight";
    yOffset = -85;
    xOffset = 25;
    textAlignment = Graphics.TEXT_JUSTIFY_LEFT;
    DataAbstractComponent.draw(dc);
  }
}