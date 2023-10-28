import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:safa_app/domain/entity/event.dart';
import 'package:safa_app/foundation/firebase/auth.dart';
import 'package:safa_app/foundation/network/safa_backend_api.dart';

part 'event_repository.g.dart';

@Riverpod(keepAlive: true, dependencies: [authFoundation, safaBackendApi])
EventRepository eventRepository(EventRepositoryRef ref) {
  final dio = ref.watch(SafaBackendApiProvider());
  final auth = ref.watch(authFoundationProvider);
  return EventRepository(dio, auth);
}

class EventRepository {
  const EventRepository(this._dio, this._auth);

  final Dio _dio;
  final AuthFoundation _auth;

  Future<double> getAchievementRate() async {
    try {
      final result = await _dio.get<Map<String, dynamic>>(
        '/achievement-rate',
        options: Options(
          headers: {'Authorization': 'Bearer ${_auth.currentUser?.uid}'},
        ),
      );
      if (result.data == null) {
        throw Exception('achievement rate is null');
      }

      return result.data!['garbage_collection_rate'] as double;
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  Future<List<Event>> getParticipatingEvents() async {
    try {
      final result = await _dio.get<Map<String, dynamic>>(
        '/event/schedule',
        options: Options(
          headers: {'Authorization': 'Bearer ${_auth.currentUser?.uid}'},
        ),
      );
      if (result.data == null) {
        throw Exception('events is null');
      }

      final events = result.data!['events'] as List<dynamic>;
      return events
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  Future<List<Event>> getRecommendedEvents() async {
    try {
      const limit = 5;
      final result = await _dio.get<Map<String, dynamic>>(
        '/event/recommendation?limit=$limit',
        options: Options(
          headers: {'Authorization': 'Bearer ${_auth.currentUser?.uid}'},
        ),
      );
      if (result.data == null) {
        throw Exception('events is null');
      }

      final events = result.data!['events'] as List<dynamic>;

      return events
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }
}
