// convert hex to color
import 'dart:ui';

class ColorManager {
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color primary = HexColor.fromHex("#006837");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    // remove preceding #
    hexColorString = hexColorString.replaceAll("#", "");

    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }

    return Color(int.parse(hexColorString, radix: 16));
  }
}
