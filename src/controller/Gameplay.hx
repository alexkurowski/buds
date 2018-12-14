package controller;

import concern.*;

class Gameplay extends Controller {
  var presentation : presentation.Gameplay;

  var camera : Camera;

  var pickedCard : presentable.Card;

  public function new(s2d, s3d) {
    super(s2d, s3d);

    presentation = new presentation.Gameplay(s2d, s3d);

    camera = new Camera(presentation, s2d, s3d);
  }

  override public function update() {
    camera.update();
    cardPickup();
    presentation.update();
  }

  function cardPickup() {
    if (input.isPressed(INTERACT)) {
      pickedCard = presentation.findCardAt(input.tablePoint);

      if (pickedCard != null) {
        pickedCard.pickUp();
      }
    }

    if (pickedCard != null) {
      if (input.isDown(INTERACT)) {
        pickedCard.moveTo(input.tablePoint);
      } else {
        pickedCard.putDown();
        pickedCard = null;
      }
    }
  }

  function clamp(val : Float, min : Float, max : Float) : Float {
    if (val < min) return min;
    if (val > max) return max;
    return val;
  }
}
