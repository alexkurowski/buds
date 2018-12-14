import hxd.Key in K;

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
  var keyCameraUp       : Int = K.UP;
  var keyCameraUpAlt    : Int = K.W;
  var keyCameraDown     : Int = K.DOWN;
  var keyCameraDownAlt  : Int = K.S;
  var keyCameraLeft     : Int = K.LEFT;
  var keyCameraLeftAlt  : Int = K.A;
  var keyCameraRight    : Int = K.RIGHT;
  var keyCameraRightAlt : Int = K.D;
  var keyCameraIn       : Int = K.MOUSE_WHEEL_DOWN;
  var keyCameraInAlt    : Int = 0;
  var keyCameraOut      : Int = K.MOUSE_WHEEL_UP;
  var keyCameraOutAlt   : Int = 0;
  var keyInteract       : Int = K.MOUSE_LEFT;
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
    return K.isDown(actionToKey(action)) ||
           K.isDown(actionToKeyAlt(action));
  }

  public function isPressed(action : Action) : Bool {
    return K.isPressed(actionToKey(action)) ||
           K.isPressed(actionToKeyAlt(action));
  }

  public function isReleased(action : Action) : Bool {
    return K.isReleased(actionToKey(action)) ||
           K.isReleased(actionToKeyAlt(action));
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
