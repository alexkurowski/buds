package presentable;

class Card {
  var mesh : h3d.scene.Mesh;
  var position : h3d.col.Point;

  static inline var sizeX : Float = 0.2;
  static inline var sizeY : Float = 0.001;
  static inline var sizeZ : Float = 0.3;

  public function new(s3d : h3d.scene.Scene) {
    var primitive = new h3d.prim.Cube();
    primitive.unindex();
    primitive.addNormals();
    primitive.addUVs();

    mesh = new h3d.scene.Mesh(primitive, s3d);
    mesh.material.color.setColor(0xf0f0f0);
    mesh.material.shadows = true;

    position = new h3d.col.Point();
    moveTo(position);
    mesh.scaleX = sizeX;
    mesh.scaleY = sizeY;
    mesh.scaleZ = sizeZ;
  }

  public function pointInBound(point : h3d.col.Point) : Bool {
    return point.x > mesh.x &&
           point.x < mesh.x + sizeX &&
           point.z > mesh.z &&
           point.z < mesh.z + sizeZ;
  }

  public function pickUp() {
    mesh.y = 0.25;
  }

  public function putDown() {
    mesh.y = 0;
  }

  public function moveTo(point : h3d.col.Point) {
    trace(point);
    mesh.x = point.x - sizeX * 0.5;
    mesh.z = point.z - sizeZ * 0.5;
  }
}
