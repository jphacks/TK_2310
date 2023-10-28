import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:safa_app/domain/entity/event.dart';
import 'package:safa_app/presentation/component/card/event_card.dart';
import 'package:safa_app/presentation/component/chip/chip_base.dart';
import 'package:safa_app/presentation/screen/search/component/button/search_flat_button.dart';
import 'package:safa_app/presentation/screen/search/component/button/shelf_button.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const Gap(24),
            const ShelfButton(),
            const Gap(16),
            SearchFlatButton(
              icon: Icons.search,
              selectedText: 'イベント名で検索',
              isWidly: true,
              onTap: () {},
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchFlatButton(
                  icon: Icons.event,
                  selectedText: '10月28日(木)',
                  onTap: () {},
                ),
                SearchFlatButton(
                  icon: Icons.access_time,
                  selectedText: '10:00 以降',
                  onTap: () {},
                ),
              ],
            ),
            const Gap(16),
            SearchFlatButton(
              icon: Icons.place_outlined,
              selectedText: '東京都渋谷区代々木神園町 周辺',
              isWidly: true,
              onTap: () {},
            ),
            const Gap(48),
            EventCard(
              outsidePadding: EdgeInsets.zero,
              chips: const [
                ChipBase(labelText: '開催日'),
              ],
              event: Event(
                willStartAt: DateTime(2023, 10, 28),
                willCompleteAt: DateTime(2023, 10, 28),
                applicationDeadline: DateTime.now(),
                memberId: '1',
                organizationId: 1,
                averageScore: 1,
                eventId: 1,
                id: '1',
                title: '港区立青少年センター',
                hostCompanyName: '港区',
                address: '東京都渋谷区代々木神園町',
                participantCount: 10,
                unitPrice: 10000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
