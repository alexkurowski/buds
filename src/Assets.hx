class Assets {
  static public var textFont : h2d.Font;
  static public var cardText : h2d.Text;
  static public var cardBackground : h2d.Graphics;

  static public function init() {
    hxd.Res.initEmbed();

    textFont = hxd.Res.eczar.toFont();

    cardText = new h2d.Text(textFont);
    cardBackground = new h2d.Graphics();
  }
}
