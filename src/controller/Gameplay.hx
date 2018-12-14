package controller;

import concern.*;

class Gameplay extends Controller {
  var presentation : presentation.Gameplay;

  var camera : Camera;
  var cards : Cards;

  override public function init() {
    presentation = cast Game.presentation;

    camera = new Camera(presentation, s2d, s3d);
    cards = new Cards(presentation);
  }

  override public function update() {
    camera.update();
    cards.update();
  }
}
