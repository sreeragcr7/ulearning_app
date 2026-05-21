import 'package:flutter/material.dart';

class GradientIconBox extends StatelessWidget {
  const GradientIconBox({super.key, required this.icon, this.height = 42, this.width = 42, this.iconSize = 22});

  final IconData icon;
  final double? height;
  final double? width;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)]),
      ),
      child: Icon(icon, size: iconSize, color: Colors.white),
    );
  }
}
