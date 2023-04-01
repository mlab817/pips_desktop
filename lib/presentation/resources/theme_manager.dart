import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  bool get isDarkTheme {
    return _isDarkTheme;
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;

    notifyListeners();
  }

  static ThemeData get lightTheme {
    return FlexThemeData.light(
      colors: const FlexSchemeColor(
        primary: Color(0xff006837),
        primaryContainer: Color(0xffd0e4ff),
        secondary: Color(0xfff3791e),
        secondaryContainer: Color(0xffffdbcf),
        tertiary: Color(0xff006875),
        tertiaryContainer: Color(0xff95f0ff),
        appBarColor: Color(0xffffdbcf),
        error: Color(0xffb00020),
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 1,
      subThemesData: const FlexSubThemesData(
        useFlutterDefaults: true,
        blendOnLevel: 0,
        blendOnColors: true,
        textButtonRadius: AppSize.lg,
        defaultRadius: 12,
        thinBorderWidth: 0.5,
        thickBorderWidth: 3,
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
      lightIsWhite: true,
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }

  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      colors: const FlexSchemeColor(
        primary: Color(0xff006837),
        primaryContainer: Color(0xffd0e4ff),
        secondary: Color(0xfff3791e),
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
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }
}
