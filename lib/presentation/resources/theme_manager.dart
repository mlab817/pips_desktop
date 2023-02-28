import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/color_schemes.g.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

class ThemeManager {
  static ThemeData getApplicationTheme(
      BuildContext context, ThemeMode themeMode) {
    return ThemeData(
      useMaterial3: true,
      // scaffoldBackgroundColor: ColorManager.white,
      colorScheme:
          themeMode == ThemeMode.light ? lightColorScheme : darkColorScheme,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      appBarTheme: const AppBarTheme(
        toolbarHeight: AppSize.s60,
        elevation: AppSize.s1,
      ),
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        return Theme.of(context).colorScheme.onPrimary;
      }), checkColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Theme.of(context).colorScheme.primary;
        }
        return Theme.of(context).colorScheme.onPrimary;
      })),
      //   // backgroundColor: ColorManager.white,
      //   // foregroundColor: ColorManager.darkGray,
      //   titleTextStyle: TextStyle(
      //     fontWeight: FontWeight.w700,
      //     // color: ColorManager.darkGray,
      //     fontSize: AppSize.s14,
      //   ),
      // elevation: AppSize.s1,
      // shadowColor: ColorManager.white,
      // surfaceTintColor: ColorManager.white,
      // actionsIconTheme: IconThemeData(
      //   color: ColorManager.blue,
      // ),
      // ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            // color: ColorManager.lightGray,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSize.s3,
            color: themeMode == ThemeMode.light
                ? lightColorScheme.primary
                : darkColorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        //   borderSide: const BorderSide(
        //     // style: BorderStyle.solid,
        //     // color: ColorManager.primary,
        //     width: AppSize.s2,
        //   ),
        //   borderRadius: BorderRadius.circular(AppSize.s8),
        // ),
        focusColor: themeMode == ThemeMode.light
            ? lightColorScheme.primary
            : darkColorScheme.primary,
        isDense: true,
        // floatingLabelStyle: TextStyle(
        //   color: ColorManager.primary,
        // ),
        prefixIconColor: themeMode == ThemeMode.light
            ? lightColorScheme.outline
            : darkColorScheme.outline,
        suffixStyle: const TextStyle(fontSize: AppSize.s10),
        isCollapsed: true,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Theme.of(context).colorScheme.primary,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: AppSize.s20,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          fontSize: AppSize.s18,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          fontSize: AppSize.s16,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          fontSize: AppSize.s16,
          fontWeight: FontWeight.w300,
        ),
        // placeholder for text input,
        // works also with list title
        titleMedium: TextStyle(
          fontSize: AppSize.s14,
          fontWeight: FontWeight.w300,
        ),
        titleSmall: TextStyle(
          fontSize: AppSize.s12,
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
      // navigationRailTheme: const NavigationRailThemeData(
      //   elevation: AppSize.s4,
      //   // backgroundColor: ColorManager.lightGray,
      //   unselectedIconTheme: IconThemeData(
      //     // color: ColorManager.darkGray,
      //     size: AppSize.s18,
      //   ),
      //   selectedIconTheme: IconThemeData(
      //     // color: ColorManager.black,
      //     size: AppSize.s18,
      //   ),
      //   // unselectedLabelTextStyle: TextStyle(color: ColorManager.black),
      //   selectedLabelTextStyle: TextStyle(
      //     // color: ColorManager.black,
      //     fontWeight: FontWeight.bold,
      //   ),
      //   useIndicator: true,
      //   // indicatorColor: ColorManager.gray,
      // ),
      // progressIndicatorTheme: ProgressIndicatorThemeData(
      //   color: ColorManager.primary,
      // ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(fontSize: AppSize.s10),
        unselectedLabelStyle: TextStyle(fontSize: AppSize.s10),
      ),
      listTileTheme: ListTileThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dense: true,
        style: ListTileStyle.list,
        minLeadingWidth: AppSize.s20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        selectedTileColor: themeMode == ThemeMode.light
            ? lightColorScheme.primary
            : darkColorScheme.primary,
        selectedColor: themeMode == ThemeMode.light
            ? lightColorScheme.onPrimary
            : darkColorScheme.onPrimary,
      ),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //   foregroundColor: ColorManager.primary,
      //   backgroundColor: ColorManager.darkWhite,
      // ),
      // checkboxTheme: CheckboxThemeData(
      //   checkColor: MaterialStateProperty.resolveWith<Color>((states) {
      //     if (states.contains(MaterialState.selected)) {
      //       return ColorManager.primary;
      //     }
      //     return ColorManager.primary;
      //   }),
      // ),
      // switchTheme: SwitchThemeData(
      //   overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
      //     if (states.contains(MaterialState.selected)) {
      //       return ColorManager.primary;
      //     }
      //     return ColorManager.gray;
      //   }),
      //   thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
      //     if (states.contains(MaterialState.selected)) {
      //       return ColorManager.primary;
      //     }
      //     return ColorManager.darkGray;
      //   }),
      //   trackColor: MaterialStateProperty.resolveWith<Color>((states) {
      //     if (states.contains(MaterialState.selected)) {
      //       return ColorManager.gray;
      //     }
      //     return ColorManager.gray;
      //   }),
      // ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;

    debugPrint(_isDarkTheme.toString());

    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData();
  }

  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.black,
    );
  }
}
