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
  });

  final EdgeInsetsGeometry? outsidePadding;
  final bool isWidly;
  final String labelText;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButtonBase(
      outsidePadding: outsidePadding,
      isWidly: isWidly,
      onPressed: onPressed,
      child: Text(
        labelText,
        style: boldNotoSansTextStyle(16, color: AppColor.white),
      ),
    );
  }
}
