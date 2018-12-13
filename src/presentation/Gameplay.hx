package presentation;

class Gameplay extends Presentation {
  var table : Table;
  var cards : Array<Card>;

  public function new(s2d, s3d) {
    super(s2d, s3d);

    setup3dCamera();
    setup3dLight();
    setup3dScene();
  }

  function setup3dCamera() {
    s3d.camera.pos.set(0, 15, -5);
  }

  function setup3dLight() {
    var light = new h3d.scene.DirLight(new h3d.Vector(0, -10, -7.5), s3d);
    light.enableSpecular = true;
    s3d.lightSystem.ambientLight.set(0.3, 0.3, 0.3);
  }

  function setup3dScene() {
    table = new Table(s3d);
    cards = [];
    cards.push(new Card(s3d));
  }

  public function findCardAt(point : h3d.col.Point) : Card {
    for (card in cards) {
      if (card.pointInBound(point)) {
        return card;
      }
    }

    return null;
  }
}
