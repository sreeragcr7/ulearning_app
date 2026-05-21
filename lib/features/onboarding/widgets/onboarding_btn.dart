import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/core/theme/app_pallet.dart';

class OnboardingBtn extends StatelessWidget {
  const OnboardingBtn({super.key, required this.btn, required this.onPressed});
  final String btn;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
      return Container(
      margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
      width: 325.w,
      height: 50.h,
      child: Material(
        color: AppPallet.primary,
        borderRadius: BorderRadius.circular(25.w),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.w),
          hoverColor: Colors.white.withAlpha(20),
          splashColor: Colors.white.withAlpha(40),
          onTap: onPressed,
          child: Center(
            child: Text(
              btn,
              style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
