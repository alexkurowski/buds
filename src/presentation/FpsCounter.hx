package presentation;

class FpsCounter {
  static var text : h2d.Text;

  static public function init() {
    text = new h2d.Text(hxd.res.DefaultFont.get(), Game.s2d);
    text.textColor = 0xffcc88;
  }

  static public function update() {
    text.text = Std.string(hxd.Timer.fps());
  }
}
