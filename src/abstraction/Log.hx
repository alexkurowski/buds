package abstraction;

class Log {
  static var logs : Array<String>;

  static public function reset() {
    logs = [];
  }

  static public function add(str : String) {
    logs.push(str);
  }

  static public function get(n : Int) : Array<String> {
    return logs.slice(logs.length - n, logs.length);
  }
}
