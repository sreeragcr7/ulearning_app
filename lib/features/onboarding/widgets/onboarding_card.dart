import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/core/common/widgets/common_button.dart';

class OnboardingCard extends StatelessWidget {
  const OnboardingCard({
    super.key,
    required this.image,
    required this.subTitle,
    required this.title,
    required this.btn,
    required this.index,
    required this.pageController,
    this.onLastButtonPressed,
  });

  final String image;
  final String title;
  final String subTitle;
  final String btn;
  final int index;
  final PageController pageController;
  final VoidCallback? onLastButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: 345.w,
            height: 345.w,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.w),
          child: Text(
            subTitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),

        CommonBtn(
          margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
          btn: btn,
          onPressed: () {
            if (index < 2) {
              // 0,1 → not last
              pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
            } else {
              // last page (index == 2)
              if (onLastButtonPressed != null) {
                onLastButtonPressed!();
              }
            }
          },
        ),
      ],
    );
  }
}
