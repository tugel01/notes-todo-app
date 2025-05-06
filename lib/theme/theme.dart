import 'package:flutter/material.dart';

// light mode
ThemeData lightMode = ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.grey.shade500,
    selectionHandleColor: Colors.grey.shade400,
    cursorColor: Colors.grey.shade800,
  ),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
);

// dark mode
ThemeData darkMode = ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.grey.shade500,
    selectionHandleColor: Colors.grey.shade400,
    cursorColor: Colors.grey.shade300,
  ),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 25, 25, 25),
    primary: const Color.fromARGB(255, 40, 40, 40),
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade300,
  ),
);
