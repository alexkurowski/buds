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
  var keyCameraUp       : Int = hxd.Key.UP;
  var keyCameraUpAlt    : Int = hxd.Key.W;
  var keyCameraDown     : Int = hxd.Key.DOWN;
  var keyCameraDownAlt  : Int = hxd.Key.S;
  var keyCameraLeft     : Int = hxd.Key.LEFT;
  var keyCameraLeftAlt  : Int = hxd.Key.A;
  var keyCameraRight    : Int = hxd.Key.RIGHT;
  var keyCameraRightAlt : Int = hxd.Key.D;
  var keyCameraIn       : Int = hxd.Key.MOUSE_WHEEL_DOWN;
  var keyCameraInAlt    : Int = 0;
  var keyCameraOut      : Int = hxd.Key.MOUSE_WHEEL_UP;
  var keyCameraOutAlt   : Int = 0;
  var keyInteract       : Int = hxd.Key.MOUSE_LEFT;
  var keyInteractAlt    : Int = 0;

  var window : hxd.Window;
  var camera : h3d.Camera;
  var tablePlane : h3d.col.Plane;

  public var mousePoint(default, null) : h2d.col.Point;
  public var tablePoint(default, null) : h3d.col.Point;

  public function new(s3d) {
    hxd.Key.ALLOW_KEY_REPEAT = false;

    window = hxd.Window.getInstance();
    camera = s3d.camera;
    tablePlane = new h3d.col.Plane(0, 1, 0, 0);
  }

  public function update() {
    mousePoint = new h2d.col.Point(window.mouseX, window.mouseY);
    tablePoint = camera
      .rayFromScreen(mousePoint.x, mousePoint.y)
      .intersect(tablePlane);
  }

  public function isDown(action : Action) : Bool {
    return hxd.Key.isDown(actionToKey(action)) ||
           hxd.Key.isDown(actionToKeyAlt(action));
  }

  public function isPressed(action : Action) : Bool {
    return hxd.Key.isPressed(actionToKey(action)) ||
           hxd.Key.isPressed(actionToKeyAlt(action));
  }

  public function isReleased(action : Action) : Bool {
    return hxd.Key.isReleased(actionToKey(action)) ||
           hxd.Key.isReleased(actionToKeyAlt(action));
  }

  function actionToKey(action : Action) : Int {
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

  function actionToKeyAlt(action : Action) : Int {
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
