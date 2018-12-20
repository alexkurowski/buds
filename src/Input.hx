enum Action {
  CAMERA_UP;
  CAMERA_DOWN;
  CAMERA_LEFT;
  CAMERA_RIGHT;
  CAMERA_IN;
  CAMERA_OUT;
  INTERACT;
}

class Input {
  static public var mousePoint(default, null) : h2d.col.Point;
  static public var tablePoint(default, null) : h3d.col.Point;

  static var keyCameraUp       : Int = hxd.Key.UP;
  static var keyCameraUpAlt    : Int = hxd.Key.W;
  static var keyCameraDown     : Int = hxd.Key.DOWN;
  static var keyCameraDownAlt  : Int = hxd.Key.S;
  static var keyCameraLeft     : Int = hxd.Key.LEFT;
  static var keyCameraLeftAlt  : Int = hxd.Key.A;
  static var keyCameraRight    : Int = hxd.Key.RIGHT;
  static var keyCameraRightAlt : Int = hxd.Key.D;
  static var keyCameraIn       : Int = hxd.Key.MOUSE_WHEEL_DOWN;
  static var keyCameraInAlt    : Int = 0;
  static var keyCameraOut      : Int = hxd.Key.MOUSE_WHEEL_UP;
  static var keyCameraOutAlt   : Int = 0;
  static var keyInteract       : Int = hxd.Key.MOUSE_LEFT;
  static var keyInteractAlt    : Int = 0;

  static var window : hxd.Window;
  static var camera : h3d.Camera;
  static var tablePlane : h3d.col.Plane;

  static public function init() {
    hxd.Key.ALLOW_KEY_REPEAT = false;

    window = hxd.Window.getInstance();
    camera = Game.s3d.camera;
    tablePlane = new h3d.col.Plane(0, 1, 0, 0);
  }

  static public function update() {
    mousePoint = new h2d.col.Point(window.mouseX, window.mouseY);
    tablePoint = camera
      .rayFromScreen(mousePoint.x, mousePoint.y)
      .intersect(tablePlane);
  }

  static public function isDown(action : Action) : Bool {
    return hxd.Key.isDown(actionToKey(action)) ||
           hxd.Key.isDown(actionToKeyAlt(action));
  }

  static public function isUp(action : Action) : Bool {
    return !isDown(action);
  }

  static public function isPressed(action : Action) : Bool {
    return hxd.Key.isPressed(actionToKey(action)) ||
           hxd.Key.isPressed(actionToKeyAlt(action));
  }

  static public function isReleased(action : Action) : Bool {
    return hxd.Key.isReleased(actionToKey(action)) ||
           hxd.Key.isReleased(actionToKeyAlt(action));
  }

  static function actionToKey(action : Action) : Int {
    return switch action {
      case CAMERA_UP:    keyCameraUp;
      case CAMERA_DOWN:  keyCameraDown;
      case CAMERA_LEFT:  keyCameraLeft;
      case CAMERA_RIGHT: keyCameraRight;
      case CAMERA_IN:    keyCameraIn;
      case CAMERA_OUT:   keyCameraOut;
      case INTERACT:     keyInteract;
    }
  }

  static function actionToKeyAlt(action : Action) : Int {
    return switch action {
      case CAMERA_UP:    keyCameraUpAlt;
      case CAMERA_DOWN:  keyCameraDownAlt;
      case CAMERA_LEFT:  keyCameraLeftAlt;
      case CAMERA_RIGHT: keyCameraRightAlt;
      case CAMERA_IN:    keyCameraInAlt;
      case CAMERA_OUT:   keyCameraOutAlt;
      case INTERACT:     keyInteractAlt;
    }
  }
}
