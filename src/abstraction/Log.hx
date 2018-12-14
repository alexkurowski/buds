package abstraction;

class Log {
  var logs : Array<String>;

  public function new() {
  }

  public function add(str : String) {
    logs.push(str);
  }

  public function get(n : Int) : Array<String> {
    return logs.slice(logs.length - n, logs.length);
  }
}
