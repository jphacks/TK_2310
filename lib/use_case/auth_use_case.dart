import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:safa_app/foundation/firebase/auth.dart';
import 'package:safa_app/foundation/network/safa_backend_api.dart';
import 'package:safa_app/type/string_error.dart';

StringError _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'メールアドレスを入力してください';
  }
  if (!value.contains('@')) {
    return 'メールアドレスの形式が正しくありません';
  }
  return null;
}

StringError _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'パスワードを入力してください';
  }
  if (value.length < 6) {
    return 'パスワードは6文字以上で入力してください';
  }
  return null;
}

final class AuthUseCase {
  static const signUpPath = '/auth/signup';

  static Future<StringError> signUp(
    WidgetRef ref, {
    required String email,
    required String password,
  }) async {
    try {
      if (_validateEmail(email) != null) _validateEmail(email);

      if (_validatePassword(password) != null) _validatePassword(password);

      final auth = ref.read(authFoundationProvider);
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final idToken = await auth.getIdToken();

      final dio = ref.read(SafaBackendApiProvider());

      await dio.post<dynamic>(
        signUpPath,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
        data: {},
      );

      return null;
    } catch (e) {
      if (kDebugMode) print(e);
      return e.toString();
    }
  }

  static Future<StringError> signIn(
    WidgetRef ref, {
    required String email,
    required String password,
  }) async {
    try {
      if (_validateEmail(email) != null) _validateEmail(email);

      if (_validatePassword(password) != null) _validatePassword(password);

      final auth = ref.read(authFoundationProvider);
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } catch (e) {
      if (kDebugMode) print(e);
      return e.toString();
    }
  }
}
