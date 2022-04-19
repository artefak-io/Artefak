import 'package:flutter/material.dart';

const _primaryColor = Color(0xFF333333);

ThemeData lightTheme = ThemeData(
  primaryColor: _primaryColor,
  // combo color with shadowColor
  backgroundColor: const Color(0xFF434343),
  // combo color with backgroundColor
  shadowColor: const Color(0xFF000000),
  highlightColor: const Color(0xDA333333),

  // App Bar
  appBarTheme: const AppBarTheme(
    backgroundColor: _primaryColor,
    // This will be applied to the "back" icon
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: false,
    elevation: 15,
  ),

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
    bodySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      color: Color(0xFF9CA3AF),
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 22,
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 40,
      color: Colors.white
    ),
  ),
);
