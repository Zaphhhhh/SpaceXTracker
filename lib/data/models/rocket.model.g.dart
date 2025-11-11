// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rocket.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mass _$MassFromJson(Map<String, dynamic> json) =>
    Mass(kg: (json['kg'] as num?)?.toInt());

Map<String, dynamic> _$MassToJson(Mass instance) => <String, dynamic>{
  'kg': instance.kg,
};

Length _$LengthFromJson(Map<String, dynamic> json) =>
    Length(meters: (json['meters'] as num?)?.toDouble());

Map<String, dynamic> _$LengthToJson(Length instance) => <String, dynamic>{
  'meters': instance.meters,
};

Rocket _$RocketFromJson(Map<String, dynamic> json) => Rocket(
  id: json['id'] as String?,
  name: json['name'] as String?,
  type: json['type'] as String?,
  firstFlight: json['first_flight'] == null
      ? null
      : DateTime.parse(json['first_flight'] as String),
  country: json['country'] as String?,
  company: json['company'] as String?,
  height: json['height'] == null
      ? null
      : Length.fromJson(json['height'] as Map<String, dynamic>),
  diameter: json['diameter'] == null
      ? null
      : Length.fromJson(json['diameter'] as Map<String, dynamic>),
  mass: json['mass'] == null
      ? null
      : Mass.fromJson(json['mass'] as Map<String, dynamic>),
  costPerLaunch: (json['cost_per_launch'] as num?)?.toInt(),
  successRatePct: (json['success_rate_pct'] as num?)?.toInt(),
);

Map<String, dynamic> _$RocketToJson(Rocket instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': instance.type,
  'first_flight': instance.firstFlight?.toIso8601String(),
  'country': instance.country,
  'company': instance.company,
  'height': instance.height,
  'diameter': instance.diameter,
  'mass': instance.mass,
  'cost_per_launch': instance.costPerLaunch,
  'success_rate_pct': instance.successRatePct,
};
