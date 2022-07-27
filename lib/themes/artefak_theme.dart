import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFF121212),
  // backgroundColor: Colors.transparent, don't use this, applied to bottomNav
  highlightColor: const Color(0xB8333333),
  primaryColorDark: const Color(0xFF333333),
  indicatorColor: const Color(0xFFD1D5DB),
  selectedRowColor: const Color(0xFF2563EB),
  textSelectionColor: const Color(0xFFF3F4F6),
  unselectedWidgetColor: const Color(0xFF8A8B8C),
  focusColor: const Color(0xFF9CA3AF),
  shadowColor: const Color(0xFF252525),
  hintColor: const Color(0xFF7CA1F3),
  canvasColor: const Color(0xFF383838),
  toggleableActiveColor: const Color(0xFF73C892),
  secondaryHeaderColor: const Color(0xFFFBAB73),
  cursorColor: const Color(0xFF4B5563),
  errorColor: const Color(0xFFEA7D7D),
  cardColor: const Color(0xFF4C4C4C),
  dialogBackgroundColor: const Color(0xFFDC2626),

  // App Bar
  appBarTheme: const AppBarTheme(
    backgroundColor: const Color(0xB8333333),
    // This will be applied to the "back" icon
    iconTheme: IconThemeData(color: Color(0xFFF3F4F6)),
    centerTitle: false,
    elevation: 15,
  ),

  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    textStyle: const TextStyle(
        color: Color(0xFF7CA1F3), fontSize: 12, fontWeight: FontWeight.bold),
  )),

  // Buttons
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.red,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFFDC2626)),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  ),

  // Input
  inputDecorationTheme: const InputDecorationTheme(
    border: UnderlineInputBorder(),
  ),

  // Text
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 40,
      color: Color(0xFFF3F4F6),
      height: 1.20,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 32,
      color: Color(0xFFF3F4F6),
      height: 1.25,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 24,
      color: Color(0xFFF3F4F6),
      height: 1.33,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 22,
      color: Color(0xFFF3F4F6),
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      color: Color(0xFFF3F4F6),
      height: 1.33,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      color: Color(0xFFF3F4F6),
      height: 1.375,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      color: Color(0xFFF3F4F6),
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      color: Color(0xFFF3F4F6),
      height: 1.43,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      color: Color(0xFFF3F4F6),
      height: 1.33,
    ),
  ),
);
