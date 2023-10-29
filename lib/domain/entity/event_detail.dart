import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_detail.freezed.dart';
part 'event_detail.g.dart';

typedef EventDetailId = int;

@freezed
class EventDetail with _$EventDetail {
  const factory EventDetail({
    required DateTime willStartAt,
    required DateTime willCompleteAt,
    required DateTime applicationDeadline,
    @Default('') String id,
    @Default('') String title,
    @Default('') String hostCompanyName,
    @Default('') String description,
    @Default('') String address,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default(0) int participantCount,
    @Default(0) int unitPrice,
    @Default('') String leaderName,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _EventDetail;

  factory EventDetail.fromJson(Map<String, dynamic> json) => _$EventDetailFromJson(json);
}
