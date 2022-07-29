import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';

MaterialColor _createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class AppTheme {
  static final light = ThemeData(
      brightness: Brightness.light,
      primarySwatch: _createMaterialColor(greenColor),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          labelSmall: const TextStyle(
            color: darkGreyColor,
            fontSize: 13,
          ),
          labelMedium: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          bodyMedium: const TextStyle(
            color: darkGreyColor,
            fontSize: 15,
            height: 1.3,
          ),
          headlineMedium: const TextStyle(
            color: Color(0xff4F4F4F),
            fontSize: 28,
          )),
      outlinedButtonTheme: _outlinedButtonTheme(),
      appBarTheme: const AppBarTheme(
        color: greenColor,
        toolbarHeight: ThemeConstants.toolbarHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(43),
            bottomRight: Radius.circular(43),
          ),
        ),
      ));

  static OutlinedButtonThemeData _outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(darkGreyColor.withOpacity(0.3)),
          backgroundColor: MaterialStateProperty.all(greenColor),
          foregroundColor: MaterialStateProperty.all(Colors.white)),
    );
  }
}
