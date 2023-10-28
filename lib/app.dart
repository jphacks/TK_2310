import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:safa_app/foundation/firebase/auth.dart';
import 'package:safa_app/presentation/screen/auth/auth_screen.dart';
import 'package:safa_app/presentation/screen/root/root_screen.dart';
import 'package:safa_app/theme.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authFoundationProvider);
    final judgeNavigation = useState<AuthStatus>(AuthStatus.unauthenticated);

    // widget 等の rebuild 毎に authState が変わるのを防ぐ
    final authStatus = useMemoized(
      () => auth.onAuthStatusChanged(ref),
      const [],
    );

    useEffect(
      () {
        judgeNavigation.value = authStatus;
        return null;
      },
      const [],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'safa_app',
      theme: customTheme(),
      home: () {
        switch (judgeNavigation.value) {
          case AuthStatus.authenticated:
            return const RootScreen();
          case AuthStatus.unauthenticated:
            return const AuthScreen();
          case AuthStatus.loading:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
        }
      }(),
    );
  }
}
