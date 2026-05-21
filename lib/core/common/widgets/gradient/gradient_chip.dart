import 'package:flutter/material.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';

class GradientChip extends StatelessWidget {
  const GradientChip({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.height = 50,
    this.width,
    this.layout = ChipLayout.horizontal,
    this.borderRadius = 20,
    this.fontSize = 16,
    this.iconSize = 20,
    this.styleType = ChipStyleType.filled,
    this.padding,
    this.backgroundColor,
  });

  final String text;
  final IconData? icon;
  final double? height;
  final double? width;
  final double fontSize;
  final double iconSize;
  final double borderRadius;
  final VoidCallback? onTap;
  final ChipLayout layout;
  final ChipStyleType styleType;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isVertical = layout == ChipLayout.vertical;
    final radius = BorderRadius.circular(borderRadius);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final adaptiveColor = isDark ? Colors.white : Colors.black;

    return styleType == ChipStyleType.outlinedGradient
        ? _buildOutlined(context, isVertical, radius, adaptiveColor)
        : Material(
            color: Colors.transparent,
            borderRadius: radius,
            child: InkWell(borderRadius: radius, onTap: onTap, child: _buildFilled(context, isVertical, radius)),
          );
  }

  Widget _buildFilled(BuildContext context, bool isVertical, BorderRadius radius) {
    return Ink(
      height: height ?? (isVertical ? 90 : 50),
      width: width ?? (isVertical ? 90 : double.infinity),
      padding: padding ?? EdgeInsets.symmetric(horizontal: isVertical ? 10 : 20, vertical: isVertical ? 10 : 0),
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: const LinearGradient(
          colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: _content(isVertical: isVertical, textColor: Colors.white, iconColor: Colors.white),
    );
  }

  Widget _buildOutlined(BuildContext context, bool isVertical, BorderRadius radius, Color adaptiveColor) {
    final surface = backgroundColor ?? Theme.of(context).colorScheme.surface;

    return Ink(
      height: height ?? (isVertical ? 90 : 50),
      width: width ,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: const LinearGradient(
          colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: surface,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          splashColor: adaptiveColor.withAlpha(25),
          highlightColor: adaptiveColor.withAlpha(13),
          onTap: onTap,
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: isVertical ? 10 : 20, vertical: isVertical ? 10 : 0),
            child: _content(isVertical: isVertical, textColor: adaptiveColor, iconColor: adaptiveColor),
          ),
        ),
      ),
    );
  }

  Widget _content({required bool isVertical, required Color textColor, required Color iconColor}) {
    final hasIcon = icon != null;
    if (isVertical) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasIcon) ...[Icon(icon, color: iconColor, size: iconSize), const SizedBox(height: 10)],
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hasIcon) ...[Icon(icon, color: iconColor, size: iconSize), const SizedBox(width: 10)],
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ),
      ],
    );
  }
}
