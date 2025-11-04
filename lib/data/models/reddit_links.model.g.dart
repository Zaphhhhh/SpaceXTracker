// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_links.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditLinks _$RedditLinksFromJson(Map<String, dynamic> json) => RedditLinks(
  campaign: json['campaign'] as String?,
  launch: json['launch'] as String?,
  media: json['media'] as String?,
  recovery: json['recovery'] as String?,
);

Map<String, dynamic> _$RedditLinksToJson(RedditLinks instance) =>
    <String, dynamic>{
      'campaign': instance.campaign,
      'launch': instance.launch,
      'media': instance.media,
      'recovery': instance.recovery,
    };
