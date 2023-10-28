import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'safa_backend_api.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
Dio safaBackendApi(SafaBackendApiRef ref, [String? token]) {
  const mockUrl = 'https://mock-backend-twmyiymqla-an.a.run.app';

  // TODO(mine2424): 本番のURLができたら入れる
  const prodUrl = 'https://safa-backend.herokuapp.com/api/v1';

  final dioInstance = Dio(
    BaseOptions(
      baseUrl: token == null ? mockUrl : prodUrl,
      headers: {
        'Authrization': 'Bearer $token',
      },
    ),
  );

  return dioInstance;
}
