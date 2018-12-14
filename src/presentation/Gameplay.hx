package presentation;

import presentable.*;

class Gameplay extends Presentation {
  public var cameraHeight : Float = 15;
  public var cameraTargetOffset : Float = -5;
  public var cameraDefaultFov : Float = 25;
  public var cameraMinFov : Float = 4;
  public var cameraMaxFov : Float = 35;

  public var table : Table;
  public var cards : Array<Card>;

  public function new(s2d, s3d) {
    super(s2d, s3d);

    setup3dCamera();
    setup3dLight();
    setup3dScene();
  }

  function setup3dCamera() {
    s3d.camera.pos.set(0, cameraHeight, cameraTargetOffset);
    s3d.camera.target.set(0, 0, 0);
    s3d.camera.fovY = cameraDefaultFov;
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

  override public function update() {
    for (card in cards) {
      card.update();
    }
  }

  public function findCardAt(point : h3d.col.Point) : Card {
    for (card in cards) {
      if (card.isInside(point)) {
        return card;
      }
    }

    return null;
  }
}
