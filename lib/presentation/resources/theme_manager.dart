import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/font_manager.dart' show FontFamily;
import 'package:pips/presentation/resources/sizes_manager.dart';

class ThemeManager {
  static ThemeData getApplicationTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.primary,
      scaffoldBackgroundColor: ColorManager.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: ColorManager.primary,
        floatingLabelStyle: TextStyle(
          color: ColorManager.primary,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(style: BorderStyle.solid, color: ColorManager.primary),
        ),
        prefixIconColor: ColorManager.primary,
        suffixStyle: const TextStyle(fontSize: AppSize.s10),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManager.primary,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: AppSize.s20,
        ),
        headline2: TextStyle(
          fontSize: AppSize.s18,
        ),
        // placeholder for text input
        subtitle1: TextStyle(
          fontSize: AppSize.s14,
        ),
        subtitle2: TextStyle(
          fontSize: AppSize.s10,
        ),
        bodyText1: TextStyle(
          fontSize: AppSize.s12,
        ),
        bodyText2: TextStyle(
          fontSize: AppSize.s10,
        ),
        overline: TextStyle(
          fontSize: AppSize.s10,
        ),
        button: TextStyle(
          fontSize: AppSize.s14,
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        elevation: AppSize.s4,
        backgroundColor: ColorManager.gray,
        unselectedIconTheme: IconThemeData(
          color: ColorManager.darkGray,
        ),
        selectedIconTheme: IconThemeData(
          color: ColorManager.black,
        ),
        unselectedLabelTextStyle: TextStyle(color: ColorManager.black),
        selectedLabelTextStyle: TextStyle(
          color: ColorManager.black,
          fontWeight: FontWeight.bold,
        ),
        useIndicator: true,
        indicatorColor: ColorManager.darkGray,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
