import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import 'package:safa_app/domain/entity/event.dart';
import 'package:safa_app/gen/assets.gen.dart';
import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/component/app_bar_base.dart';
import 'package:safa_app/presentation/component/button/filled_text_button.dart';
import 'package:safa_app/presentation/component/button/outlined_button_base.dart';
import 'package:safa_app/presentation/component/card/event_card.dart';
import 'package:safa_app/presentation/component/chip/chip_base.dart';
import 'package:safa_app/presentation/screen/root/root_screen.dart';
import 'package:safa_app/theme.dart';
import 'package:safa_app/util/format/currency_format.dart';

class EventShelfResultScreen extends HookWidget {
  const EventShelfResultScreen({required this.events, super.key, this.sumPrice = 0});

  final List<Event> events;
  final int sumPrice;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);

    useEffect(
      () {
        Future.delayed(const Duration(seconds: 2), () {
          isLoading.value = false;
        });
        return null;
      },
      const [],
    );

    return Scaffold(
      appBar: const AppBarBase(
        title: 'イベントはしご検索結果',
        leading: SizedBox(),
      ),
      body: isLoading.value
          ? Center(
              child: LottieGenImage(
                Assets.lottie.eventShelfLoading.path,
              ).lottie(width: 320),
            )
          : ListView(
              children: [
                const Gap(24),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  color: AppColor.primaryGreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'おすすめのスケジュールが\nできました',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: AppColor.white,
                                ),
                          ),
                          const Icon(
                            Icons.auto_graph,
                            size: 48,
                            color: AppColor.white,
                          ),
                        ],
                      ),
                      const Gap(24),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${events[0].willStartAt.month}月${events[0].willStartAt.month}日',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColor.white,
                                    ),
                              ),
                              Text(
                                '${events.length}件のイベントに参加',
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      color: AppColor.white,
                                    ),
                              ),
                            ],
                          ),
                          const Gap(32),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '報酬の合計',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColor.white,
                                    ),
                              ),
                              Text(
                                currencyFormat(sumPrice),
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      color: AppColor.white,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '10月21日のスケジュール',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const Gap(16),
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        EventCard(
                          outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                          chips: const [
                            ChipBase(labelText: '開催日'),
                          ],
                          event: events[index],
                        ),
                        if (index != events.length - 1)
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 32,
                            color: AppColor.black,
                          ),
                      ],
                    );
                  },
                ),
                const Gap(48),
                FilledTextButton(
                  outsidePadding: const EdgeInsets.symmetric(horizontal: 32),
                  labelText: '全てのイベントに申し込む',
                  onPressed: () {
                    // TODO: 申し込み処理
                    Navigator.replace(
                      context,
                      oldRoute: ModalRoute.of(context)!,
                      newRoute: MaterialPageRoute<void>(
                        builder: (context) => const RootScreen(),
                      ),
                    );
                  },
                  isWidly: true,
                ),
                const Gap(16),
                OutlinedButtonBase(
                  outsidePadding: const EdgeInsets.symmetric(horizontal: 32),
                  onPressed: () => Navigator.pop(context),
                  isWidly: true,
                  child: Text(
                    '条件を変更する',
                    style: boldNotoSansTextStyle(
                      16,
                      color: AppColor.primaryOrange,
                    ),
                  ),
                ),
                const Gap(24),
              ],
            ),
    );
  }
}
