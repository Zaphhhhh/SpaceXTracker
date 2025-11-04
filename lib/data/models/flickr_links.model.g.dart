// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flickr_links.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlickrLinks _$FlickrLinksFromJson(Map<String, dynamic> json) => FlickrLinks(
  small: (json['small'] as List<dynamic>?)?.map((e) => e as String).toList(),
  original: (json['original'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$FlickrLinksToJson(FlickrLinks instance) =>
    <String, dynamic>{'small': instance.small, 'original': instance.original};
