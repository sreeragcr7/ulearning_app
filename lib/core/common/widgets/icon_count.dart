import 'package:flutter/material.dart';

class IconCount extends StatelessWidget {
  const IconCount({super.key, required this.icon, required this.count, this.size = 12, this.color, this.fontSize = 12});

  final IconData icon;
  final String count;
  final double? size;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: size, color: color),
        const SizedBox(width: 3),
        Text(
          count,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
