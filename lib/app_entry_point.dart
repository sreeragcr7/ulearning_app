import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';
import 'package:ulearning_app/core/common/widgets/loader.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';
import 'package:ulearning_app/core/utils/local_storage.dart';
import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulearning_app/features/auth/presentation/pages/login_page.dart';
import 'package:ulearning_app/features/navigation/presentation/pages/main_page.dart';
import 'package:ulearning_app/features/onboarding/pages/welcome.dart';
import 'package:ulearning_app/init_dependencies.dart';

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingDone = getIt<LocalStorages>().isOnboardingDone();

    if (!onBoardingDone) {
      return const Welcome();
    }
    return BlocConsumer<AuthBloc, AuthBlocState>(
      listener: (context, authState) {
        if (authState is AuthLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
        }
      },

      builder: (context, authState) {
        /// While checking persisted Supabase session
        if (authState is AuthCheckingSession) {
          return const Scaffold(body: Center(child: Loader()));
        }

        return BlocBuilder<AppUserCubit, AppUserState>(
          builder: (context, userState) {
            /// USER LOGGED IN
            if (userState is AppUserAuthenticated) {
              return const MainPage();
            }

            /// USER NOT LOGGED IN
            return const LoginPage();
          },
        );
      },
    );
  }
}
