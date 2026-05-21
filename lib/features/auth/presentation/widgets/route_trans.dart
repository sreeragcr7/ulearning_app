import 'package:flutter/material.dart';

Route slideRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 550),
    reverseTransitionDuration: const Duration(milliseconds: 500),

    pageBuilder: (context, animation, secondaryAnimation) => page,

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0); // slide from right
      const end = Offset.zero;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOutCubic));

      final slideAnimation = animation.drive(tween);

      return SlideTransition(position: slideAnimation, child: child);
    },
  );
}
