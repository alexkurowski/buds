package presentable;

class Card {
  var mesh : h3d.scene.Mesh;
  var position : h3d.col.Point;

  static inline var sizeX : Float = 0.2;
  static inline var sizeY : Float = 0.001;
  static inline var sizeZ : Float = 0.3;
  static inline var pad : Float = 0.05;

  public var width : Float = sizeX;
  public var height : Float = sizeZ;

  public function new(s3d : h3d.scene.Scene) {
    var primitive = new h3d.prim.Cube();
    primitive.unindex();
    primitive.addNormals();
    primitive.addUVs();

    mesh = new h3d.scene.Mesh(primitive, s3d);
    mesh.material.color.setColor(0xf0f0f0);
    mesh.material.receiveShadows = false;

    mesh.scaleX = sizeX;
    mesh.scaleY = sizeY;
    mesh.scaleZ = sizeZ;

    position = new h3d.col.Point();
    moveTo(position, true);
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

  public function isInside(point : h3d.col.Point) : Bool {
    return point.x > mesh.x &&
           point.x < mesh.x + sizeX &&
           point.z > mesh.z &&
           point.z < mesh.z + sizeZ;
  }

  public function pickUp() {
    position.y = 0.1;
  }

  public function putDown() {
    var gridX = width + pad * 2;
    var gridZ = height + pad * 2;

    position.x = Math.round(position.x / gridX) * gridX;
    position.y = 0;
    position.z = Math.round(position.z / gridZ) * gridZ;
  }

  public function moveTo(point : h3d.col.Point, immediate : Bool = false) {
    position = new h3d.col.Point(point.x, position.y, point.z);
    position.x -= width * 0.5;
    position.z -= height * 0.5;

    if (immediate) {
      mesh.x = position.x;
      mesh.z = position.z;
    }
  }
}
