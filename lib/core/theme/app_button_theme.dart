import 'package:flutter/material.dart';
import 'app_pallet.dart';

class AppButtonTheme {
  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppPallet.primary,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
 
  static final textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return AppPallet.primary.withAlpha(40);
        }
        return null;
      }),
    ),
  );
}
