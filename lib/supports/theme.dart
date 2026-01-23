// Core
import 'package:flutter/material.dart';

// External
import 'package:google_fonts/google_fonts.dart';

const normalPrimary = Color(0xFFDBAB62); // liens / AppBar

final lightColorScheme =
    ColorScheme.fromSeed(
      seedColor: const Color(0xFFDBAB62),
      brightness: Brightness.light,
    ).copyWith(
      primary: const Color(0xFFA97A35), // boutons
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFF6E4CC), // fonds clairs
      secondary: const Color(0xFF50677F),
      onSecondary: Colors.white,
      surface: const Color(0xFFFAF5ED),
    );

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.figtreeTextTheme().copyWith(
    titleLarge: const TextStyle(color: Color(0xFF302A24)),
    titleMedium: const TextStyle(color: Color(0xFF302A24)),
    titleSmall: const TextStyle(color: Color(0xFF302A24)),

    bodyLarge: const TextStyle(color: Color(0xFF302A24)),
    bodyMedium: const TextStyle(color: Color(0xFF302A24)),
    bodySmall: const TextStyle(color: Color(0xFF302A24)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return lightColorScheme.secondary;
        }
        return lightColorScheme.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white70; // texte un peu atténué
        }
        return Colors.white; // texte normal
      }),
    ),
  ),
);

final darkColorScheme =
    ColorScheme.fromSeed(
      seedColor: const Color(0xFFDBAB62),
      brightness: Brightness.light,
    ).copyWith(
      primary: const Color(0xFFA97A35), // boutons
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFF6E4CC), // fonds clairs
      secondary: const Color(0xFF50677F),
      onSecondary: Colors.white,
      surface: const Color(0xFFFAF5ED),
    );

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: GoogleFonts.figtreeTextTheme().copyWith(
    titleLarge: const TextStyle(color: Color(0xFF302A24)),
    titleMedium: const TextStyle(color: Color(0xFF302A24)),
    titleSmall: const TextStyle(color: Color(0xFF302A24)),

    bodyLarge: const TextStyle(color: Color(0xFF302A24)),
    bodyMedium: const TextStyle(color: Color(0xFF302A24)),
    bodySmall: const TextStyle(color: Color(0xFF302A24)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return darkColorScheme.secondary;
        }
        return darkColorScheme.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white70; // texte un peu atténué
        }
        return Colors.white; // texte normal
      }),
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF302A24),
);
