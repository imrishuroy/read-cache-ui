// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CacheImpl _$$CacheImplFromJson(Map<String, dynamic> json) => _$CacheImpl(
      title: json['title'] as String,
      content: json['content'] as String,
      id: json['id'] as int?,
      owner: json['owner'] as String?,
      createdAt: _$JsonConverterFromJson<String, DateTime?>(
          json['created_at'], const DateTimeConverter().fromJson),
      isPublic: json['is_public'] as bool? ?? false,
    );

Map<String, dynamic> _$$CacheImplToJson(_$CacheImpl instance) {
  final val = <String, dynamic>{
    'title': instance.title,
    'content': instance.content,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['is_public'] = instance.isPublic;
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
