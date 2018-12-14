import abstraction.Abstraction;

enum GameState {
  Gameplay;
}

class Game extends hxd.App {
  public static var state : GameState;
  public static var input : Input;
  public static var abstraction : Abstraction;
  public static var presentation : Presentation;
  public static var controller : Controller;

  public static var dt : Float;
  var step : Float = 1 / 60;

  static var game : Game;

  override function init() {
    input = new Input(s3d);
    abstraction = new Abstraction();
    setState(Gameplay);
  }

  override function update(dt : Float) {
    Game.dt = dt;

    input.update();
    controller.update();
    presentation.update();

    if (dt < step) {
      Sys.sleep(step - dt);
    }
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

    if (presentation != null) {
      presentation.destroy();
    }

    if (controller != null) {
      controller.destroy();
    }

    switch newState {
      case Gameplay:
        presentation = new presentation.Gameplay(s2d, s3d);
        controller = new controller.Gameplay(s2d, s3d);
    }

    presentation.init();
    controller.init();
  }
}
