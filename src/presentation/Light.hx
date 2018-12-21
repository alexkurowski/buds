package presentation;

class Light {
  static var angle : Float = 60;

  static public function init() {
    var rad = angle / 180 * Math.PI;
    var dir = new h3d.Vector(0, -Math.sin(rad), -Math.cos(rad));
    var light = new h3d.scene.DirLight(dir, Game.s3d);
    light.enableSpecular = true;
    Game.s3d.lightSystem.ambientLight.set(0.3, 0.3, 0.3);
  }
}
