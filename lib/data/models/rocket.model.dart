import 'package:json_annotation/json_annotation.dart';

part 'rocket.model.g.dart';

@JsonSerializable()
class Mass {
  final int? kg;
  Mass({this.kg});
  factory Mass.fromJson(Map<String, dynamic> json) => _$MassFromJson(json);
  Map<String, dynamic> toJson() => _$MassToJson(this);
}

@JsonSerializable()
class Length {
  final double? meters;
  Length({this.meters});
  factory Length.fromJson(Map<String, dynamic> json) => _$LengthFromJson(json);
  Map<String, dynamic> toJson() => _$LengthToJson(this);
}

@JsonSerializable()
class Rocket {
  final String? id;
  final String? name;
  final String? type;
  @JsonKey(name: 'first_flight')
  final DateTime? firstFlight;
  final String? country;
  final String? company;
  final Length? height;
  final Length? diameter;
  final Mass? mass;
  @JsonKey(name: 'cost_per_launch')
  final int? costPerLaunch;
  @JsonKey(name: 'success_rate_pct')
  final int? successRatePct;

  Rocket({
    this.id,
    this.name,
    this.type,
    this.firstFlight,
    this.country,
    this.company,
    this.height,
    this.diameter,
    this.mass,
    this.costPerLaunch,
    this.successRatePct,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) => _$RocketFromJson(json);
  Map<String, dynamic> toJson() => _$RocketToJson(this);
}
