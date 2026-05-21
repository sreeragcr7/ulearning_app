import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ulearning_app/core/theme/app_pallet.dart';

class TDotIndicator extends StatelessWidget {
  const TDotIndicator({super.key, required this.dotCount, required this.activeIndex});
  final int dotCount;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: dotCount,
      position: activeIndex.toDouble(),
      mainAxisAlignment: MainAxisAlignment.center,
      decorator: DotsDecorator(
        color: Colors.grey,
        activeColor: AppPallet.primary,
        size: Size.square(8.0),
        activeSize: const Size(18.1, 6.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
