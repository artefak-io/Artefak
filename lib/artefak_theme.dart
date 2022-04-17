import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF333333),
    brightness: Brightness.light,
    backgroundColor: const Color(0xFF434343), // combo color with shadowColor
    shadowColor: const Color(0xFF000000), // combo color with backgroundColor
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
        // minimumSize: MaterialStateProperty.all<Size>(Size(350 * 0.9, 54))
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(),
    ),
    textTheme: const TextTheme(
      bodySmall:
          TextStyle(fontFamily: 'Inter', fontSize: 14, color: Colors.white),
      bodyMedium:
          TextStyle(fontFamily: 'Inter', fontSize: 18, color: Colors.white),
      titleLarge:
          TextStyle(fontFamily: 'Inter', fontSize: 40, color: Colors.white),
      labelMedium:
          TextStyle(fontFamily: 'Inter', fontSize: 16, color: Colors.white),
      displaySmall: TextStyle(
          fontFamily: 'Inter', fontSize: 16, color: Color(0xFF9CA3AF)),
      headlineMedium:
          TextStyle(fontFamily: 'Inter', fontSize: 22, color: Colors.white),
    ));
