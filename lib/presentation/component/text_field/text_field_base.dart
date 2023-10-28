import 'package:flutter/material.dart';

import 'package:safa_app/gen/colors.gen.dart';

class TextFieldBase extends StatelessWidget {
  const TextFieldBase({
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.onTap,
    this.onEditingComplete,
    super.key,
  });

  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryGreenDark),
        ),
        labelText: labelText,
      ),
      controller: controller,
      obscureText: obscureText,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
    );
  }
}
