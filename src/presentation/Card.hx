package presentation;

enum PushDirection {
  Left;
  Right;
}

class Card {
  static inline var sizeX : Float = 0.2;
  static inline var sizeY : Float = 0.001;
  static inline var sizeZ : Float = 0.3;
  static inline var pad : Float = 0.05;
  static inline var gridX : Float = sizeX + pad * 2;
  static inline var gridZ : Float = sizeZ + pad * 2;

  static public inline var width : Float = sizeX;
  static public inline var height : Float = sizeZ;

  static public inline var texWidth : Int = 200;
  static public inline var texHeight : Int = 300;

  var mesh : h3d.scene.Mesh;
  var position : h3d.col.Point;

  public function new(?initialPosition : h3d.col.Point) {
    var primitive = new h3d.prim.Cube();
    primitive.unindex();
    primitive.addNormals();
    primitive.addUVs();

    var texture = new h3d.mat.Texture(texWidth, texHeight, [Target]);

    var graphics = Assets.cardBackground;
    if (hxd.Math.random() < 0.7) {
      graphics.beginFill(0xeeeeee);
    } else {
      graphics.beginFill(0x4466ee);
    }
    graphics.drawRect(0, 0, texWidth, texHeight);
    graphics.endFill();
    graphics.drawTo(texture);
    graphics.clear();

    var textScale = 0.7;
    var text = Assets.cardText;
    text.setScale(textScale);
    text.textColor = 0x101010;
    text.textAlign = Center;
    text.maxWidth = texWidth / textScale;
    text.text = "Test";
    text.drawTo(texture);

    var material = h3d.mat.Material.create(texture);
    mesh = new h3d.scene.Mesh(primitive, material, Game.s3d);
    mesh.material.receiveShadows = false;

    mesh.scaleX = sizeX;
    mesh.scaleY = sizeY;
    mesh.scaleZ = sizeZ;

    position =
      if (initialPosition == null) {
        new h3d.col.Point();
      } else {
        initialPosition;
      }
    putDown();
    moveTo(position, true, true);
  }

  public function update() {
    move();
  }

  function move() {
    var moveSpeed = 8;

    mesh.x = M.ease(mesh.x, position.x, moveSpeed);
    mesh.y = M.ease(mesh.y, position.y, moveSpeed);
    mesh.z = M.ease(mesh.z, position.z, moveSpeed);
  }

  public function isInside(point : h3d.col.Point, includePad : Bool) : Bool {
    return if (includePad) {
      point.x > position.x - pad &&
      point.x < position.x + width + pad &&
      point.z > position.z - pad &&
      point.z < position.z + height + pad;
    } else {
      point.x > position.x &&
      point.x < position.x + width &&
      point.z > position.z &&
      point.z < position.z + height;
    }
  }

  public function pickUp() {
    position.y = 0.1;
  }

  public function putDown() {
    position.y = 0;
    snapToGrid();
    pushAnotherCard(Right);
  }

  function snapToGrid() {
    position.x = Math.round(position.x / gridX) * gridX;
    position.z = Math.round(position.z / gridZ) * gridZ;
  }

  public function pushAnotherCard(direction : PushDirection) {
    var card = Cards.findAnotherCardAt(this);

    if (card != null) {
      switch direction {
        case Left: card.moveBy(new h3d.col.Point(-gridX, 0, 0));
        case Right: card.moveBy(new h3d.col.Point(gridX, 0, 0));
      }
      card.pushAnotherCard(direction);
    }
  }

  public function center() : h3d.col.Point {
    return new h3d.col.Point(position.x + width * 0.5, position.y, position.z + height * 0.5);
  }

  public function moveTo(point : h3d.col.Point, immediate : Bool = false, skipOffset : Bool = false) {
    position = new h3d.col.Point(point.x, position.y, point.z);

    if (!skipOffset) {
      position.x -= width * 0.5;
      position.z -= height * 0.5;
    }

    if (immediate) {
      mesh.x = position.x;
      mesh.z = position.z;
    }
  }

  public function moveBy(point : h3d.col.Point) {
    position.x += point.x;
    position.y += point.y;
    position.z += point.z;
  }
}
