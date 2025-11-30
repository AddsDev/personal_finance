import 'package:flutter/material.dart';

abstract class AppPalette {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryBlueDark = Color(0xFF2563EB);

  // Semantic Colors
  static const Color expenseRed = Color(0xFFEF4444);
  static const Color incomeGreen = Color(0xFF10B981);

  // Neutral Colors Light
  static const Color backgroundLight = Color(0xFFF3F4F6);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textMainLight = Color(0xFF1F2937);
  static const Color textSubLight = Color(0xFF6B7280);

  // Neutral Colors Dark
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color textMainDark = Color(0xFFF9FAFB);
  static const Color textSubDark = Color(0xFF9CA3AF);
}

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color income;
  final Color expense;
  final Color surfaceSubtle;

  const AppColorsExtension({
    required this.income,
    required this.expense,
    required this.surfaceSubtle,
  });

  @override
  AppColorsExtension copyWith({
    Color? income,
    Color? expense,
    Color? surfaceSubtle,
  }) {
    return AppColorsExtension(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      surfaceSubtle: Color.lerp(surfaceSubtle, other.surfaceSubtle, t)!,
    );
  }
}
