// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventDetailImpl _$$EventDetailImplFromJson(Map<String, dynamic> json) =>
    _$EventDetailImpl(
      willStartAt: DateTime.parse(json['will_start_at'] as String),
      willCompleteAt: DateTime.parse(json['will_complete_at'] as String),
      applicationDeadline:
          DateTime.parse(json['application_deadline'] as String),
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      hostCompanyName: json['host_company_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      participantCount: json['participant_count'] as int? ?? 0,
      unitPrice: json['unit_price'] as int? ?? 0,
      leaderName: json['leader_name'] as String? ?? '',
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$$EventDetailImplToJson(_$EventDetailImpl instance) =>
    <String, dynamic>{
      'will_start_at': instance.willStartAt.toIso8601String(),
      'will_complete_at': instance.willCompleteAt.toIso8601String(),
      'application_deadline': instance.applicationDeadline.toIso8601String(),
      'id': instance.id,
      'title': instance.title,
      'host_company_name': instance.hostCompanyName,
      'description': instance.description,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'participant_count': instance.participantCount,
      'unit_price': instance.unitPrice,
      'leader_name': instance.leaderName,
      'started_at': instance.startedAt?.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
    };
