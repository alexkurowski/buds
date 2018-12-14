class M {
  static public function clamp(val : Float, min : Float, max : Float) : Float {
    if (val < min) return min;
    if (val > max) return max;
    return val;
  }

  static public function ease(current : Float, target : Float, offset : Float = 1) : Float {
    return current + (target - current) * offset * Game.dt;
  }
}
