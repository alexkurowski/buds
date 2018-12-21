package presentation;

class Camera {
  static var camera : h3d.Camera;

  static var angle : Float = 75;
  static var fov : Float = 20;

  static inline var panSpeed : Float = 4;
  static inline var zoomSpeed : Float = 50;

  static var distance : Float = 20;
  static var distanceTarget : Float = distance;
  static var distanceMin : Float = 5;
  static var distanceMax : Float = 25;

  static var targetPosition : h3d.Vector;

  static public function init() {
    camera = Game.s3d.camera;

    targetPosition = new h3d.Vector(0, 0, 0);

    camera.target.load(targetPosition);
    updateCamera();

    camera.fovY = fov;
  }

  static public function update() {
    readInput();
    clampTarget();
    updateTarget();
    updateCamera();
  }

  static function readInput() {
    var dx : Float = 0;
    var dy : Float = 0;
    var dz : Float = 0;

    if (Input.isDown(CAMERA_UP))    dz += panSpeed * Game.dt;
    if (Input.isDown(CAMERA_DOWN))  dz -= panSpeed * Game.dt;
    if (Input.isDown(CAMERA_LEFT))  dx -= panSpeed * Game.dt;
    if (Input.isDown(CAMERA_RIGHT)) dx += panSpeed * Game.dt;

    targetPosition.x += dx;
    targetPosition.z += dz;

    if (Input.isPressed(CAMERA_IN))  dy += zoomSpeed * Game.dt;
    if (Input.isPressed(CAMERA_OUT)) dy -= zoomSpeed * Game.dt;

    distanceTarget += dy;
  }

  static function clampTarget() {
    var tableMinX : Float = -Table.width * 0.5;
    var tableMaxX : Float =  Table.width * 0.5;
    var tableMinZ : Float = -Table.height * 0.5;
    var tableMaxZ : Float =  Table.height * 0.5;

    targetPosition.x = M.clamp(targetPosition.x, tableMinX, tableMaxX);
    targetPosition.z = M.clamp(targetPosition.z, tableMinZ, tableMaxZ);

    distanceTarget = M.clamp(distanceTarget, distanceMin, distanceMax);
  }

  static function updateTarget() {
    camera.target.x = M.ease(camera.target.x, targetPosition.x, 2.2);
    camera.target.z = M.ease(camera.target.z, targetPosition.z, 2.2);

    distance = M.ease(distance, distanceTarget, 4);
  }

  static function updateCamera() {
    var rad = angle / 180 * Math.PI;

    camera.pos.set(
      camera.target.x,
      camera.target.y + Math.sin(rad) * distance,
      camera.target.z - Math.cos(rad) * distance
    );
  }
}
