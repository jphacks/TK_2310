import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

typedef EventId = int;

@freezed
class Event with _$Event {
  const factory Event({
    required DateTime willStartAt,
    required DateTime willCompleteAt,
    required DateTime applicationDeadline,
    @Default('') String memberId,
    @Default(0) int organizationId,
    @Default(0) int averageScore,
    @Default('') String id,
    @Default('') String title,
    @Default('') String hostCompanyName,
    @Default('') String address,
    @Default(0) int participantCount,
    @Default(0) int unitPrice,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
