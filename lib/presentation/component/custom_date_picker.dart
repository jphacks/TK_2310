import 'package:flutter/material.dart';

import 'package:safa_app/gen/colors.gen.dart';

Future<DateTime> customDatePicker(BuildContext context) async {
  final now = DateTime.now();
  final initialDate = DateTime(now.year, now.month, now.day);
  final firstDate = DateTime(now.year, now.month, now.day);
  final lastDate = DateTime(now.year + 1, now.month, now.day);

  final result = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: AppColor.primaryGreen,
          ),
        ),
        child: child!,
      );
    },
  );
  if (result == null) {
    return initialDate;
  }

  return result;
}
