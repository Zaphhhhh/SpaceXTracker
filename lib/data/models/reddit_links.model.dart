import 'package:json_annotation/json_annotation.dart';

part 'reddit_links.model.g.dart';

@JsonSerializable()
class RedditLinks {
  final String? campaign;
  final String? launch;
  final String? media;
  final String? recovery;

  RedditLinks({this.campaign, this.launch, this.media, this.recovery});

  factory RedditLinks.fromJson(Map<String, dynamic> json) => _$RedditLinksFromJson(json);
  Map<String, dynamic> toJson() => _$RedditLinksToJson(this);

}