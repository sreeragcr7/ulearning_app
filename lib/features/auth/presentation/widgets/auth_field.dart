import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class TAuthField extends StatefulWidget {
  const TAuthField({
    super.key,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.prefixIconFilled,
    this.onChanged,
    this.isPassword = false,
    required this.hintText,
    required this.labelText,
  });

  final bool isPassword;
  final String hintText;
  final String labelText;
  final IconData? prefixIcon;
  final IconData? prefixIconFilled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<TAuthField> createState() => _TAuthFieldState();
}

class _TAuthFieldState extends State<TAuthField> {
  bool _obscureText = true;
  bool _isFocused = false;

  late final FocusNode _focusNode = FocusNode()
    ..addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      obscureText: widget.isPassword ? _obscureText : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,

        /// Prefix Icon
        prefixIcon: widget.prefixIcon != null
            ? AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  _isFocused && widget.prefixIconFilled != null ? widget.prefixIconFilled : widget.prefixIcon,
                  key: ValueKey(_isFocused),
                  size: 20.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : null,

        /// Password Toggle
        suffixIcon: widget.isPassword
            ? Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Iconsax.eye_slash5 : Iconsax.eye4,
                    size: 20.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
