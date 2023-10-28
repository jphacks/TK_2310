import 'package:flutter/material.dart';

import 'package:safa_app/gen/colors.gen.dart';

class CardBase extends StatelessWidget {
  const CardBase({
    required this.child,
    this.outsidePadding = const EdgeInsets.all(16),
    this.backgroundColor = AppColor.primaryGreenBg,
    super.key,
  });

  final EdgeInsetsGeometry outsidePadding;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outsidePadding,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: backgroundColor,
        ),
        child: child,
      ),
    );
  }
}
