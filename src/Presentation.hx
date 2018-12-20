import presentation.*;

class Presentation {
  static public var table : Table;
  static var cards : Array<Card>;

  static var fps : h2d.Text;

  static public function init() {
    setup3dLight();
    setup3dScene();
    setup2dFps();
  }

  static function setup3dLight() {
    var light = new h3d.scene.DirLight(new h3d.Vector(0, -10, -7.5), Game.s3d);
    light.enableSpecular = true;
    Game.s3d.lightSystem.ambientLight.set(0.3, 0.3, 0.3);
  }

  static function setup3dScene() {
    table = new Table();
    cards = [];
    for (i in 0...20) {
      for (j in 0...15) {
        cards.push(new Card(new h3d.col.Point(i * Card.gridX, 0, j * Card.gridZ)));
      }
    }
  }

  static function setup2dFps() {
    fps = new h2d.Text(hxd.res.DefaultFont.get(), Game.s2d);
    fps.textColor = 0xffcc88;
  }

  static public function update() {
    for (card in cards) {
      card.update();
    }

    fps.text = Std.string(hxd.Timer.fps());
  }

  static public function findCardAt(point : h3d.col.Point, includePad : Bool = false) : Card {
    for (card in cards) {
      if (card.isInside(point, includePad)) {
        return card;
      }
    }

    return null;
  }

  static public function findAnotherCardAt(oneCard : Card) : Card {
    for (card in cards) {
      if (card != oneCard) {
        if (card.isInside(oneCard.center(), false)) {
          return card;
        }
      }
    }

    return null;
  }
}
