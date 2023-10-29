import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:safa_app/presentation/component/button/filled_text_button.dart';
import 'package:safa_app/presentation/component/text_field/text_field_base.dart';

Future<void> searchModalBottomSheet(
  BuildContext context, {
  required String title,
  required String hintText,
  required VoidCallback onPressed,
  required TextEditingController controller,
  String? buttonText,
}) async {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 250,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const Gap(32),
              TextFieldBase(
                labelText: hintText,
                controller: controller,
              ),
              const Gap(16),
              FilledTextButton(
                height: 40,
                labelText: buttonText ?? '決定',
                isWidly: true,
                labelTextStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
                onPressed: onPressed,
              ),
              const Gap(32),
            ],
          ),
        ),
      );
    },
  );
}
