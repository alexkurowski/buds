package controller;

class Gameplay extends Controller {
  var presentation : presentation.Gameplay;

  var cameraTargetPosition : h3d.Vector;
  var targetTargetPosition : h3d.Vector;
  var cameraTargetFov : Float;

  var pickedCard : presentable.Card;

  public function new(s2d, s3d) {
    super(s2d, s3d);

    presentation = new presentation.Gameplay(s2d, s3d);

    cameraTargetPosition = s3d.camera.pos.clone();
    targetTargetPosition = s3d.camera.target.clone();
    cameraTargetFov = s3d.camera.fovY;
  }

  override public function update() {
    cameraMovement();
    updateCamera();
    cardPickup();
    presentation.update();
  }

  function cameraMovement() {
    var dx : Float = 0;
    var dy : Float = 0;
    var dz : Float = 0;
    var panSpeed : Float = 4;
    var zoomSpeed : Float = 50;

    if (input.isDown(CAMERA_UP))    dz += panSpeed * Game.dt;
    if (input.isDown(CAMERA_DOWN))  dz -= panSpeed * Game.dt;
    if (input.isDown(CAMERA_LEFT))  dx -= panSpeed * Game.dt;
    if (input.isDown(CAMERA_RIGHT)) dx += panSpeed * Game.dt;

    if (input.isPressed(CAMERA_IN))  dy += zoomSpeed * Game.dt;
    if (input.isPressed(CAMERA_OUT)) dy -= zoomSpeed * Game.dt;

    if (dx != 0 || dy != 0 || dz != 0) {
      cameraTargetPosition.x += dx;
      cameraTargetPosition.z += dz;
      targetTargetPosition.x += dx;
      targetTargetPosition.z += dz;
      cameraTargetFov += dy;
    }
  }

  function updateCamera() {
    var cameraMinX : Float = -presentation.table.width * 0.5;
    var cameraMaxX : Float =  presentation.table.width * 0.5;
    var cameraMinZ : Float = -presentation.table.height * 0.5 + presentation.cameraTargetOffset;
    var cameraMaxZ : Float =  presentation.table.height * 0.5 + presentation.cameraTargetOffset;
    var tableMinX : Float = -presentation.table.width * 0.5;
    var tableMaxX : Float =  presentation.table.width * 0.5;
    var tableMinZ : Float = -presentation.table.height * 0.5;
    var tableMaxZ : Float =  presentation.table.height * 0.5;
    var cameraMinFov : Float = presentation.cameraMinFov;
    var cameraMaxFov : Float = presentation.cameraMaxFov;

    cameraTargetPosition.x = clamp(cameraTargetPosition.x, cameraMinX, cameraMaxX);
    cameraTargetPosition.z = clamp(cameraTargetPosition.z, cameraMinZ, cameraMaxZ);
    targetTargetPosition.x = clamp(targetTargetPosition.x, tableMinX, tableMaxX);
    targetTargetPosition.z = clamp(targetTargetPosition.z, tableMinZ, tableMaxZ);
    cameraTargetFov = clamp(cameraTargetFov, cameraMinFov, cameraMaxFov);

    s3d.camera.pos.x += add(s3d.camera.pos.x, cameraTargetPosition.x, 2);
    s3d.camera.pos.z += add(s3d.camera.pos.z, cameraTargetPosition.z, 2);
    s3d.camera.target.x += add(s3d.camera.target.x, targetTargetPosition.x, 2.2);
    s3d.camera.target.z += add(s3d.camera.target.z, targetTargetPosition.z, 2.2);
    s3d.camera.fovY += add(s3d.camera.fovY, cameraTargetFov, 3);
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

  function add(current : Float, target : Float, offset : Float = 1) : Float {
    // TODO: Replace with slerp
    return (target - current) * offset * Game.dt;
  }

  function clamp(val : Float, min : Float, max : Float) : Float {
    if (val < min) return min;
    if (val > max) return max;
    return val;
  }
}
