enum GameState {
  Gameplay;
}

class Game extends hxd.App {
  public static var state : GameState;
  public static var input : Input;
  public static var controller : controller.Controller;
  public static var abstraction : abstraction.Abstraction;

  public static var dt : Float;

  private static var game : Game;

  override function init() {
    input = new Input(s3d);

    abstraction = new abstraction.Abstraction();
    setState(Gameplay);
  }

  override function update(dt : Float) {
    Game.dt = dt;

    input.update();

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
      switch newState {
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

    controller = switch newState {
      case Gameplay: new controller.Gameplay(s2d, s3d);
    }
  }
}
