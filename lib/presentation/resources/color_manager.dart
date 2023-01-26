// convert hex to color
import 'dart:ui';

class ColorManager {
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color lightPrimary = HexColor.fromHex("#99c3af");
  static Color primary = HexColor.fromHex("#FFD700"); // gold
  static Color lightGray = HexColor.fromHex("#D3D3D3");
  static Color gray = HexColor.fromHex("#d3cdcd");
  static Color darkGray = HexColor.fromHex("#c6c1c0");
  static Color black = HexColor.fromHex("#000000");
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
