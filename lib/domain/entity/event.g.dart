// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      willStartAt: DateTime.parse(json['will_start_at'] as String),
      willCompleteAt: DateTime.parse(json['will_complete_at'] as String),
      applicationDeadline:
          DateTime.parse(json['application_deadline'] as String),
      memberId: json['member_id'] as String? ?? '',
      organizationId: json['organization_id'] as int? ?? 0,
      averageScore: json['average_score'] as int? ?? 0,
      eventId: json['event_id'] as int? ?? 0,
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      hostCompanyName: json['host_company_name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      participantCount: json['participant_count'] as int? ?? 0,
      unitPrice: json['unit_price'] as int? ?? 0,
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'will_start_at': instance.willStartAt.toIso8601String(),
      'will_complete_at': instance.willCompleteAt.toIso8601String(),
      'application_deadline': instance.applicationDeadline.toIso8601String(),
      'member_id': instance.memberId,
      'organization_id': instance.organizationId,
      'average_score': instance.averageScore,
      'event_id': instance.eventId,
      'id': instance.id,
      'title': instance.title,
      'host_company_name': instance.hostCompanyName,
      'address': instance.address,
      'participant_count': instance.participantCount,
      'unit_price': instance.unitPrice,
    };
