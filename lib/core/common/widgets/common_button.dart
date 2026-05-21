import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBtn extends StatelessWidget {
  const CommonBtn({super.key, required this.btn, required this.onPressed, this.margin});

  final String btn;
  final VoidCallback onPressed;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: 325.w,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r))),
        ),
        child: Text(
          btn,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: Colors.white),
        ),
      ),
    );
  }
}
