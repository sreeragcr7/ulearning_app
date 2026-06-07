// private constructor (no instance)

import 'package:flutter/material.dart';

class AppPallet {
  AppPallet._();

  // 🎨 Primary Fun Colors
  static const Color primary = Color(0xFF6C5CE7); 
  static const Color secondary = Color(0xFFFFB703); 
  static const Color accent = Color(0xFF00C896); 

  // 🌈 Background
  static const Color background = Color(0xFFF4F6FF);
  static const Color surface = Colors.white;

  // 🖤 Text
  static const Color textPrimary = Color(0xFF2D2D2D);
  static const Color textSecondary = Color(0xFF7A7A7A);

  // 🌟 Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFFFB703);
  static const Color error = Color(0xFFFF5A5F);

  static const Color shadow = Color(0x14000000);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
  );

  static const LinearGradient authOverlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(40, 0, 0, 0), Color.fromARGB(180, 0, 0, 0)],
  );
}
