import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

class ThemeManager {
  static ThemeData getApplicationTheme() {
    return ThemeData(
      useMaterial3: true,
      // fontFamily: FontFamily.primary,
      scaffoldBackgroundColor: ColorManager.white,
      appBarTheme: AppBarTheme(
        toolbarHeight: AppSize.s60,
        backgroundColor: ColorManager.white,
        foregroundColor: ColorManager.darkGray,
        titleTextStyle: GoogleFonts.raleway(
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
            color: ColorManager.lightGray,
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
        titleLarge: TextStyle(
          fontSize: AppSize.s16,
          fontWeight: FontWeight.w300,
        ),
        // placeholder for text input,
        // works also with list title
        titleMedium: TextStyle(
          fontSize: AppSize.s11,
          fontWeight: FontWeight.w300,
        ),
        titleSmall: TextStyle(
          fontSize: AppSize.s8,
          fontWeight: FontWeight.w300,
        ),
        bodyLarge: TextStyle(
          fontSize: AppSize.s12,
        ),
        bodyMedium: TextStyle(
          fontSize: AppSize.s11,
          fontWeight: FontWeight.w300,
        ),
        bodySmall: TextStyle(
          fontSize: AppSize.s10,
        ),
        labelSmall: TextStyle(
          fontSize: AppSize.s10,
        ),
        labelLarge: TextStyle(
          fontSize: AppSize.s12,
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dense: true,
        style: ListTileStyle.list,
        minLeadingWidth: AppSize.s20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        selectedColor: ColorManager.white,
        selectedTileColor: ColorManager.blue,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: ColorManager.primary,
        backgroundColor: ColorManager.darkWhite,
      ),
      // checkboxTheme: CheckboxThemeData(
      //   checkColor: MaterialStateProperty.resolveWith<Color>((states) {
      //     if (states.contains(MaterialState.selected)) {
      //       return ColorManager.primary;
      //     }
      //     return ColorManager.primary;
      //   }),
      // ),
      switchTheme: SwitchThemeData(
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorManager.primary;
          }
          return ColorManager.gray;
        }),
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorManager.primary;
          }
          return ColorManager.darkGray;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorManager.gray;
          }
          return ColorManager.gray;
        }),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
