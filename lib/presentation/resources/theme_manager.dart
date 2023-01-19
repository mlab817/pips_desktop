import 'package:flutter/material.dart';
import 'package:pips_desktop/presentation/resources/color_manager.dart';
import 'package:pips_desktop/presentation/resources/font_manager.dart';

class ThemeManager {
  static ThemeData getApplicationTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.primary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: ColorManager.primary,
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(style: BorderStyle.solid, color: ColorManager.primary),
        ),
        prefixIconColor: ColorManager.primary,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManager.primary,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
