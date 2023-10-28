import 'package:flutter/material.dart';
import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/component/button/filled_button_base.dart';
import 'package:safa_app/presentation/screen/search/event_shelf/event_shelf_search_screen.dart';

class ShelfButton extends StatelessWidget {
  const ShelfButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButtonBase(
      height: 85,
      isWidly: true,
      insidePadding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 4,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const EventShelfSearchScreen(),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.auto_graph, size: 48),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'イベントはしご検索',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColor.white,
                    ),
              ),
              Text(
                '１日に複数のイベントをハシゴしよう！',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColor.white,
                    ),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, size: 28),
        ],
      ),
    );
  }
}
