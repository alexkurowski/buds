package presentation;

class Presentation {
  var s2d : h2d.Scene;
  var s3d : h3d.scene.Scene;

  public function new(s2d : h2d.Scene, s3d : h3d.scene.Scene) {
    this.s2d = s2d;
    this.s3d = s3d;
  }

  public function init() {}
  public function update() {}
  public function destroy() {}
}
