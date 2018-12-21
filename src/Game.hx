class Game {
  static public var s2d : h2d.Scene;
  static public var s3d : h3d.scene.Scene;

  static public var dt : Float;
  static var step : Float = 1 / 60;

  static public function init(app : hxd.App) {
    Assets.init();

    s2d = app.s2d;
    s3d = app.s3d;

    Input.init();
    Abstraction.init();
    Presentation.init();
  }

  static public function update(delta : Float) {
    dt = delta;

    Input.update();
    Presentation.update();

    if (dt < step) {
      Sys.sleep(step - dt);
    }
  }
}
