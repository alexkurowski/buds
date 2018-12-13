enum GameState {
  Gameplay;
}

class Game extends hxd.App {
  public static var state : GameState;
  public static var input : Input;
  public static var controller : controller.Controller;
  public static var abstraction : abstraction.Abstraction;

  private static var game : Game;
  // var time : Float = 0;
  // var fps : h2d.Text;
  // var obj2 : h3d.scene.Mesh;

  override function init() {
    input = new Input(s3d);

    abstraction = new abstraction.Abstraction();
    setState(Gameplay);

    // // FPS text
    // fps = new h2d.Text(hxd.res.DefaultFont.get());
    // fps.text = "Hello, World!";
    // s2d.addChild(fps);

    // // 3d
    // var primitive = new h3d.prim.Cube();

    // // unindex the faces to create hard edges normals
    // primitive.unindex();
    // // add face normals
    // primitive.addNormals();
    // // add texture coordinates
    // primitive.addUVs();

    // var texture = new h3d.mat.Texture(1, 1);
    // var material = h3d.mat.Material.create(texture);

    // var obj1 = new h3d.scene.Mesh(primitive, material, s3d);
    // obj2 = new h3d.scene.Mesh(primitive, s3d);
    // obj2.material.color.setColor(0xFFB280);

    // var light = new h3d.scene.DirLight(new h3d.Vector(0.5, 0.5, -0.5), s3d);
    // light.enableSpecular = true;

    // s3d.lightSystem.ambientLight.set(0.3, 0.3, 0.3);

    // obj1.material.shadows = false;
    // // obj2.material.shadows = false;


    // var bounds = h3d.col.Bounds.fromValues(-0.5, -0.5, -0.5, 1.0, 1.0, 1.0);
    // var interactive = new h3d.scene.Interactive(bounds, obj2);

    // interactive.onOver = function (e) {
    //   trace("onOver");
    //   trace(e);
    // };

    // interactive.onOut = function (e) {
    //   trace("onOut");
    //   trace(e);
    // };
  }

  override function update(dt : Float) {
    input.update();

    // time += dt;

    // fps.text = "FPS: " + Std.string(1 / dt);

    // s3d.camera.pos.set(Math.cos(time) * dist, Math.sin(time) * dist, dist * 0.7 * Math.sin(time));
    // obj2.setRotationAxis(-0.5, 2, Math.cos(time), time + Math.PI / 2);

    if (controller != null) {
      controller.update();
    }

    Sys.sleep(1/60 - dt);
  }

  public static function main() {
    game = new Game();
  }

  public static function setState(newState : GameState) {
    if (newState != state) {
      switch (newState) {
        case Gameplay:
          game.changeStateTo(newState);
      }
    }
  }

  function changeStateTo(newState : GameState) {
    state = newState;

    if (controller != null) {
      controller.destroy();
    }

    controller = switch (newState) {
      case Gameplay: new controller.Gameplay(s2d, s3d);
    }
  }
}
