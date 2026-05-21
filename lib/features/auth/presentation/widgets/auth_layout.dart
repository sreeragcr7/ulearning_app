import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/core/common/widgets/loader.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.child, this.isLoading = false, this.titleColor, required this.bgImage});

  final Widget child;
  final bool isLoading;
  final Color? titleColor;
  final String bgImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(child: Image.asset(bgImage, fit: BoxFit.cover)),

          Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.10))),

          /// Bottom Form Container
          AnimatedPadding(
            duration: const Duration(milliseconds: 250),

            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

            child: Align(
              alignment: Alignment.bottomCenter,

              child: Container(
                width: double.infinity,

                padding: EdgeInsets.only(left: 24.w, right: 24.w),

                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withAlpha(240),

                  borderRadius: BorderRadius.only(topLeft: Radius.circular(35.r), topRight: Radius.circular(35.r)),
                ),

                child: SafeArea(
                  top: false,

                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// DRAG INDICATOR

                        /// PAGE CONTENT
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// Loader
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black45,
                child: const Center(child: Loader()),
              ),
            ),
        ],
      ),
    );
  }
}
