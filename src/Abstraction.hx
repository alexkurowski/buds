import abstraction.*;

class Abstraction {
  static public function init() {
    Log.reset();
  }

  static public function update() {
  }

  static public function getLog(n : Int) : Array<String> {
    return Log.get(n);
  }
}
