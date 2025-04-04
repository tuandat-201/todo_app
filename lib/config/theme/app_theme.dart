import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 109, 192, 213),
    brightness: Brightness.light,
  );

  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    textTheme: GoogleFonts.nunitoTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
      ),
    ),
  );
}
