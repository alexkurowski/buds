enum GameState {
  Gameplay;
}

class Game extends hxd.App {
  static public var state : GameState;
  static public var input : Input;
  static public var abstraction : abstraction.Abstraction;
  static public var presentation : presentation.Presentation;
  static public var controller : controller.Controller;

  static public var dt : Float;
  var step : Float = 1 / 60;

  static var game : Game;

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

    if (presentation != null) {
      presentation.update();
    }

    if (dt < step) {
      Sys.sleep(step - dt);
    }
  }

  static public function main() {
    game = new Game();
  }

  static public function setState(newState : GameState) {
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
