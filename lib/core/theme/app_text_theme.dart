import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static const lightTextTheme = TextTheme(
    /// Headlines
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),

    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),

    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),

    /// Titles
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),

    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),

    /// Body
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),

    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),

    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),

    /// Labels
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );

  static const darkTextTheme = TextTheme(
    /// Usually same typography
    /// only colors change automatically
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),

    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),

    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),

    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),

    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),

    bodyLarge: TextStyle(fontSize: 16),

    bodyMedium: TextStyle(fontSize: 14),

    bodySmall: TextStyle(fontSize: 12),

    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );
}
