import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

WidgetRef useWidgetRef() {
  return useContext() as WidgetRef;
}
