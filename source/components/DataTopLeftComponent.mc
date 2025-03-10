import Toybox.Graphics;
import Toybox.Lang;

class DataTopLeftComponent extends DataAbstractComponent {

  function initialize(params as Dictionary) { 
    DataAbstractComponent.initialize(params);
  }

  function draw(dc as Dc) {
    dataIdentifier = "dataFieldTypeTopLeft";
    yOffset = -85;
    xOffset = -25;
    textAlignment = Graphics.TEXT_JUSTIFY_RIGHT;
    DataAbstractComponent.draw(dc);
  }

}