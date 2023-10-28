import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/screen/home/home_screen.dart';
import 'package:safa_app/presentation/screen/my_page/my_page_screen.dart';
import 'package:safa_app/presentation/screen/search/search_screen.dart';

class RootScreen extends HookWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _currentIndex = useState(0);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex.value,
        children: const [
          HomeScreen(),
          SearchScreen(),
          MyPageScreen(),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: SalomonBottomBar(
          currentIndex: _currentIndex.value,
          onTap: (index) => _currentIndex.value = index,
          backgroundColor: AppColor.white,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('ホーム'),
              selectedColor: AppColor.primaryGreen,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text('検索'),
              selectedColor: AppColor.primaryOrange,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text('マイページ'),
              selectedColor: const Color.fromARGB(255, 117, 161, 243),
            ),
          ],
        ),
      ),
    );
  }
}
