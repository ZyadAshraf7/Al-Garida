import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xff4D6EFD);
  static const Color blue2 = Color(0xff758FFD);
  static const Color blue3 = Color(0xffF5F7FB);
  static const Color blue4 = Color(0xff1E293B);
  static const Color blue5 = Color(0xff121826);
  static const Color error = Color(0xffCE443C);
  static const Color stroke = Color(0xff334155);
  static const Color orange = Color(0xffFF853A);

  // greyscale colors
  static const Color grey50 = Color(0xffFAFAFA);
  static const Color grey100 = Color(0xffF5F5F5);
  static const Color grey200 = Color(0xffE8E8E8);
  static const Color grey300 = Color(0xffD6D6D6);
  static const Color grey400 = Color(0xffB8B8B8);
  static const Color grey500 = Color(0xffA6A6A6);
  static const Color grey600 = Color(0xff7A7A7A);
  static const Color grey700 = Color(0xff454545);
  static const Color grey800 = Color(0xff292929);
  static const Color grey900 = Color(0xff121212);

  const AppTheme._();

  static final appLightMode = ThemeData(
      fontFamily: 'Cairo',
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
      textTheme: const TextTheme(
        displayMedium: TextStyle(color: grey800),
        displaySmall: TextStyle(color: grey800, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: grey500),
      ),
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: grey200, width: 1),
              borderRadius: BorderRadius.circular(12)),
          // outlineBorder: const BorderSide(color: grey200,width: 1),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: grey200, width: 1),
              borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.all(12)),
      colorScheme: const ColorScheme(
        background: Colors.white,
        brightness: Brightness.light,
        error: error,
        primary: primaryBlue,
        secondary: Colors.white,
        surface: Colors.black,
        onBackground: Colors.white,
        onError: error,
        onPrimary: primaryBlue,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ));


  static final appDarkMode = ThemeData(
      fontFamily: 'Cairo',
      appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0),
      textTheme: const TextTheme(
        displayMedium: TextStyle(color: Colors.white),
        displaySmall:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: grey400),
      ),
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: grey700, width: 1),
              borderRadius: BorderRadius.circular(12)),
          // outlineBorder: const BorderSide(color: grey200,width: 1),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: grey700, width: 1),
              borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.all(12)),
      scaffoldBackgroundColor: blue5,
      colorScheme: const ColorScheme(
        background: blue5,
        brightness: Brightness.dark,
        error: error,
        primary: primaryBlue,
        secondary: Colors.white,
        surface: Colors.white,
        onBackground: Colors.white,
        onError: error,
        onPrimary: primaryBlue,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ));
}