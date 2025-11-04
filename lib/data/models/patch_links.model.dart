import 'package:json_annotation/json_annotation.dart';

part 'patch_links.model.g.dart';

@JsonSerializable()
class PatchLinks {
  final String? small;
  final String? large;

  PatchLinks({this.small, this.large});

  factory PatchLinks.fromJson(Map<String, dynamic> json) => _$PatchLinksFromJson(json);
  Map<String, dynamic> toJson() => _$PatchLinksToJson(this);

}