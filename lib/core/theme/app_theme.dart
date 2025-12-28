import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // Scaffold & background
    scaffoldBackgroundColor: AppColors.background,

    // Color scheme (Material 3)
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.reward,
      surface: AppColors.surface,
      background: AppColors.background,
      error: Colors.redAccent,
      onPrimary: Colors.white,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onBackground: AppColors.textPrimary,
      onError: Colors.white,
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
    ),

    // Text theme (kid-friendly)
    // Note: Kalpurush font is used for Bangla text via fontFamily property
    // textTheme: const TextTheme(
    //   headlineLarge: TextStyle(
    //     fontSize: 26,
    //     fontWeight: FontWeight.w700,
    //     color: AppColors.textPrimary,
    //     height: 1.3,
    //   ),
    //   headlineMedium: TextStyle(
    //     fontSize: 22,
    //     fontWeight: FontWeight.w600,
    //     color: AppColors.textPrimary,
    //     height: 1.3,
    //   ),
    //   bodyLarge: TextStyle(
    //     fontSize: 18,
    //     fontWeight: FontWeight.w500,
    //     color: AppColors.textPrimary,
    //     height: 1.5,
    //   ),
    //   bodyMedium: TextStyle(
    //     fontSize: 16,
    //     color: AppColors.textSecondary,
    //     height: 1.5,
    //   ),
    // ),

    // Elevated buttons (main action)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.action,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Cards (surface usage)
    cardTheme: CardTheme(
      color: AppColors.surface,
      elevation: 3,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(8),
    ),

    // Progress indicators
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.success,
      linearTrackColor: AppColors.border,
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
    ),

    // Input fields (if needed later)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),

  );
}
