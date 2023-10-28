import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:safa_app/domain/repository/event_repository.dart';
import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/component/app_bar_base.dart';
import 'package:safa_app/presentation/component/button/filled_text_button.dart';
import 'package:safa_app/presentation/component/card/event_card.dart';
import 'package:safa_app/presentation/component/chip/chip_base.dart';
import 'package:safa_app/presentation/screen/auth/auth_screen.dart';
import 'package:safa_app/presentation/screen/home/component/trash_activity_contribution_card.dart';
import 'package:safa_app/theme.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carouselController = useCarouselController();
    final _current = useState(0);

    final eventRepo = ref.watch(eventRepositoryProvider);

    // 参加予定のイベント取得のメモ化
    final participatingEventsMemorized = useMemoized(
      eventRepo.getParticipatingEvents,
      const [],
    );
    final participatingEventsFuture = useFuture(participatingEventsMemorized);

    // おすすめのイベント取得のメモ化
    final recommendedEventsMemorized = useMemoized(
      eventRepo.getRecommendedEvents,
      const [],
    );
    final recommendedEventsFuture = useFuture(recommendedEventsMemorized);

    // ゴミ拾い貢献度取得のメモ化
    final achievementRateMemoriszed = useMemoized(
      eventRepo.getAchievementRate,
      const [],
    );
    final achievementRate = useFuture(achievementRateMemoriszed);

    final isLoading = !(participatingEventsFuture.hasData &&
        recommendedEventsFuture.hasData &&
        achievementRate.hasData);

    return Scaffold(
      // TODO(mine2424): AppBar なくてもいいかも
      appBar: const AppBarBase(title: 'ホーム', leading: SizedBox()),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColor.primaryGreen),
            )
          : ListView(
              children: [
                const Gap(16),
                // ゴミ拾い貢献度
                TrashActivityContributionCard(
                  achievementRate: achievementRate.data!,
                ),
                const Gap(16),
                // 参加予定のイベント
                ColoredBox(
                  color: AppColor.primaryGreenBg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '参加予定のイベント',
                          style: boldNotoSansTextStyle(20),
                        ),
                      ),
                      const Gap(16),
                      CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: participatingEventsFuture.data!.length,
                        itemBuilder: (context, index, realIndex) {
                          final event = participatingEventsFuture.data![index];
                          return EventCard(
                            outsidePadding: const EdgeInsets.only(right: 16),
                            event: event,
                            chips: const [
                              ChipBase(labelText: '開催日が近い'),
                            ],
                          );
                        },
                        options: CarouselOptions(
                          height: 210,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            _current.value = index;
                          },
                        ),
                      ),
                      const Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: participatingEventsFuture.data!
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () async {
                              await carouselController.animateToPage(entry.key);
                            },
                            child: Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                  _current.value == entry.key ? 0.9 : 0.3,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const Gap(24),
                    ],
                  ),
                ),
                const Gap(24),
                // おすすめのイベント
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'おすすめのイベント',
                    style: boldNotoSansTextStyle(20),
                  ),
                ),
                const Gap(16),
                ListView.builder(
                  // listview in listview でエラーが出るので、shrinkWrap と physics を設定する
                  // ref: https://stackoverflow.com/questions/45270900/how-to-implement-nested-listview-in-flutter
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  primary: false,
                  itemCount: recommendedEventsFuture.data!.length,
                  itemBuilder: (context, index) {
                    final event = recommendedEventsFuture.data![index];
                    return EventCard(
                      outsidePadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      event: event,
                      chips: const [
                        ChipBase(labelText: '開催日が近い'),
                      ],
                    );
                  },
                ),
                const Gap(16),
                FilledTextButton(
                  outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                  labelText: 'イベントを探す',
                  onPressed: () {
                    // TODO(mine2424): bottomNavigationBarのindexを操作して移動させる
                  },
                  isWidly: true,
                ),
                const Gap(32),
              ],
            ),
    );
  }
}
