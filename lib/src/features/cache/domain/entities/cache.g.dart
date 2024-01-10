// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CacheImpl _$$CacheImplFromJson(Map<String, dynamic> json) => _$CacheImpl(
      title: json['title'] as String,
      link: json['link'] as String,
      id: json['id'] as int?,
      owner: json['owner'] as String?,
      createdAt: _$JsonConverterFromJson<String, DateTime?>(
          json['created_at'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$CacheImplToJson(_$CacheImpl instance) {
  final val = <String, dynamic>{
    'title': instance.title,
    'link': instance.link,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
