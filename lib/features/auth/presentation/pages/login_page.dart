import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:ulearning_app/features/auth/presentation/widgets/third_party_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            snackBar(context, state.message);
          }

        },
        builder: (context, state) {
          return AuthLayout(
            bgImage: 'assets/images/loginbg.png',

            titleColor: Colors.white,
            isLoading: state is AuthLoading,

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Log In',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(height: TSizes.btwSection),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ThirdPartyLogin(iconPath: 'assets/icons/google.png', onTap: () {}),
                      SizedBox(width: 30.w),
                      ThirdPartyLogin(iconPath: 'assets/icons/apple.png', onTap: () {}),
                      SizedBox(width: 30.w),
                      ThirdPartyLogin(iconPath: 'assets/icons/facebook.png', onTap: () {}),
                    ],
                  ),

                  SizedBox(height: TSizes.btwSection - 5),

                  Text(
                    'Or use your email account login',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),

                  SizedBox(height: TSizes.btwSection),

                  Column(
                    children: [
                      TAuthField(
                        validator: AppValidators.validateEmail,
                        controller: emailController,
                        hintText: 'Eg: abc@gmail.com',
                        labelText: 'Email',
                        prefixIcon: Iconsax.sms,
                        prefixIconFilled: Iconsax.sms5,
                      ),

                      SizedBox(height: TSizes.btwItems),

                      TAuthField(
                        validator: AppValidators.validatePassword,
                        controller: passwordController,
                        hintText: 'Enter password',
                        labelText: 'Password',
                        prefixIcon: Iconsax.password_check,
                        prefixIconFilled: Iconsax.password_check5,
                        isPassword: true,
                      ),

                      SizedBox(height: TSizes.btwSection),

                      CommonBtn(
                        btn: 'Log In',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authBloc.add(
                              LogInEvent(email: emailController.text.trim(), password: passwordController.text.trim()),
                            );
                          }
                        },
                      ),

                      SizedBox(height: TSizes.btwSection - 15),

                      AuthSwitchText(
                        title: 'Dont have an account?',
                        buttonText: 'Sign Up',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AppRoutes.signup);
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
