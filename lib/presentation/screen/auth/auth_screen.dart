import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:safa_app/gen/assets.gen.dart';
import 'package:safa_app/gen/colors.gen.dart';
import 'package:safa_app/presentation/component/text_field/text_field_base.dart';
import 'package:safa_app/use_case/auth_use_case.dart';

class _CarouselControllerHook extends Hook<CarouselController> {
  const _CarouselControllerHook();

  @override
  _CarouselControllerHookState createState() => _CarouselControllerHookState();
}

class _CarouselControllerHookState
    extends HookState<CarouselController, _CarouselControllerHook> {
  late final CarouselController _controller;

  @override
  void initHook() {
    _controller = CarouselController();
  }

  @override
  CarouselController build(BuildContext context) => _controller;
}

CarouselController useCarouselController() {
  return use(const _CarouselControllerHook());
}

class AuthScreen extends HookWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isScroll = useState(false);
    final scrollController = useScrollController();
    final carouselController = useCarouselController();

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
        return scrollController.dispose;
      },
      const [],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E0),
      body: SafeArea(
        child: CustomScrollView(
          physics: isScroll.value ? null : const NeverScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Gap(80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Center(
                      child: Text(
                        'ゴミ拾いで街を救う\n~SAFA~',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Assets.images.filledSafaLogo.image(),
                  ),
                  const Gap(40),
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      height: 500,
                    ),
                    carouselController: carouselController,
                    items: [
                      _SignUpItem(
                        isScroll: isScroll,
                        scrollController: scrollController,
                      ),
                      _SignInItem(
                        isScroll: isScroll,
                        scrollController: scrollController,
                      ),
                    ],
                  ),
                  // Gap(MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignUpItem extends HookConsumerWidget {
  const _SignUpItem({
    required this.isScroll,
    required this.scrollController,
  });

  final ValueNotifier<bool> isScroll;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final carouselController = useCarouselController();

    Future<void> _signUp() async {
      await AuthUseCase.signUp(
        ref,
        email: emailController.text,
        password: passwordController.text,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Text(
            '新規登録',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Gap(2),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: TextFieldBase(
              controller: emailController,
              labelText: 'emailを入力してください',
              onTap: () => isScroll.value = true,
              onEditingComplete: () {
                // 編集完了時にキーボードを閉じて、スクロール位置を戻す
                isScroll.value = false;
                FocusScope.of(context).unfocus();
                scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: TextFieldBase(
              obscureText: true,
              controller: passwordController,
              labelText: 'passwordを入力してください',
              onTap: () => isScroll.value = true,
              onEditingComplete: () {
                // 編集完了時にキーボードを閉じて、スクロール位置を戻す
                isScroll.value = false;
                FocusScope.of(context).unfocus();
                scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          const Gap(6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '8文字以上12文字以下の半角英数字',
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
            ),
          ),
          const Gap(20),
          SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: _signUp,
              child: Text(
                'はじめる',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const Gap(12),
          GestureDetector(
            // FIXME(mine2424): state in carouselController is null
            onTap: () => carouselController.animateToPage(
              1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            ),
            child: Text(
              'ログインはこちら',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColor.primaryGreenDark,
                  ),
            ),
          ),
          const Gap(12),
        ],
      ),
    );
  }
}

class _SignInItem extends HookConsumerWidget {
  const _SignInItem({
    required this.isScroll,
    required this.scrollController,
  });

  final ValueNotifier<bool> isScroll;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final carouselController = useCarouselController();

    Future<void> _signIn() async {
      await AuthUseCase.signIn(
        ref,
        email: emailController.text,
        password: passwordController.text,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Text(
            'ログイン',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Gap(2),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: TextFieldBase(
              controller: emailController,
              labelText: 'emailを入力してください',
              onTap: () => isScroll.value = true,
              onEditingComplete: () {
                isScroll.value = false;
                FocusScope.of(context).unfocus();
                scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: TextFieldBase(
              obscureText: true,
              controller: passwordController,
              labelText: 'passwordを入力してください',
              onTap: () => isScroll.value = true,
              onEditingComplete: () {
                isScroll.value = false;
                FocusScope.of(context).unfocus();
                scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          const Gap(6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '8文字以上12文字以下の半角英数字',
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
            ),
          ),
          const Gap(20),
          SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: _signIn,
              child: Text(
                'ログインする',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const Gap(12),
          GestureDetector(
            // FIXME(mine2424): state in carouselController is null
            onTap: () => carouselController.animateToPage(
              0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            ),
            child: Text(
              '新規登録はこちら',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColor.primaryGreenDark,
                  ),
            ),
          ),
          const Gap(12),
        ],
      ),
    );
  }
}
