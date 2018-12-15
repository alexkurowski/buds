class Assets {
  public static var textFont : h2d.Font;
  public static var cardText : h2d.Text;

  public static function init() {
    textFont = hxd.Res.eczar.toFont();

    cardText = new h2d.Text(textFont);
  }
}
