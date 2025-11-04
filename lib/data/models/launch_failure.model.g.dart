// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_failure.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchFailure _$LaunchFailureFromJson(Map<String, dynamic> json) =>
    LaunchFailure(
      time: (json['time'] as num?)?.toInt(),
      altitude: (json['altitude'] as num?)?.toInt(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$LaunchFailureToJson(LaunchFailure instance) =>
    <String, dynamic>{
      'time': instance.time,
      'altitude': instance.altitude,
      'reason': instance.reason,
    };
