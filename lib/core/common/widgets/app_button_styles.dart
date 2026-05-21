import 'package:flutter/material.dart';
import 'package:ulearning_app/core/theme/app_pallet.dart';

class AppButtonStyles {
  static final authTextButtonStyle = ButtonStyle(
    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
    minimumSize: WidgetStateProperty.all(const Size(30, 30)),
    foregroundColor: WidgetStateProperty.all(AppPallet.textSecondary),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
  );

  static ButtonStyle skipButtonStyle = ButtonStyle(
    padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
    shape: WidgetStateProperty.all(const CircleBorder()),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.hovered)) {
        return AppPallet.primary.withAlpha(20);
      }
      if (states.contains(WidgetState.pressed)) {
        return AppPallet.primary.withAlpha(40);
      }
      return null;
    }),
  );
}
