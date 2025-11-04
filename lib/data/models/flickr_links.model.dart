import 'package:json_annotation/json_annotation.dart';
part 'flickr_links.model.g.dart';


@JsonSerializable()
class FlickrLinks {
  final List<String>? small;
  final List<String>? original;

  FlickrLinks({required this.small, required this.original});

  factory FlickrLinks.fromJson(Map<String, dynamic> json) => _$FlickrLinksFromJson(json);
  Map<String, dynamic> toJson() => _$FlickrLinksToJson(this);
}