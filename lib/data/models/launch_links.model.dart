import 'package:spacex_app/data/models/patch_links.model.dart';
import 'package:spacex_app/data/models/reddit_links.model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'flickr_links.model.dart';

part 'launch_links.model.g.dart';
@JsonSerializable()
class LaunchLinks {
  final PatchLinks? patch;
  final RedditLinks? reddit;
  final FlickrLinks? flickr;
  final String? presskit;
  final String? webcast;
  final String? youtubeId;
  final String? article;
  final String? wikipedia;

  LaunchLinks({
    required this.patch,
    required this.reddit,
    required this.flickr,
    this.presskit,
    this.webcast,
    this.youtubeId,
    this.article,
    this.wikipedia,
  });

  factory LaunchLinks.fromJson(Map<String, dynamic> json) => _$LaunchLinksFromJson(json);
  Map<String, dynamic> toJson() => _$LaunchLinksToJson(this);
}


