package presentation;

class Table {
  var mesh : h3d.scene.Mesh;

  static inline var sizeX : Float = 10;
  static inline var sizeY : Float = 1;
  static inline var sizeZ : Float = 6;

  public function new(s3d : h3d.scene.Scene) {
    var primitive = new h3d.prim.Cube();
    primitive.unindex();
    primitive.addNormals();
    primitive.addUVs();

    mesh = new h3d.scene.Mesh(primitive, s3d);
    mesh.material.color.setColor(0x5b576d);
    mesh.material.shadows = false;

    mesh.setPosition(-sizeX * 0.5, -sizeY - 0.01, -sizeZ * 0.5);
    mesh.scaleX = sizeX;
    mesh.scaleY = sizeY;
    mesh.scaleZ = sizeZ;
  }
}
