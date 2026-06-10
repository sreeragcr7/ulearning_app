import 'package:flutter/material.dart';

class GradientList extends StatelessWidget {
  const GradientList({
    super.key,
    required this.title,
    this.onTap,
    this.contentPadding,
    // this.iconSize = 22,
    // this.height = 42,
    // this.width = 42,
    this.titleSize = 17,
    required this.leading,
    this.showTrailing = true,
    this.subTitle,
    this.trailing,
  });

  final Widget leading;
  final bool showTrailing;
  final Object? subTitle;
  final Widget? trailing;
  final String title;
  // final double? iconSize;
  final double? titleSize;
  // final double? height;
  // final double? width;
  final VoidCallback? onTap;

  /// reusable internal padding
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,

        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 7),

          child: Padding(
            padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 24),

            child: Row(
              children: [
                leading,

                // Container(
                //   width: width,
                //   height: height,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     gradient: const LinearGradient(
                //       colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //     ),
                //   ),
                //   child: Icon(icon, size: iconSize, color: Colors.white),
                // ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(fontSize: titleSize, fontWeight: FontWeight.w600),
                      ),

                      if (subTitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subTitle.toString(),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ],
                  ),
                ),

                trailing ?? (onTap != null ? const Icon(Icons.arrow_forward_ios, size: 16) : const SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
