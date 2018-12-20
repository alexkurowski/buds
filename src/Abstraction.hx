import abstraction.*;

class Abstraction {
  static var log : Log;

  static public function init() {
    log = new Log();
  }

  static public function update() {
  }

  static public function getLog(n : Int) : Array<String> {
    return log.get(n);
  }
}
