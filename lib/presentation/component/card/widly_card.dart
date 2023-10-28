import 'package:flutter/material.dart';

import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/component/card/card_base.dart';

class WidlyCard extends StatelessWidget {
  const WidlyCard({
    required this.child,
    super.key,
    this.backgroundColor = AppColor.primaryGreenBg,
    this.outsidePadding = const EdgeInsets.all(16),
  });

  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry outsidePadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CardBase(
        outsidePadding: outsidePadding,
        backgroundColor: backgroundColor,
        child: child,
      ),
    );
  }
}
