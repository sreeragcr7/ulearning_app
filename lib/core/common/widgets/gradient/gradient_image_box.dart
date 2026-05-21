import 'package:flutter/material.dart';

class GradientImageBox extends StatelessWidget {
  const GradientImageBox({super.key, required this.imageUrl, this.height = 60, this.width = 60});

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(imageUrl, fit: BoxFit.cover),
    );
  }
}
