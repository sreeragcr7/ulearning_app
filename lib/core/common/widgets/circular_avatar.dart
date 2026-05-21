import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  const CircularAvatar({super.key, required this.isLoading, this.imageAsset, this.imageUrl, required this.radius});

  final bool isLoading;
  final String? imageAsset;
  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
