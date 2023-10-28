import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safa_app/gen/colors.gen.dart';

class AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBase({
    required this.title,
    super.key,
    this.leading,
    this.actions,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  /// kToolbarHeight = 56.0
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      centerTitle: true,
      leading: leading ??
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: AppColor.black,
            ),
          ),
      actions: actions,
    );
  }
}
