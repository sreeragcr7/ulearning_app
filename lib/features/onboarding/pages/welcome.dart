import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ulearning_app/features/onboarding/cubit/on_boarding_cubit.dart';
import 'package:ulearning_app/features/onboarding/widgets/welcome_view.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => OnBoardingCubit(), child: const WelcomeView());
  }
}
