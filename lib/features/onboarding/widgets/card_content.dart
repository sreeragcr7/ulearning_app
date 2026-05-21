import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';
import 'package:ulearning_app/core/utils/local_storage.dart';
import 'package:ulearning_app/features/onboarding/cubit/on_boarding_cubit.dart';
import 'package:ulearning_app/features/onboarding/widgets/onboarding_card.dart';
import 'package:ulearning_app/init_dependencies.dart';

class CardContent extends StatelessWidget {
  const CardContent({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return PageView(
      controller: pageController,
      onPageChanged: (index) => cubit.pageChanged(index),
      children: [
        OnboardingCard(
          index: 0,
          image: 'assets/images/reading.png',
          title: 'First See Learning',
          subTitle: 'Forget about a for of paper all knowledge in one learning!',
          btn: 'Next',
          pageController: pageController,
          onLastButtonPressed: null,
        ),
        OnboardingCard(
          index: 1,
          image: 'assets/images/boy.png',
          title: 'Connect With Everyone',
          subTitle: 'Always keep in touch with your tutor & friends. let\'s get connected!.',
          btn: 'Next',
          pageController: pageController,
          onLastButtonPressed: null,
        ),
        OnboardingCard(
          index: 2,
          image: 'assets/images/man.png',
          title: 'Always Fascinated Learning',
          subTitle: 'Anywhere, anytime. The time is at your discretion so study whenever you want.',
          btn: 'Get Started',
          pageController: pageController,
          onLastButtonPressed: () async {
            await getIt<LocalStorages>().setOnboardingDone();

            if (!context.mounted) return;

            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
          },
        ),
      ],
    );
  }
}
