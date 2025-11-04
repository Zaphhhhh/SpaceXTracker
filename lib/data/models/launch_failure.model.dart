import 'package:json_annotation/json_annotation.dart';
part 'launch_failure.model.g.dart';

@JsonSerializable()
class LaunchFailure {
  final int? time;
  final int? altitude;
  final String? reason;

  LaunchFailure({this.time, this.altitude, required this.reason});

  factory LaunchFailure.fromJson(Map<String, dynamic> json) => _$LaunchFailureFromJson(json);
  Map<String, dynamic> toJson() => _$LaunchFailureToJson(this);

}