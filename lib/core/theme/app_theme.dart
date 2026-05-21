import 'package:flutter/material.dart';
import 'package:ulearning_app/core/theme/app_input_theme.dart';
import 'app_color_scheme.dart';
import 'app_text_theme.dart';
import 'app_button_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.lightColorScheme,
    scaffoldBackgroundColor: AppColorScheme.lightColorScheme.surface,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppButtonTheme.elevatedButtonTheme,
    textButtonTheme: AppButtonTheme.textButtonTheme,
    inputDecorationTheme: AppInputTheme.lightInputDecorationTheme,
    cardTheme: CardThemeData(elevation: 1, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.darkColorScheme,
    scaffoldBackgroundColor: AppColorScheme.darkColorScheme.surface,
    textTheme: AppTextTheme.darkTextTheme, // reuse for now
    inputDecorationTheme: AppInputTheme.darkInputDecorationTheme,
    cardTheme: CardThemeData(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
  );
}
