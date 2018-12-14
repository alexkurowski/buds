package abstraction;

class Abstraction {
  var log : Log;

  public function new() {
    log = new Log();
  }

  public function update() {
  }

  public function getLog(n : Int) : Array<String> {
    return log.get(n);
  }
}
