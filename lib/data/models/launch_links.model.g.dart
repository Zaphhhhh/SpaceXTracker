// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_links.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchLinks _$LaunchLinksFromJson(Map<String, dynamic> json) => LaunchLinks(
  patch: json['patch'] == null
      ? null
      : PatchLinks.fromJson(json['patch'] as Map<String, dynamic>),
  reddit: json['reddit'] == null
      ? null
      : RedditLinks.fromJson(json['reddit'] as Map<String, dynamic>),
  flickr: json['flickr'] == null
      ? null
      : FlickrLinks.fromJson(json['flickr'] as Map<String, dynamic>),
  presskit: json['presskit'] as String?,
  webcast: json['webcast'] as String?,
  youtubeId: json['youtubeId'] as String?,
  article: json['article'] as String?,
  wikipedia: json['wikipedia'] as String?,
);

Map<String, dynamic> _$LaunchLinksToJson(LaunchLinks instance) =>
    <String, dynamic>{
      'patch': instance.patch,
      'reddit': instance.reddit,
      'flickr': instance.flickr,
      'presskit': instance.presskit,
      'webcast': instance.webcast,
      'youtubeId': instance.youtubeId,
      'article': instance.article,
      'wikipedia': instance.wikipedia,
    };
