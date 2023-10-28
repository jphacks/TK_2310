import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:safa_app/gen/assets.gen.dart';
import 'package:safa_app/gen/colors.gen.dart';

class TrashActivityContributionCard extends HookConsumerWidget {
  const TrashActivityContributionCard({
    required this.achievementRate,
    super.key,
  });

  final double achievementRate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color getColor(int index) {
      final achievementRateRatio = achievementRate / 10;
      final ratioIndex = achievementRateRatio.floor();
      final opacity = achievementRateRatio - ratioIndex;

      if (index < ratioIndex) {
        return AppColor.black;
      } else if (index == ratioIndex) {
        return AppColor.black.withOpacity(opacity);
      } else {
        return AppColor.white;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColor.primaryGreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '10月の\nゴミ拾い貢献度',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppColor.white,
                      ),
                ),
                Text(
                  achievementRate.toString(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: AppColor.white,
                      ),
                ),
              ],
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < 10; i++)
                  Assets.images.trashBag.svg(
                    width: 32,
                    height: 32,
                    // ignore: deprecated_member_use_from_same_package
                    color: getColor(i),
                  ),
              ],
            ),
            const Gap(16),
            Text(
              'この調子で頑張りましょう！',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColor.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
