package controller;

import concern.*;

class Gameplay extends Controller {
  public var presentation : presentation.Gameplay;

  var camera : Camera;
  var cards : Cards;

  public function new(s2d, s3d) {
    super(s2d, s3d);

    presentation = new presentation.Gameplay(s2d, s3d);

    camera = new Camera(presentation, s2d, s3d);
    cards = new Cards(presentation);
  }

  override public function update() {
    camera.update();
    cards.update();

    presentation.update();
  }
}
