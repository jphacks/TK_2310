import 'package:flutter/material.dart';

import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/component/button/filled_button_base.dart';
import 'package:safa_app/theme.dart';

class FilledTextButton extends StatelessWidget {
  const FilledTextButton({
    required this.labelText,
    required this.onPressed,
    super.key,
    this.isWidly = false,
    this.outsidePadding,
    this.height,
    this.labelTextStyle,
    this.backgroundColor,
  });

  final EdgeInsetsGeometry? outsidePadding;
  final bool isWidly;
  final String labelText;
  final double? height;
  final TextStyle? labelTextStyle;
  final Color? backgroundColor;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButtonBase(
      height: height ?? 50,
      outsidePadding: outsidePadding,
      backgroundColor: backgroundColor,
      isWidly: isWidly,
      onPressed: onPressed,
      child: Text(
        labelText,
        style: labelTextStyle ?? boldNotoSansTextStyle(16, color: AppColor.white),
      ),
    );
  }
}
