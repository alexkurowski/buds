package controller;

class Gameplay extends Controller {
  var presentation : presentation.Gameplay;

  var pickedCard : presentable.Card;

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

    if (input.isDown(CAMERA_UP))    dz += speed;
    if (input.isDown(CAMERA_DOWN))  dz -= speed;
    if (input.isDown(CAMERA_LEFT))  dx -= speed;
    if (input.isDown(CAMERA_RIGHT)) dx += speed;

    if (input.isPressed(CAMERA_IN))  dy += 1;
    if (input.isPressed(CAMERA_OUT)) dy -= 1;

    if (dx != 0 || dy != 0 || dz != 0) {
      s3d.camera.pos.x += dx;
      s3d.camera.pos.z += dz;
      s3d.camera.target.x += dx;
      s3d.camera.target.z += dz;
      s3d.camera.fovY += dy;
    }
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
}
