import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/common/widgets/confirm_dialog.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_chip.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';
import 'package:ulearning_app/core/utils/constants/sizes.dart';
import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulearning_app/features/navigation/presentation/bloc/nav_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Settings'), centerTitle: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.screenPadding),
            child: Column(
              children: [
                Center(
                  child: GradientChip(
                    styleType: ChipStyleType.outlinedGradient,
                    text: 'Logout',
                    icon: Icons.logout_rounded,
                    borderRadius: 10,
                    height: 50,
                    width: 150,
                    onTap: () async {
                      final authBloc = context.read<AuthBloc>();
                      final navBloc = context.read<NavBloc>();
                      final confirm = await showConfirmDialog(
                        context: context,
                        title: 'Logout',
                        content: 'Are you sure you want to logout?',
                        confirmText: 'Logout',
                      );
                      if (!mounted) return;
                      if (confirm == true) {
                        navBloc.add(NavTabChangedEvent(0));
                        authBloc.add(LogoutEvent());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
