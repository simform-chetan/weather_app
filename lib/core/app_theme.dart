import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    colorScheme: _lightColorScheme,
    fontFamily: AppConstants.appFontFamily,
    textTheme: _textTheme,
  );

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.colorffffff,
    onPrimary: AppColors.colorffffff,
    secondary: AppColors.colorffffff,
    onSecondary: AppColors.colorffffff,
    error: AppColors.colorffffff,
    onError: AppColors.colorffffff,
    background: AppColors.colorffffff,
    onBackground: AppColors.colorffffff,
    surface: AppColors.colorffffff,
    onSurface: AppColors.colorffffff,
  );

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      fontSize: 57,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 45,
      height: 1.15,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 36,
      height: 1.22,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      height: 1.28,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 1.33,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 22,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.1,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.42,
      letterSpacing: 0.1,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.42,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 1.45,
      letterSpacing: 0.5,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.42,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
    ),
  );
}
