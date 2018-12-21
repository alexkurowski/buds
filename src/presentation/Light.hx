package presentation;

class Light {
  static public function init() {
    var light = new h3d.scene.DirLight(new h3d.Vector(0, -10, -7.5), Game.s3d);
    light.enableSpecular = true;
    Game.s3d.lightSystem.ambientLight.set(0.3, 0.3, 0.3);
  }
}
