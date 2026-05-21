import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ulearning_app/core/common/widgets/common_button.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';
import 'package:ulearning_app/core/utils/constants/sizes.dart';
import 'package:ulearning_app/core/utils/snack_bar.dart';
import 'package:ulearning_app/core/utils/validators.dart';
import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulearning_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:ulearning_app/features/auth/presentation/widgets/auth_layout.dart';
import 'package:ulearning_app/features/auth/presentation/widgets/auth_switch_text.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPwdController.dispose();
    super.dispose();
  }

  void _signup() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      SignUpEvent(
        email: emailController.text.trim(),
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,

      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            snackBar(context, state.message);
          }

          if (state is AuthEmailVerificationPending) {
            snackBar(context, 'Verification email sent to ${state.email}');

            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
          }

          if (state is AuthAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (route) => false);
          }
        },

        builder: (context, state) {
          return AuthLayout(
            bgImage: 'assets/images/signupbg.png',
            isLoading: state is AuthLoading,
            titleColor: Colors.white,

            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// TITLE
                  Text('Sign Up', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurface)),

                  SizedBox(height: TSizes.btwSection),

                  /// SUBTITLE
                  Text(
                    'Create your account and start learning today',

                    textAlign: TextAlign.center,

                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),

                  SizedBox(height: TSizes.btwSection),

                  /// FORM
                  Column(
                    children: [
                      /// USERNAME
                      TAuthField(
                        controller: usernameController,

                        validator: (value) => AppValidators.required(value, 'Username'),

                        hintText: 'Enter username',
                        labelText: 'Username',

                        prefixIcon: Iconsax.user,
                        prefixIconFilled: Iconsax.user5,
                      ),

                      SizedBox(height: TSizes.btwItems),

                      /// EMAIL
                      TAuthField(
                        controller: emailController,

                        validator: AppValidators.validateEmail,

                        hintText: 'Enter email',
                        labelText: 'Email',

                        prefixIcon: Iconsax.sms,
                        prefixIconFilled: Iconsax.sms5,
                      ),

                      SizedBox(height: TSizes.btwItems),

                      /// PASSWORD
                      TAuthField(
                        controller: passwordController,
                        isPassword: true,

                        onChanged: (_) => _formKey.currentState?.validate(),

                        validator: AppValidators.validatePassword,

                        hintText: 'Enter password',
                        labelText: 'Password',

                        prefixIcon: Iconsax.password_check,
                        prefixIconFilled: Iconsax.password_check5,
                      ),

                      SizedBox(height: TSizes.btwItems),

                      /// CONFIRM PASSWORD
                      TAuthField(
                        controller: confirmPwdController,
                        isPassword: true,

                        onChanged: (_) => _formKey.currentState?.validate(),

                        validator: (value) => AppValidators.confirmPassword(value, passwordController.text),

                        hintText: 'Confirm password',
                        labelText: 'Confirm Password',

                        prefixIcon: Iconsax.check,
                        prefixIconFilled: Iconsax.tick_circle5,
                      ),

                      SizedBox(height: TSizes.btwSection),

                      /// SIGN UP BUTTON
                      CommonBtn(
                        btn: 'Sign Up',

                        onPressed: _signup
                      ),

                      SizedBox(height: TSizes.btwSection - 15),

                      /// SWITCH AUTH
                      AuthSwitchText(
                        title: 'Already have an account?',

                        buttonText: 'Log In',

                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                        },
                      ),

                      SizedBox(height: TSizes.btwItems),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
