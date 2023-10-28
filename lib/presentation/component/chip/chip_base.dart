import 'package:flutter/material.dart';

import 'package:safa_app/gen/colors.gen.dart';

class ChipBase extends StatelessWidget {
  const ChipBase({
    required this.labelText,
    this.backgroundColor = AppColor.primaryGreenBg,
    this.labelTextStyle,
    super.key,
  });

  final String labelText;
  final Color backgroundColor;

  final TextStyle? labelTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        labelText,
        style: labelTextStyle ??
            Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.black,
                  fontWeight: FontWeight.normal,
                ),
      ),
    );
  }
}
