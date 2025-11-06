import 'launch_failure.model.dart';
import 'launch_links.model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
part 'launch.model.g.dart';

@JsonSerializable()
class Launch {
  final String? id;
  final String? name;
  final String? details;
  @JsonKey(name: 'date_utc')
  final DateTime? dateUtc;
  final bool? success;
  final List<LaunchFailure>? failures;
  final String? rocketId;
  final LaunchLinks? links;
  @JsonKey(ignore: true)
  bool isFavorite = false;

  Launch({
    required this.id,
    required this.name,
    required this.details,
    required this.dateUtc,
    required this.success,
    required this.failures,
    required this.rocketId,
    required this.links,
  });

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);
  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}
