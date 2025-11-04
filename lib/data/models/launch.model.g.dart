// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) => Launch(
  id: json['id'] as String?,
  name: json['name'] as String?,
  details: json['details'] as String?,
  dateUtc: json['date_utc'] == null
      ? null
      : DateTime.parse(json['date_utc'] as String),
  success: json['success'] as bool?,
  failures: (json['failures'] as List<dynamic>?)
      ?.map((e) => LaunchFailure.fromJson(e as Map<String, dynamic>))
      .toList(),
  rocketId: json['rocketId'] as String?,
  links: json['links'] == null
      ? null
      : LaunchLinks.fromJson(json['links'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'details': instance.details,
  'date_utc': instance.dateUtc?.toIso8601String(),
  'success': instance.success,
  'failures': instance.failures,
  'rocketId': instance.rocketId,
  'links': instance.links,
};
