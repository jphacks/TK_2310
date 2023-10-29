import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:safa_app/domain/entity/event.dart';
import 'package:safa_app/domain/repository/search_repository.dart';
import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/component/app_bar_base.dart';
import 'package:safa_app/presentation/component/button/filled_text_button.dart';
import 'package:safa_app/presentation/component/chip/chip_base.dart';
import 'package:safa_app/presentation/component/custom_date_picker.dart';
import 'package:safa_app/presentation/component/custom_time_picker.dart';
import 'package:safa_app/presentation/screen/search/component/button/search_flat_button.dart';
import 'package:safa_app/presentation/screen/search/component/modal/search_modal_bottom_sheet.dart';
import 'package:safa_app/presentation/screen/search/event_shelf/event_shelf_result_screen.dart';
import 'package:safa_app/theme.dart';

class EventShelfSearchScreen extends HookConsumerWidget {
  const EventShelfSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressController = useTextEditingController();

    final dateState = useState<DateTime?>(null);
    final timeState = useState<DateTime?>(null);
    final sumPriceState = useState<int>(0);

    final result = useState<List<Event>>([]);

    final searchRepo = ref.watch(searchRepositoryProvider);

    Future<void> _search() async {
      final (events, sumPrice) = await searchRepo.searchEventsByOrderRecommendation(
        address: addressController.text,
        startAt: (dateState.value == null || timeState.value == null)
            ? DateTime.now()
            : DateTime(
                dateState.value!.year,
                dateState.value!.month,
                dateState.value!.day,
                timeState.value!.hour,
                timeState.value!.minute,
              ),
      );

      result.value = events;
      sumPriceState.value = sumPrice;
    }

    return Scaffold(
      appBar: const AppBarBase(title: 'イベントはしご検索'),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Gap(24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            color: AppColor.grayBg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('使い方', style: Theme.of(context).textTheme.headlineSmall),
                const Gap(24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ChipBase(
                      labelText: 'STEP1',
                      backgroundColor: AppColor.primaryGreenFill,
                      labelTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
                    ),
                    const Gap(24),
                    Text('日付と時間帯を選択', style: boldNotoSansTextStyle(20)),
                  ],
                ),
                const Gap(24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ChipBase(
                      labelText: 'STEP2',
                      backgroundColor: AppColor.primaryGreenFill,
                      labelTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
                    ),
                    const Gap(24),
                    Text('検索方法を選択', style: boldNotoSansTextStyle(20)),
                  ],
                ),
                const Gap(24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ChipBase(
                      labelText: 'STEP3',
                      backgroundColor: AppColor.primaryGreenFill,
                      labelTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
                    ),
                    const Gap(24),
                    Text('最適なスケジュールを提案', style: boldNotoSansTextStyle(20)),
                  ],
                ),
              ],
            ),
          ),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SearchFlatButton(
                      icon: Icons.event,
                      selectedText: '10月28日(木)',
                      onTap: () async {
                        dateState.value = await customDatePicker(context);
                      },
                    ),
                    SearchFlatButton(
                      icon: Icons.access_time,
                      selectedText: '10:00 以降',
                      onTap: () async {
                        timeState.value = await customTimePicker(context);
                      },
                    ),
                  ],
                ),
                const Gap(16),
                SearchFlatButton(
                  icon: Icons.place_outlined,
                  selectedText: '東京都渋谷区代々木神園町 周辺',
                  isWidly: true,
                  onTap: () async {
                    await searchModalBottomSheet(
                      context,
                      title: '住所で検索',
                      hintText: '住所を入力してください',
                      controller: addressController,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                const Gap(48),
                Text('検索方法', style: Theme.of(context).textTheme.bodyMedium),
                const Gap(24),
                SearchFlatButton(
                  icon: Icons.chat_bubble_outline,
                  selectedText: '１日でできるだけ多く稼ぎたい！',
                  isWidly: true,
                  onTap: () {},
                ),
                const Gap(24),
                FilledTextButton(
                  outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                  labelText: '最適なスケジュールを作成する',
                  onPressed: () async {
                    await _search();

                    // ignore: use_build_context_synchronously
                    await Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => EventShelfResultScreen(
                          events: result.value,
                          sumPrice: sumPriceState.value,
                        ),
                      ),
                    );
                  },
                  isWidly: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
