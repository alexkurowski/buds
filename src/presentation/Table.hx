package presentation;

class Table {
  static inline var sizeX : Float = 10;
  static inline var sizeY : Float = 1;
  static inline var sizeZ : Float = 6;

  static public inline var width : Float = sizeX;
  static public inline var height : Float = sizeZ;

  static var mesh : h3d.scene.Mesh;

  static public function init() {
    var primitive = new h3d.prim.Cube();
    primitive.unindex();
    primitive.addNormals();
    primitive.addUVs();

    mesh = new h3d.scene.Mesh(primitive, Game.s3d);
    mesh.material.color.setColor(0x66666a);
    mesh.material.castShadows = false;
    mesh.lightCameraCenter = true;

    var _sizeX = sizeX * 4;
    var _sizeY = sizeY;
    var _sizeZ = sizeZ * 4;
    mesh.setPosition(-_sizeX * 0.5, -_sizeY - 0.01, -_sizeZ * 0.5);
    mesh.scaleX = _sizeX;
    mesh.scaleY = _sizeY;
    mesh.scaleZ = _sizeZ;
  }
}
