package controller;

class Camera {
  static var cameraAngle : Float = 0;
  static var cameraFov : Float = 20;

  static var cameraInitialY : Float = 15;
  static var cameraMinY : Float = 4;
  static var cameraMaxY : Float = 35;
  static var cameraTargetOffsetZ : Float = -5;
  static var cameraInitialFov : Float = 20;

  static var cameraTargetPosition : h3d.Vector;
  static var targetTargetPosition : h3d.Vector;

  static public function init() {
    setupPosition();
  }

  static function setupPosition() {
    Game.s3d.camera.pos.set(0, cameraInitialY, cameraTargetOffsetZ);
    Game.s3d.camera.target.set(0, 0, 0);
    Game.s3d.camera.fovY = cameraInitialFov;

    cameraTargetPosition = Game.s3d.camera.pos.clone();
    targetTargetPosition = Game.s3d.camera.target.clone();
  }

  static public function update() {
    readInput();
    updatePosition();
  }

  static function readInput() {
    var dx : Float = 0;
    var dy : Float = 0;
    var dz : Float = 0;
    var panSpeed : Float = 4;
    var zoomSpeed : Float = 50;

    if (Input.isDown(CAMERA_UP))    dz += panSpeed * Game.dt;
    if (Input.isDown(CAMERA_DOWN))  dz -= panSpeed * Game.dt;
    if (Input.isDown(CAMERA_LEFT))  dx -= panSpeed * Game.dt;
    if (Input.isDown(CAMERA_RIGHT)) dx += panSpeed * Game.dt;

    if (Input.isPressed(CAMERA_IN))  dy += zoomSpeed * Game.dt;
    if (Input.isPressed(CAMERA_OUT)) dy -= zoomSpeed * Game.dt;

    if (dx != 0 || dy != 0 || dz != 0) {
      cameraTargetPosition.x += dx;
      cameraTargetPosition.y += dy;
      cameraTargetPosition.z += dz;
      targetTargetPosition.x += dx;
      targetTargetPosition.z += dz;
    }
  }

  static function updatePosition() {
    var cameraMinX : Float = -Presentation.table.width * 0.5;
    var cameraMaxX : Float =  Presentation.table.width * 0.5;
    var cameraMinY : Float =  cameraMinY;
    var cameraMaxY : Float =  cameraMaxY;
    var cameraMinZ : Float = -Presentation.table.height * 0.5 + cameraTargetOffsetZ;
    var cameraMaxZ : Float =  Presentation.table.height * 0.5 + cameraTargetOffsetZ;
    var tableMinX : Float = -Presentation.table.width * 0.5;
    var tableMaxX : Float =  Presentation.table.width * 0.5;
    var tableMinZ : Float = -Presentation.table.height * 0.5;
    var tableMaxZ : Float =  Presentation.table.height * 0.5;

    cameraTargetPosition.x = M.clamp(cameraTargetPosition.x, cameraMinX, cameraMaxX);
    cameraTargetPosition.y = M.clamp(cameraTargetPosition.y, cameraMinY, cameraMaxY);
    cameraTargetPosition.z = M.clamp(cameraTargetPosition.z, cameraMinZ, cameraMaxZ);
    targetTargetPosition.x = M.clamp(targetTargetPosition.x, tableMinX, tableMaxX);
    targetTargetPosition.z = M.clamp(targetTargetPosition.z, tableMinZ, tableMaxZ);

    Game.s3d.camera.pos.x = M.ease(Game.s3d.camera.pos.x, cameraTargetPosition.x, 2);
    Game.s3d.camera.pos.y = M.ease(Game.s3d.camera.pos.y, cameraTargetPosition.y, 2);
    Game.s3d.camera.pos.z = M.ease(Game.s3d.camera.pos.z, cameraTargetPosition.z, 2);
    Game.s3d.camera.target.x = M.ease(Game.s3d.camera.target.x, targetTargetPosition.x, 2.2);
    Game.s3d.camera.target.z = M.ease(Game.s3d.camera.target.z, targetTargetPosition.z, 2.2);
  }
}
