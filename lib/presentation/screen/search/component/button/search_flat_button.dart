import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:safa_app/gen/colors.gen.dart';

class SearchFlatButton extends StatelessWidget {
  const SearchFlatButton({
    required this.icon,
    required this.onTap,
    required this.selectedText,
    super.key,
    this.isWidly = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String selectedText;
  final bool isWidly;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:
            isWidly ? double.infinity : MediaQuery.sizeOf(context).width * 0.42,
        decoration: BoxDecoration(
          color: AppColor.primaryOrangeBg,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8).copyWith(left: 16),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const Gap(4),
            Text(selectedText, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
