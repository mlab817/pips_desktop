import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      scheme: FlexScheme.damask,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 9,
      appBarElevation: 1,
      // appBarStyle: FlexAppBarStyle.material,
      textTheme: const TextTheme(
        // used for subtitle in list tile
        titleLarge: TextStyle(
          fontSize: FontSize.xxl,
        ),
        titleMedium: TextStyle(
          fontSize: FontSize.xl,
        ),
        titleSmall: TextStyle(
          fontSize: FontSize.lg,
        ),
        bodyLarge: TextStyle(
          fontSize: FontSize.xl,
        ),
        bodyMedium: TextStyle(
          fontSize: FontSize.lg,
        ),
        bodySmall: TextStyle(
          fontSize: FontSize.md,
        ),
      ),
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 8.0,
        inputDecoratorUnfocusedBorderIsColored: false,
        inputDecoratorBorderWidth: 0.5,
        inputDecoratorFocusedBorderWidth: 3.0,
        cardRadius: 8.0,
        bottomSheetRadius: 8.0,
        bottomNavigationBarElevation: 2.0,
        navigationRailLabelType: NavigationRailLabelType.none,
        navigationRailUseIndicator: false,
        thickBorderWidth: 4.0,
        thinBorderWidth: 0.5,
        // buttonPadding: EdgeInsets.all(AppPadding.md),
        fabRadius: 50.0,
      ),
      // visualDensity: FlexColorScheme.comfortablePlatformDensity,
      visualDensity: VisualDensity.compact,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      fontFamily: GoogleFonts
          .mavenPro()
          .fontFamily,
    );
  }

  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.damask,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        inputDecoratorRadius: 8.0,
        inputDecoratorUnfocusedBorderIsColored: false,
        inputDecoratorBorderWidth: 0.5,
        inputDecoratorFocusedBorderWidth: 3.0,
        cardRadius: 8.0,
        bottomSheetRadius: 8.0,
        bottomNavigationBarElevation: 1.0,
        navigationRailUseIndicator: false,
      ),
      // visualDensity: FlexColorScheme.comfortablePlatformDensity,
      visualDensity: VisualDensity.compact,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }
}
