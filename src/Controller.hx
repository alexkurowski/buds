import controller.*;

class Controller {
  static public function init() {
    Camera.init();
  }

  static public function update() {
    Camera.update();
    Cards.update();
  }
}
