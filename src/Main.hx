class Main extends hxd.App {
  static public var app : Main;

  static public function main() {
    app = new Main();
  }

  override function init() {
    Game.init(app);
  }

  override function update(dt : Float) {
    Game.update(dt);
  }
}
