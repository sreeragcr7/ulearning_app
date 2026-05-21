import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';
import 'package:ulearning_app/core/common/widgets/loader.dart';
import 'package:ulearning_app/core/common/widgets/t_app_bar.dart';
import 'package:ulearning_app/core/utils/constants/sizes.dart';
import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulearning_app/features/profile/presentation/widgets/profile_chips.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list_view.dart';
import 'package:ulearning_app/features/profile/presentation/widgets/profile_list_items.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(icon: Icons.more_vert_outlined, title: 'Profile'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding, vertical: TSizes.screenTop),
            child: BlocBuilder<AppUserCubit, AppUserState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader(); // ✅ return added
                }

                if (state is AppUserAuthenticated) {
                  final user = state.user;

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/icons/headpic.png')),
                      ),
                      const SizedBox(height: 12),
                      Text(user.username, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 20),
                      const ProfileChips(),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          Expanded(child: GradientListView(items: profileItems)),
        ],
      ),
    );
  }
}
