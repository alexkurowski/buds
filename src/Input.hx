import hxd.Key in K;

class Input {
  public static inline var up        : Int = K.W;
  public static inline var down      : Int = K.S;
  public static inline var left      : Int = K.A;
  public static inline var right     : Int = K.D;
  public static inline var wheelUp   : Int = K.MOUSE_WHEEL_UP;
  public static inline var wheelDown : Int = K.MOUSE_WHEEL_DOWN;

  var window : hxd.Window;
  var camera : h3d.Camera;
  var tablePlane : h3d.col.Plane;
  var tablePoint : h3d.col.Point;

  var dirty : Bool = true;

  public function new(s3d) {
    window = hxd.Window.getInstance();
    camera = s3d.camera;
    tablePlane = new h3d.col.Plane(0, 1, 0, 0);
  }

  public function update() {
    dirty = true;
  }

  public function mouseX() : Int return window.mouseX;
  public function mouseY() : Int return window.mouseY;

  public function tableMouseX() : Float return tableMouse().x;
  public function tableMouseY() : Float return tableMouse().y;
  public function tableMouseZ() : Float return tableMouse().z;

  public function isDownUP()        : Bool return K.isDown    (K.UP);
  public function isPressedUP()     : Bool return K.isPressed (K.UP);
  public function isReleasedUP()    : Bool return K.isReleased(K.UP);
  public function isDownDOWN()      : Bool return K.isDown    (K.DOWN);
  public function isPressedDOWN()   : Bool return K.isPressed (K.DOWN);
  public function isReleasedDOWN()  : Bool return K.isReleased(K.DOWN);
  public function isDownLEFT()      : Bool return K.isDown    (K.LEFT);
  public function isPressedLEFT()   : Bool return K.isPressed (K.LEFT);
  public function isReleasedLEFT()  : Bool return K.isReleased(K.LEFT);
  public function isDownRIGHT()     : Bool return K.isDown    (K.RIGHT);
  public function isPressedRIGHT()  : Bool return K.isPressed (K.RIGHT);
  public function isReleasedRIGHT() : Bool return K.isReleased(K.RIGHT);

  public function isDownMOUSE()     : Bool return K.isDown    (K.MOUSE_LEFT);
  public function isPressedMOUSE()  : Bool return K.isPressed (K.MOUSE_LEFT);
  public function isReleasedMOUSE() : Bool return K.isReleased(K.MOUSE_LEFT);

  public function tableMouse() : h3d.col.Point {
    if (dirty) {
      dirty = false;
      tablePoint = camera
        .rayFromScreen(mouseX(), mouseY())
        .intersect(tablePlane);
    }

    return tablePoint;
  }
}
