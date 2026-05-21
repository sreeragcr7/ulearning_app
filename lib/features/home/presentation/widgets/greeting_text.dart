import 'package:flutter/material.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hello,', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color.onSurfaceVariant)),

        ShaderMask(
          shaderCallback: (bounds) =>
              const LinearGradient(colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)]).createShader(bounds),
          child: Text(
            userName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white, // IMPORTANT for shader
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
