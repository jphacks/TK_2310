import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'safa_backend_api.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
Dio safaBackendApi(SafaBackendApiRef ref, {bool isMock = true}) {
  const mockUrl = 'https://mock-backend-twmyiymqla-an.a.run.app';

  // TODO(mine2424): 本番のURLができたら入れる
  // ignore: unused_local_variable
  const prodUrl = 'https://jphacks-backend-prd-twmyiymqla-an.a.run.app';

  const stgUrl = 'https://jphacks-backend-stg-twmyiymqla-an.a.run.app';

  final dioInstance = Dio(
    BaseOptions(
      // baseUrl: token == null ? mockUrl : prodUrl,
      baseUrl: isMock ? mockUrl : prodUrl,
    ),
  );

  return dioInstance;
}
