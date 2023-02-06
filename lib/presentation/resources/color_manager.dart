// convert hex to color
import 'dart:ui';

class ColorManager {
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color lightPrimary = HexColor.fromHex("#99c3af");

  // static Color primary = HexColor.fromHex("#f7941d"); // gold
  static Color primary = HexColor.fromHex("#0272F7");
  static Color darkWhite = HexColor.fromHex("#F5F5F5");
  static Color veryLightGray = HexColor.fromHex("#E0E3E8");
  static Color lightGray = HexColor.fromHex("#E6E6E7");
  static Color gray = HexColor.fromHex("#D3CDCD");
  static Color darkGray = HexColor.fromHex("#6F7070");
  static Color black = HexColor.fromHex("#252626");
  static Color blue = HexColor.fromHex("#0272F7");

  static Color contentBgGray = HexColor.fromHex("#f0f1f1");
  static Color borderGray = HexColor.fromHex("#e3e4e4");
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
