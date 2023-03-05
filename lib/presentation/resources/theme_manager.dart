import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pips/presentation/resources/color_schemes.g.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  bool get isDarkTheme {
    return _isDarkTheme;
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;

    debugPrint(_isDarkTheme.toString());

    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: lightColorScheme,
      appBarTheme: AppBarTheme(
        elevation: AppSize.s0,
        titleTextStyle: GoogleFonts.creteRound(fontSize: FontSize.xxxl),
      ),
      navigationRailTheme: const NavigationRailThemeData(
        selectedIconTheme: IconThemeData(
          size: AppSize.s20,
        ),
        unselectedIconTheme: IconThemeData(
          size: AppSize.s20,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: AppSize.s18,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: AppSize.s16,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: AppSize.s14,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(fontSize: AppSize.s18),
        bodyMedium: TextStyle(fontSize: AppSize.s16),
        bodySmall: TextStyle(fontSize: AppSize.s14),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: GoogleFonts.sourceCodePro().fontFamily,
      colorScheme: darkColorScheme,
      appBarTheme: const AppBarTheme(
        elevation: AppSize.s0,
      ),
    );
  }
}
