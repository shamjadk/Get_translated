import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryInLight = Colors.blueGrey.shade800;
  static Color primaryInDark = const Color.fromARGB(255, 201, 201, 201);
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shadowColor: Colors.black,
        elevation: 4,
        backgroundColor: AppTheme.primaryInLight,
        foregroundColor: Colors.white),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppTheme.primaryInLight),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.grey, fontSize: 16),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shadowColor: Colors.black,
        elevation: 4,
        backgroundColor: const Color.fromARGB(255, 222, 222, 222),
        foregroundColor: Colors.black),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppTheme.primaryInDark),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.grey, fontSize: 16),
  ),
);
