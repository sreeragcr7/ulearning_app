import 'package:flutter/material.dart';
import 'app_pallet.dart';

class AppColorScheme {

  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppPallet.primary,
    brightness: Brightness.light,

    surface: Colors.white,
    onSurface: AppPallet.textPrimary,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppPallet.primary,
    brightness: Brightness.dark,

    surface: const Color(0xFF1E1E1E),
    onSurface: Colors.white,
  );
}
