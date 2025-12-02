import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // --- Light Theme ---
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppPalette.primaryBlue,
      scaffoldBackgroundColor: AppPalette.backgroundLight,

      // Material 3
      colorScheme: const ColorScheme.light(
        primary: AppPalette.primaryBlue,
        secondary: AppPalette.primaryBlueDark,
        surface: AppPalette.surfaceLight,
        error: AppPalette.expenseRed,
        onSurface: AppPalette.textMainLight,
      ),

      // Typography
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: AppPalette.textMainLight,
        displayColor: AppPalette.textMainLight,
      ),

      // Extension
      extensions: const [
        AppColorsExtension(
          income: AppPalette.incomeGreen,
          expense: AppPalette.expenseRed,
          surfaceSubtle: Color(0xFFE5E7EB), // Borders/inputs
        ),
      ],

      // Inputs - Atomic
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFE0F2FE).withAlpha(204),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppPalette.primaryBlue,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Buttons - Atomic
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // --- Dark Theme ---
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppPalette.primaryBlue,
      scaffoldBackgroundColor: AppPalette.backgroundDark,

      colorScheme: const ColorScheme.dark(
        primary: AppPalette.primaryBlue,
        secondary: AppPalette.primaryBlueDark,
        surface: AppPalette.surfaceDark,
        error: AppPalette.expenseRed,
        onSurface: AppPalette.textMainDark,
      ),

      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppPalette.textMainDark,
        displayColor: AppPalette.textMainDark,
      ),

      extensions: const [
        AppColorsExtension(
          income: AppPalette.incomeGreen,
          expense: AppPalette.expenseRed,
          surfaceSubtle: Color(0xFF374151),
        ),
      ],

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppPalette.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppPalette.primaryBlue,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primaryBlue,
          foregroundColor: Colors.white,
          iconColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
