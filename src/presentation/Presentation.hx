package presentation;

enum State {
  MainMenu;
  Gameplay;
}

class Presentation {
  public var state (default, null) : State;

  var s2d : h2d.Scene;
  var s3d : h3d.scene.Scene;

  var table : Table;
  var cards : Array<Card>;
  var pickedCard : Card;

  public function new(s2d, s3d) {
    this.s2d = s2d;
    this.s3d = s3d;

    setState(Gameplay);
  }

  public function setState(newState : State) : Bool {
    if (state != newState) {
      state = newState;
      setupScene();
      return true;
    } else {
      return false;
    }
  }

  function setupScene() {
    s2d.removeChildren();
    s3d.removeChildren();

    switch (state) {
      case Gameplay:
        setup3dCamera();
        setup3dLight();
        setup3dScene();
      default:
        return;
    }
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

  public function update() {
    cameraMovement();
    cardPickup();
  }

  function cameraMovement() {
    var dx : Float = 0;
    var dy : Float = 0;
    var dz : Float = 0;
    var speed : Float = 0.1;

    if (Game.input.up)    dz += speed;
    if (Game.input.down)  dz -= speed;
    if (Game.input.left)  dx -= speed;
    if (Game.input.right) dx += speed;

    if (Game.input.pointerWheel != 0) {
      dy += Game.input.pointerWheel;
      Game.input.pointerWheel = 0;
    }

    if (dx != 0 || dy != 0 || dz != 0) {
      s3d.camera.pos.x += dx;
      s3d.camera.pos.z += dz;
      s3d.camera.target.x += dx;
      s3d.camera.target.z += dz;
      s3d.camera.fovY += dy;
    }
  }

  function cardPickup() {
    if (Game.input.pointerDown) {
      for (card in cards) {
        if (card.pointInBound(Game.input.pointerPosition)) {
          pickedCard = card;
          pickedCard.pickUp();
        }
      }

      if (pickedCard != null) {
        pickedCard.moveTo(Game.input.pointerPosition);
      }
    } else {
      if (pickedCard != null) {
        pickedCard.putDown();
        pickedCard = null;
      }
    }
  }
}
