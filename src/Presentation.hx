import presentation.*;

class Presentation {
  static public function init() {
    Light.init();
    Camera.init();
    Table.init();
    Cards.init();
    FpsCounter.init();
  }

  static public function update() {
    Camera.update();
    Cards.update();
    FpsCounter.update();
  }
}
