package concern;

class Cards {
  var presentation : presentation.Gameplay;
  var input : Input;

  var pickedCard : presentable.Card;

  public function new(presentation) {
    this.presentation = presentation;
    input = Game.input;
  }

  public function update() {
    if (input.isPressed(INTERACT)) {
      pickUp();
    }

    if (input.isDown(INTERACT)) {
      movePicked();
    }

    if (input.isUp(INTERACT)) {
      putDown();
    }
  }

  function pickUp() {
    pickedCard = presentation.findCardAt(input.tablePoint);

    if (pickedCard != null) {
      pickedCard.pickUp();
    }
  }

  function movePicked() {
    if (pickedCard != null) {
      pickedCard.moveTo(input.tablePoint);
    }
  }

  function putDown() {
    if (pickedCard != null) {
      pickedCard.putDown();
      pickedCard = null;
    }
  }
}
