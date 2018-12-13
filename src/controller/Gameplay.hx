package controller;

class Gameplay extends Controller {
  var presentation : presentation.Gameplay;

  var pickedCard : presentation.Card;

  public function new(s2d, s3d) {
    super(s2d, s3d);

    presentation = new presentation.Gameplay(s2d, s3d);
  }

  override public function update() {
    cameraMovement();
    cardPickup();
    presentation.update();
  }

  function cameraMovement() {
    var dx : Float = 0;
    var dy : Float = 0;
    var dz : Float = 0;
    var speed : Float = 0.1;

    if (input.isDownUP())    dz += speed;
    if (input.isDownDOWN())  dz -= speed;
    if (input.isDownLEFT())  dx -= speed;
    if (input.isDownRIGHT()) dx += speed;

    // if (input.isPressed(input.wheelUp))   dy += 1;
    // if (input.isPressed(input.wheelDown)) dy -= 1;

    if (dx != 0 || dy != 0 || dz != 0) {
      s3d.camera.pos.x += dx;
      s3d.camera.pos.z += dz;
      s3d.camera.target.x += dx;
      s3d.camera.target.z += dz;
      s3d.camera.fovY += dy;
    }
  }

  function cardPickup() {
    if (input.isPressedMOUSE()) {
      pickedCard = presentation.findCardAt(input.tableMouse());

      if (pickedCard != null) {
        pickedCard.pickUp();
      }
    }

    if (pickedCard != null) {
      if (input.isDownMOUSE()) {
        pickedCard.moveTo(input.tableMouse());
      } else {
        pickedCard.putDown();
        pickedCard = null;
      }
    }
  }
}
