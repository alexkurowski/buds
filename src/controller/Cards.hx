package controller;

class Cards {
  static var pickedCard : presentation.Card;

  static var dropArea : Float = 0.1;

  static public function update() {
    if (Input.isPressed(INTERACT)) {
      pickUp();
    }

    if (Input.isDown(INTERACT)) {
      movePicked();
    }

    if (Input.isUp(INTERACT)) {
      putDown();
    }
  }

  static function pickUp() {
    pickedCard = Presentation.findCardAt(Input.tablePoint, true);

    if (pickedCard != null) {
      pickedCard.pickUp();
    }
  }

  static function movePicked() {
    if (pickedCard != null) {
      pickedCard.moveTo(Input.tablePoint);

      if (Input.mousePoint.y > hxd.Window.getInstance().height * (1 - dropArea)) {
        trace(Input.mousePoint.y);
      }
    }
  }

  static function putDown() {
    if (pickedCard != null) {
      pickedCard.putDown();
      pickedCard = null;
    }
  }
}
