import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:safa_app/domain/entity/event.dart';
import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/component/card/widly_card.dart';
import 'package:safa_app/presentation/component/chip/chip_base.dart';
import 'package:safa_app/presentation/screen/event_detail/event_detail_screen.dart';
import 'package:safa_app/theme.dart';
import 'package:safa_app/util/format/currency_format.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.chips,
    required this.event,
    this.outsidePadding = const EdgeInsets.all(16),
    super.key,
  });

  final EdgeInsetsGeometry outsidePadding;

  // TODO(mine2424): 内部で条件分岐
  final List<ChipBase>? chips;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => EventDetailScreen(eventId: event.id),
          ),
        );
      },
      child: WidlyCard(
        outsidePadding: outsidePadding,
        backgroundColor: AppColor.grayBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (chips != null)
              Wrap(
                // spacing: 8,
                // runSpacing: 4,
                children: chips!
                    .map(
                      (child) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: child,
                      ),
                    )
                    .toList(),
              ),
            const Gap(8),
            Text(
              event.title,
              style: boldNotoSansTextStyle(20),
            ),
            const Gap(16),
            Row(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.event_outlined,
                      color: AppColor.primaryGreenDark,
                    ),
                    const Gap(4),
                    Text(
                      DateTime.now().isAfter(event.willStartAt)
                          ? '開催中'
                          : DateFormat('yyyy/MM/dd').format(event.willStartAt),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColor.primaryGreenDark,
                          ),
                    ),
                  ],
                ),
                const Gap(16),
                Row(
                  children: [
                    const Icon(
                      Icons.currency_yen,
                      color: AppColor.primaryGreenDark,
                    ),
                    const Gap(4),
                    Text(
                      currencyFormat(event.unitPrice),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColor.primaryGreenDark,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                const Icon(
                  Icons.place_outlined,
                  color: AppColor.primaryGreenDark,
                ),
                const Gap(4),
                Text(
                  event.address,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.primaryGreenDark,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
