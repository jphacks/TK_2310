import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:safa_app/domain/repository/event_detail_repository.dart';
import 'package:safa_app/gen/assets.gen.dart';
import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/component/app_bar_base.dart';
import 'package:safa_app/presentation/component/button/filled_text_button.dart';
import 'package:safa_app/presentation/component/chip/chip_base.dart';
import 'package:safa_app/theme.dart';
import 'package:safa_app/util/format/currency_format.dart';

class EventDetailScreen extends HookConsumerWidget {
  const EventDetailScreen({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final eventLatLng = LatLng(35.681236, 139.767125);
    final eventLatLng = useState(LatLng(35.681236, 139.767125));

    final eventDetailRepo = ref.watch(eventDetailRepositoryProvider);

    final eventDetailMemoized = useMemoized(() => eventDetailRepo.getEventDetail(eventId), [eventId]);
    final eventDetailFuture = useFuture(eventDetailMemoized);

    final data = eventDetailFuture.hasData ? eventDetailFuture.data : null;

    // 本日から締め切りまでの残りの日数
    final diffDeadline = (data?.applicationDeadline ?? DateTime.now()).difference(DateTime.now()).inDays;

    final eventStatus = useState(0);

    useEffect(
      () {
        if (eventDetailFuture.hasData) {
          eventLatLng.value = LatLng(
            eventDetailFuture.data!.latitude,
            eventDetailFuture.data!.longitude,
          );
        }

        return null;
      },
      [eventDetailFuture],
    );

    return Scaffold(
      appBar: const AppBarBase(title: 'イベント詳細'),
      body: !eventDetailFuture.hasData
          ? Center(
              child: LottieGenImage(
                Assets.lottie.eventShelfLoading.path,
              ).lottie(width: 320),
            )
          : ListView(
              children: [
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    data!.title,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColor.primaryGreenDark,
                        ),
                  ),
                ),
                const Gap(16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    runSpacing: 4,
                    spacing: 8,
                    children: [
                      ChipBase(labelText: '参加者多数', backgroundColor: AppColor.chipPurple),
                      ChipBase(labelText: '開催日が近い', backgroundColor: AppColor.chipRed),
                      ChipBase(labelText: '残りわずか', backgroundColor: AppColor.chipYellow),
                    ],
                  ),
                ),
                const Gap(16),

                // Row:1
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '開催日',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.grayText,
                                ),
                          ),
                          const Gap(4),
                          Text(
                            '${data.willStartAt.month}月${data.willStartAt.day}日 ${data.willStartAt.hour}:00~${data.willCompleteAt.hour}:00',
                            style: boldNotoSansTextStyle(20),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColor.primaryGreenBg,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              '締め切りまで',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColor.primaryGreenDark,
                                  ),
                            ),
                            Text(
                              'あと$diffDeadline日',
                              style: boldNotoSansTextStyle(
                                20,
                                color: AppColor.primaryGreenDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(12),

                // Row:2
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '稼働報酬',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.grayText,
                                ),
                          ),
                          const Gap(4),
                          Text(
                            currencyFormat(
                              data.unitPrice *
                                  (data.startedAt ?? DateTime.now())
                                      .difference(
                                        data.completedAt ?? DateTime.now(),
                                      )
                                      .inHours,
                            ),
                            style: boldNotoSansTextStyle(20),
                          ),
                        ],
                      ),
                      const Gap(8),
                      Text('1時間あたり${currencyFormat(data.unitPrice)}', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                const Gap(12),

                // Row:3
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '残り募集人数',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: AppColor.grayText,
                                    ),
                              ),
                              const Gap(4),
                              Text(
                                '2人',
                                style: boldNotoSansTextStyle(20),
                              ),
                            ],
                          ),
                          Text(
                            '${data.participantCount}人の募集',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.grayText,
                                ),
                          ),
                        ],
                      ),
                      const Gap(4),
                      SizedBox(
                        height: 16,
                        child: LinearProgressIndicator(
                          value: 2 / data.participantCount,
                          color: AppColor.primaryGreenFill,
                          backgroundColor: AppColor.grayFill,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(60),
                const Divider(height: 1, thickness: 1),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '開催場所',
                        style: boldNotoSansTextStyle(20),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          Icon(Icons.place_outlined, color: AppColor.primaryGreenDark),
                          const Gap(4),
                          Text(
                            data.address,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.primaryGreenDark,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                SizedBox(
                  height: 210,
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: eventLatLng.value,
                      zoom: 14.8,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('marker_1'),
                        position: eventLatLng.value,
                      ),
                    },
                  ),
                ),
                const Gap(24),

                // Row:5
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'スポンサー',
                        style: boldNotoSansTextStyle(20),
                      ),
                      const Gap(4),
                      Text(
                        '株式会社グリーンランド',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Gap(80),
                    ],
                  ),
                ),
                () {
                  switch (eventStatus.value) {
                    case 0:
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '募集締め切り: ${data.applicationDeadline.year}/${data.applicationDeadline.month}/${data.applicationDeadline.day}',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColor.primaryOrange,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Gap(8),
                          FilledTextButton(
                            labelText: 'イベントに申し込む',
                            isWidly: true,
                            onPressed: () {
                              eventStatus.value = 1;
                            },
                            outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ],
                      );
                    case 1:
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '集合場所と開始時刻を確認して\nイベントに参加してください',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.primaryGreenDark),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Gap(8),
                          FilledTextButton(
                            labelText: 'イベント申込済み',
                            isWidly: true,
                            backgroundColor: AppColor.primaryGreenBg,
                            labelTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.primaryGreenDark,
                                ),
                            onPressed: () {
                              sleep(const Duration(seconds: 5));
                              eventStatus.value = 2;
                            },
                            outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ],
                      );
                    case 2:
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'リーダーによってイベントが開始されました\nゴミ拾いをしましょう!',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.primaryGreenDark),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Gap(8),
                          FilledTextButton(
                            labelText: 'イベント開催中',
                            isWidly: true,
                            backgroundColor: AppColor.primaryGreenBg,
                            labelTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColor.primaryGreenDark,
                                ),
                            onPressed: () {
                              eventStatus.value = 3;
                            },
                            outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ],
                      );
                    case 3:
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'ゴミ拾いが終わったらイベントを完了してください\n完了の操作がないと欠席扱いになります',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColor.primaryOrange,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Gap(8),
                          FilledTextButton(
                            labelText: 'ゴミ拾いを完了する',
                            isWidly: true,
                            onPressed: () {
                              // dialog
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      height: 600,
                                      padding: const EdgeInsets.all(16),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            'イベントを完了しますか？',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                          const Gap(16),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              FilledTextButton(
                                                labelText: 'キャンセル',
                                                isWidly: true,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                                              ),
                                              FilledTextButton(
                                                labelText: '完了する',
                                                isWidly: true,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  eventStatus.value = 4;
                                                },
                                                outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ],
                      );
                    default:
                      return FilledTextButton(
                        labelText: '欠席・開催終了しました',
                        isWidly: true,
                        onPressed: () {},
                        outsidePadding: const EdgeInsets.symmetric(horizontal: 16),
                      );
                  }
                }(),
                const Gap(16),
              ],
            ),
    );
  }
}
