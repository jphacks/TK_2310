import 'package:flutter/material.dart';
import 'package:safa_app/gen/colors.gen.dart';

class FilledButtonBase extends StatelessWidget {
  const FilledButtonBase({
    required this.child,
    required this.onPressed,
    super.key,
    this.outsidePadding,
    this.insidePadding = const EdgeInsets.all(8),
    this.isWidly = false,
    this.height = 50,
    this.backgroundColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? outsidePadding;
  final EdgeInsetsGeometry insidePadding;
  final bool isWidly;
  final double height;
  final Color? backgroundColor;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: outsidePadding,
      width: isWidly ? double.infinity : null,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor ?? AppColor.primaryOrange),
        ),
        child: Padding(
          padding: insidePadding,
          child: child,
        ),
      ),
    );
  }
}
