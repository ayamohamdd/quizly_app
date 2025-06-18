import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF617AFA);

  static const Color onPrimary = Color.fromARGB(255, 200, 209, 252);

  // Surface colors
  static const Color surface = Color(0xffffffff);
  static const Color surfaceVariant = Color.fromARGB(255, 245, 248, 249);
  static const Color surfaceBlurred = Color.fromARGB(115, 241, 244, 255);
  static const Color backgroundbluredColor = Color.fromARGB(231, 255, 255, 255);

  // Text colors
  static const Color onSurface = Color(0xff000000);
  static const Color onSurfaceVariant = Color.fromARGB(255, 150, 153, 164);
  static const Color onSurfaceDisabled = Color.fromARGB(255, 203, 207, 216);

  // Secondary colors
  static const Color secondary = Color(0xFF617AFA);
  static const Color onSecondary = AppColors.surface;

  // Tertiary colors
  static const Color tertiary = Color(0xFF617AFA);
  static const Color onTertiary = AppColors.surface;

  // Error colors
  static const Color error = Color(0xFFB3261E);
  static const Color onError = AppColors.surface;
}
