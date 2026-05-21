import 'package:flutter/material.dart';
import 'app_pallet.dart';

class AppInputTheme {
  AppInputTheme._();

  static final lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withValues(alpha: 0.9),

    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppPallet.primary, width: 2),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppPallet.error, width: 1.5),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppPallet.error, width: 2),
    ),

    hintStyle: const TextStyle(color: AppPallet.primary, fontSize: 14),

    labelStyle: const TextStyle(color: AppPallet.primary, fontWeight: FontWeight.w500),
  );

  static final darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2A2A2A),

    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppPallet.primary, width: 2),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppPallet.error, width: 1.5),
    ),

    hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14),

    labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontWeight: FontWeight.w500),
  );
}
