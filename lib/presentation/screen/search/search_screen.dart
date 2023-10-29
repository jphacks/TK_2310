import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:safa_app/domain/entity/event.dart';
import 'package:safa_app/domain/repository/search_repository.dart';
import 'package:safa_app/presentation/component/app_bar_base.dart';
import 'package:safa_app/presentation/component/card/event_card.dart';
import 'package:safa_app/presentation/component/chip/chip_base.dart';
import 'package:safa_app/presentation/component/custom_date_picker.dart';
import 'package:safa_app/presentation/component/custom_time_picker.dart';
import 'package:safa_app/presentation/screen/search/component/button/search_flat_button.dart';
import 'package:safa_app/presentation/screen/search/component/button/shelf_button.dart';
import 'package:safa_app/presentation/screen/search/component/modal/search_modal_bottom_sheet.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNameController = useTextEditingController();
    final addressController = useTextEditingController();
    final priceController = useTextEditingController();

    final dateState = useState<DateTime?>(null);
    final timeState = useState<DateTime?>(null);

    final result = useState<List<Event>>([]);

    final searchRepo = ref.watch(searchRepositoryProvider);

    Future<void> _search() async {
      result.value = await searchRepo.searchEventsByQuery(
        keyword: eventNameController.text,
        minUnitPrice: priceController.text.isEmpty ? 0 : int.parse(priceController.text.replaceAll(',', '')),
        willStartAt: (dateState.value == null || timeState.value == null)
            ? DateTime.now()
            : DateTime(
                dateState.value!.year,
                dateState.value!.month,
                dateState.value!.day,
                timeState.value!.hour,
                timeState.value!.minute,
              ),
      );
    }

    return Scaffold(
      appBar: const AppBarBase(title: '検索', leading: SizedBox()),
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
              onTap: () async {
                await searchModalBottomSheet(
                  context,
                  title: 'イベント名で検索',
                  hintText: 'イベント名を入力してください',
                  controller: eventNameController,
                  onPressed: () async {
                    Navigator.pop(context);
                    await _search();
                  },
                );
              },
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchFlatButton(
                  icon: Icons.event,
                  selectedText: '10月28日(木)',
                  onTap: () async {
                    dateState.value = await customDatePicker(context);
                    await _search();
                  },
                ),
                SearchFlatButton(
                  icon: Icons.access_time,
                  selectedText: '10:00 以降',
                  onTap: () async {
                    timeState.value = await customTimePicker(context);
                    await _search();
                  },
                ),
              ],
            ),
            const Gap(16),
            SearchFlatButton(
              icon: Icons.access_time,
              selectedText: '1,000円 以上',
              onTap: () async {
                await searchModalBottomSheet(
                  context,
                  title: '最低価格で検索',
                  hintText: '最低価格を入力してください',
                  controller: priceController,
                  onPressed: () async {
                    Navigator.pop(context);
                    await _search();
                  },
                );
                await _search();
              },
            ),
            const Gap(16),
            SearchFlatButton(
              icon: Icons.place_outlined,
              selectedText: '東京都渋谷区代々木神園町 周辺',
              isWidly: true,
              onTap: () async {
                await searchModalBottomSheet(
                  context,
                  title: '場所で検索',
                  hintText: '場所を入力してください',
                  controller: addressController,
                  onPressed: () async {
                    Navigator.pop(context);
                    await _search();
                  },
                );
              },
            ),
            const Gap(48),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: result.value.length,
              itemBuilder: (context, index) {
                // if (result.value == 0) {
                //   return Center(
                //     child: LottieGenImage(
                //       Assets.lottie.eventShelfLoading.path,
                //     ).lottie(width: 320),
                //   );
                // }
                final event = result.value[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: EventCard(
                    chips: const [
                      ChipBase(labelText: '開催日'),
                    ],
                    event: event,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
