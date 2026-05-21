import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/core/theme/app_pallet.dart';
import 'package:ulearning_app/core/utils/helpers/helper_function.dart';

class ThirdPartyLogin extends StatelessWidget {
  const ThirdPartyLogin({super.key, required this.iconPath, required this.onTap});

  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25.r),
        splashColor: isDark ? Colors.white : Colors.white.withAlpha(20),
        highlightColor: isDark ? Colors.white.withAlpha(20) : Theme.of(context).colorScheme.surface,
        child: Ink(
          height: 55.h,
          width: 55.h,
          decoration: BoxDecoration(
            gradient: isDark ? AppPallet.primaryGradient : AppPallet.primaryGradient,

            borderRadius: BorderRadius.circular(25.r),

            border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1),
          ),
          child: Padding(padding: EdgeInsets.all(14.w), child: Image.asset(iconPath)),
        ),
      ),
    );
  }
}
