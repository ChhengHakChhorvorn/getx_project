import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColors {
  static const Color lightGreen = Color.fromRGBO(42, 164, 171, 0.2);
  static const Color green = Color.fromRGBO(42, 164, 171, 1);
  static const Color red = Color.fromRGBO(158, 32, 61, 1);
  static const Color lightRed = Color.fromRGBO(218, 41, 81, 1);

  static const colorPrimaryBlue = Color(0xFF0E20C0);
  static const colorPrimaryRed = Color(0xFFFA4169);
  static const colorPrimaryBlack = Color(0xFF000000);
  static const colorPrimaryGreen = Color(0xFF00C566);
  static const colorSecondaryBlue = Color(0xFF35BDC6);
  static const colorPrimaryYellow = Color(0xFFFFA500);
  static const colorPrimaryGrey = Color(0xFF707070);
  static const colorPrimaryGreyLight = Color(0xFFEEEEEE);
  static const colorPrimaryCard = Color(0xFFE1E1E1);
  static const colorPrimaryWhite = Color(0xFFFFFFFF);
  static const colorBackground = Color(0xFFF9F9F9);
  static const colorPrimaryBorderColor = Color(0xFFE2E5E8);
  static const colorPrimaryTransparent = Color(0x00000000);
}

final customTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.kantumruyProTextTheme(),
).copyWith(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: generateMaterialColor(ThemeColors.colorPrimaryBlue),
    accentColor: ThemeColors.colorPrimaryBlue,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: ThemeColors.colorBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: ThemeColors.colorPrimaryWhite,
    foregroundColor: ThemeColors.colorPrimaryBlack,
    elevation: 0,
    titleTextStyle: GoogleFonts.kantumruyPro(
      fontWeight: FontWeight.w600,
      color: ThemeColors.colorPrimaryBlue,
      fontSize: 25,
    ),
  ),
);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) {
  return max(0, min((value + ((255 - value) * factor)).round(), 255));
}

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
