import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:safa_app/domain/entity/event_detail.dart';

import 'package:safa_app/foundation/firebase/auth.dart';
import 'package:safa_app/foundation/network/safa_backend_api.dart';

part 'event_detail_repository.g.dart';

@Riverpod(keepAlive: true, dependencies: [authFoundation, safaBackendApi])
EventDetailRepository eventDetailRepository(EventDetailRepositoryRef ref) {
  final dio = ref.watch(SafaBackendApiProvider(isMock: false));
  final auth = ref.watch(authFoundationProvider);
  return EventDetailRepository(dio, auth);
}

class EventDetailRepository {
  const EventDetailRepository(this._dio, this._auth);

  final Dio _dio;
  final AuthFoundation _auth;

  Future<EventDetail> getEventDetail(String eventId) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      final result = await _dio.get<Map<String, dynamic>>(
        '/event/$eventId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (result.data == null) {
        throw Exception('event detail is null');
      }

      return EventDetail.fromJson(result.data!);
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }
}
