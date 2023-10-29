import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:safa_app/domain/entity/event.dart';
import 'package:safa_app/foundation/firebase/auth.dart';
import 'package:safa_app/foundation/network/safa_backend_api.dart';

part 'search_repository.g.dart';

@Riverpod(keepAlive: true, dependencies: [authFoundation, safaBackendApi])
SearchRepository searchRepository(SearchRepositoryRef ref) {
  final dio = ref.watch(SafaBackendApiProvider(isMock: false));
  final auth = ref.watch(authFoundationProvider);
  return SearchRepository(dio, auth);
}

class SearchRepository {
  const SearchRepository(this._dio, this._auth);

  final Dio _dio;
  final AuthFoundation _auth;

  /// GET /event/search?keyword="string"&min_unit_price="number"&will_start_at="Date"&limit="number"&offset="number"
  Future<List<Event>> searchEventsByQuery({
    String keyword = '',
    int minUnitPrice = 0,
    DateTime? willStartAt,
    // required int limit,
    // required int offset,
  }) async {
    // if null, set now time
    willStartAt ??= DateTime.now();

    try {
      final token = await _auth.currentUser?.getIdToken();
      final result = await _dio.get<Map<String, dynamic>>(
        '/event/search?keyword=$keyword&min_unit_price=$minUnitPrice&will_start_at=$willStartAt', //&limit="number"&offset="number",
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (result.data == null) {
        throw Exception('searchEventsByQuery is null');
      }

      final events = result.data!['events'] as List<dynamic>;
      return events.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  /// GET /event/order-recommendation?address="string"&start_at="Date"&complete_at="Date"&interval_minute="number"
  Future<(List<Event>, int)> searchEventsByOrderRecommendation({
    String address = '',
    DateTime? startAt,
    int intervalMinute = 0,
  }) async {
    // if null, set now time
    startAt ??= DateTime.now();

    try {
      final token = await _auth.currentUser?.getIdToken();
      final result = await _dio.get<Map<String, dynamic>>(
        '/event/order-recommendation?address=$address&start_at=$startAt&interval_minute=$intervalMinute',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (result.data == null) {
        throw Exception('searchEventsByOrderRecommendation is null');
      }

      final events = result.data!['events'] as List<dynamic>;
      final sumPrice = result.data!['sum_price'] as int;

      print('sumPrice: $sumPrice');
      print('events: $events');

      return (
        events.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList(),
        sumPrice,
      );
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }
}
