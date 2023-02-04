// convert hex to color
import 'dart:ui';

class ColorManager {
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color lightPrimary = HexColor.fromHex("#99c3af");
  static Color primary = HexColor.fromHex("#FFD700"); // gold
  static Color darkWhite = HexColor.fromHex("#F5F5F5");
  static Color veryLightGray = HexColor.fromHex("#e0e3e8");
  static Color lightGray = HexColor.fromHex("#E6E6E7");
  static Color gray = HexColor.fromHex("#d3cdcd");
  static Color darkGray = HexColor.fromHex("#CFCECF");
  static Color black = HexColor.fromHex("#000000");
  static Color blue = HexColor.fromHex("#0272F7");
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
