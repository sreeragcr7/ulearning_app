import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple.withAlpha(38)),
        child: Lottie.asset(
          'assets/animations/loader.json',
          width: 60,
          height: 60,
          repeat: true,
          frameRate: FrameRate.max,
        ),
      ),
    );
  }
}
