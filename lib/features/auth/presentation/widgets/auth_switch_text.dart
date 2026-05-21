import 'package:flutter/material.dart';
import 'package:ulearning_app/core/theme/app_pallet.dart';

class AuthSwitchText extends StatelessWidget {
  const AuthSwitchText({super.key, required this.title, required this.buttonText, required this.onPressed, this.color});
  final String title;
  final String buttonText;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),

        TextButton(
          onPressed: onPressed,
          child: Text(buttonText, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppPallet.primary)),
        ),
      ],
    );
  }
}
