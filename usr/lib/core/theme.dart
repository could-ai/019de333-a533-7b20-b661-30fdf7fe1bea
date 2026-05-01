import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF58CC02);
  static const Color primaryShadow = Color(0xFF58A700);
  static const Color secondary = Color(0xFF1CB0F6);
  static const Color secondaryShadow = Color(0xFF1899D6);
  static const Color danger = Color(0xFFFF4B4B);
  static const Color dangerShadow = Color(0xFFEA1538);
  static const Color warning = Color(0xFFFFC800);
  static const Color warningShadow = Color(0xFFD3A300);
  static const Color background = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF3C3C3C);
  static const Color textMuted = Color(0xFFAFAFAF);
  static const Color surface = Color(0xFFF7F7F7);
  static const Color border = Color(0xFFE5E5E5);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Nunito', // If available, otherwise falls back
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.danger,
        surface: AppColors.surface,
        background: AppColors.background,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
        onSurface: AppColors.textMain,
        onBackground: AppColors.textMain,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textMain),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textMain),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textMain),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textMain),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textMain),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textMain),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textMuted),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textMuted),
        titleTextStyle: TextStyle(
          color: AppColors.textMuted,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
