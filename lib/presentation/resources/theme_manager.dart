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
      appBarTheme: AppBarTheme(
        toolbarHeight: AppSize.s60,
        backgroundColor: ColorManager.white,
        foregroundColor: ColorManager.darkGray,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: ColorManager.darkGray,
          fontSize: AppSize.s14,
        ),
        elevation: AppSize.s1,
        shadowColor: ColorManager.white,
        surfaceTintColor: ColorManager.white,
        actionsIconTheme: IconThemeData(
          color: ColorManager.blue,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          padding: const EdgeInsets.symmetric(
            vertical: AppSize.s16,
            horizontal: AppSize.s16,
          ),
          minimumSize: const Size(double.infinity, AppSize.s24),
          textStyle: const TextStyle(
            fontSize: AppSize.s12,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: ColorManager.black,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: ColorManager.primary,
            width: AppSize.s2,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        focusColor: ColorManager.primary,
        isDense: true,
        floatingLabelStyle: TextStyle(
          color: ColorManager.primary,
        ),
        prefixIconColor: ColorManager.primary,
        suffixStyle: const TextStyle(fontSize: AppSize.s10),
        isCollapsed: true,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManager.primary,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: AppSize.s20,
        ),
        headlineMedium: TextStyle(
          fontSize: AppSize.s18,
        ),
        headlineSmall: TextStyle(
          fontSize: AppSize.s18,
        ),
        // placeholder for text input
        titleMedium: TextStyle(
          fontSize: AppSize.s12,
        ),
        titleSmall: TextStyle(
          fontSize: AppSize.s10,
        ),
        bodyLarge: TextStyle(
          fontSize: AppSize.s14,
        ),
        bodyMedium: TextStyle(
          fontSize: AppSize.s12,
        ),
        bodySmall: TextStyle(
          fontSize: AppSize.s10,
        ),
        labelSmall: TextStyle(
          fontSize: AppSize.s10,
        ),
        labelLarge: TextStyle(
          fontSize: AppSize.s14,
        ),
      ),
      // TODO: update text button style
      textButtonTheme: TextButtonThemeData(style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
          return ColorManager.primary;
        }),
      )),
      navigationRailTheme: NavigationRailThemeData(
        elevation: AppSize.s4,
        backgroundColor: ColorManager.lightGray,
        unselectedIconTheme: IconThemeData(
          color: ColorManager.darkGray,
          size: AppSize.s18,
        ),
        selectedIconTheme: IconThemeData(
          color: ColorManager.black,
          size: AppSize.s18,
        ),
        unselectedLabelTextStyle: TextStyle(color: ColorManager.black),
        selectedLabelTextStyle: TextStyle(
          color: ColorManager.black,
          fontWeight: FontWeight.bold,
        ),
        useIndicator: true,
        indicatorColor: ColorManager.gray,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ColorManager.primary,
      ),
      listTileTheme: ListTileThemeData(
        style: ListTileStyle.drawer,
        minLeadingWidth: AppSize.s20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
