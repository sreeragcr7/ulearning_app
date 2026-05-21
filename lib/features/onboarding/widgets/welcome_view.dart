import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/core/common/widgets/app_button_styles.dart';
import 'package:ulearning_app/core/common/widgets/dot_indicator.dart';
import 'package:ulearning_app/core/theme/app_pallet.dart';
import 'package:ulearning_app/features/onboarding/cubit/on_boarding_cubit.dart';
import 'package:ulearning_app/features/onboarding/widgets/card_content.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        margin: EdgeInsets.only(top: 34.h),
        width: 375.w,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CardContent(pageController: _pageController),
            BlocBuilder<OnBoardingCubit, int>(
              builder: (context, currentIndex) {
                if (currentIndex < 2) {
                  return Positioned(
                    top: 0,
                    right: 16.w,
                    child: TextButton(
                      style: AppButtonStyles.skipButtonStyle,
                      onPressed: () {
                        _pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        context.read<OnBoardingCubit>().pageChanged(2);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(fontSize: 16.sp, color: AppPallet.primary),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            BlocBuilder<OnBoardingCubit, int>(
              builder: (context, index) {
                return Positioned(
                  bottom: 255.h,
                  child: TDotIndicator(dotCount: 3, activeIndex: index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
