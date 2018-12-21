package presentation;

class Cards {
  static var cards : Array<Card>;

  static var pickedCard : Card;

  static var dropArea : Float = 0.1;

  static public function init() {
    cards = [];

    for (i in 1...50)
      create();
  }

  static public function create(?initialPosition : h3d.col.Point) {
    cards.push(new Card(initialPosition));
  }

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

    for (card in cards) {
      card.update();
    }
  }

  static function pickUp() {
    pickedCard = findCardAt(Input.tablePoint, true);

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

  static public function findCardAt(point : h3d.col.Point, includePad : Bool = false) : Card {
    for (card in cards) {
      if (card.isInside(point, includePad)) {
        return card;
      }
    }

    return null;
  }

  static public function findAnotherCardAt(oneCard : Card) : Card {
    for (card in cards) {
      if (card != oneCard) {
        if (card.isInside(oneCard.center(), false)) {
          return card;
        }
      }
    }

    return null;
  }
}
