import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import './sizes_manager.dart';

class CustomTheme extends StateNotifier {
  final bool _isDarkTheme = false;

  CustomTheme() : super(CustomTheme());

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  bool get isDarkTheme {
    return _isDarkTheme;
  }

  void toggleTheme() {
    state = !_isDarkTheme;
  }

  static ThemeData get lightTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.greenM3,
      // colors: const FlexSchemeColor(
      //   // primary: Color(0xff006837),
      //   // primaryContainer: Color(0xffd0e4ff),
      //   // secondary: Color(0xfff3791e),
      //   // secondaryContainer: Color(0xffffdbcf),
      //   // tertiary: Color(0xff006875),
      //   // tertiaryContainer: Color(0xff95f0ff),
      //   // appBarColor: Color(0xffffdbcf),
      //   // error: Color(0xffb00020),
      //   primary: Color(0xfff7931e),
      //   primaryContainer: Color(0xffd0e4ff),
      //   secondary: Color(0xff006837),
      //   secondaryContainer: Color(0xffffdbcf),
      //   tertiary: Color(0xff006875),
      //   tertiaryContainer: Color(0xff95f0ff),
      //   appBarColor: Color(0xffffdbcf),
      //   error: Color(0xffb00020),
      // ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 2,
      subThemesData: const FlexSubThemesData(
        useFlutterDefaults: true,
        blendOnLevel: 2,
        blendOnColors: false,
        textButtonRadius: AppSize.lg,
        defaultRadius: 12,
        thinBorderWidth: 0.5,
        thickBorderWidth: 3,
        filledButtonRadius: AppSize.lg,
        elevatedButtonRadius: AppSize.lg,
        outlinedButtonRadius: AppSize.lg,
        inputDecoratorRadius: AppSize.lg,
        inputDecoratorUnfocusedBorderIsColored: false,
        inputDecoratorBorderWidth: 0.5,
        inputDecoratorFocusedBorderWidth: 3.0,
        fabUseShape: true,
        fabAlwaysCircular: true,
        cardRadius: 8.0,
        bottomSheetRadius: 8.0,
        bottomNavigationBarElevation: 1.0,
        navigationRailLabelType: NavigationRailLabelType.none,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      fontFamily: GoogleFonts.roboto().fontFamily,
      extensions: [],
    );
  }

  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      colors: const FlexSchemeColor(
        // primary: Color(0xff006837),
        // primaryContainer: Color(0xffd0e4ff),
        // secondary: Color(0xfff3791e),
        // secondaryContainer: Color(0xffffdbcf),
        // tertiary: Color(0xff006875),
        // tertiaryContainer: Color(0xff95f0ff),
        // appBarColor: Color(0xffffdbcf),
        // error: Color(0xffb00020),
        primary: Color(0xfffeb716),
        primaryContainer: Color(0xffd0e4ff),
        secondary: Color(0xff006d3a),
        secondaryContainer: Color(0xffffdbcf),
        tertiary: Color(0xff006875),
        tertiaryContainer: Color(0xff95f0ff),
        appBarColor: Color(0xffffdbcf),
        error: Color(0xffb00020),
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      subThemesData: const FlexSubThemesData(
        useFlutterDefaults: true,
        textButtonRadius: 1.0,
        elevatedButtonRadius: 1.0,
        outlinedButtonRadius: 1.0,
        inputDecoratorRadius: 8.0,
        inputDecoratorUnfocusedBorderIsColored: false,
        inputDecoratorBorderWidth: 0.5,
        inputDecoratorFocusedBorderWidth: 3.0,
        fabUseShape: true,
        fabAlwaysCircular: true,
        cardRadius: 8.0,
        bottomSheetRadius: 8.0,
        bottomNavigationBarElevation: 1.0,
        navigationRailLabelType: NavigationRailLabelType.none,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      fontFamily: GoogleFonts.roboto().fontFamily,
    );
  }
}
