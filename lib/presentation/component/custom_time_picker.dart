import 'package:flutter/material.dart';

import 'package:safa_app/gen/colors.gen.dart';

Future<DateTime> customTimePicker(BuildContext context) async {
  final now = DateTime.now();
  final initialTime = TimeOfDay(hour: now.hour, minute: now.minute);

  final result = await showTimePicker(
    context: context,
    initialTime: initialTime,
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
    return DateTime(
      now.year,
      now.month,
      now.day,
      initialTime.hour,
      initialTime.minute,
    );
  }

  return DateTime(now.year, now.month, now.day, result.hour, result.minute);
}
