import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_cache_ui/src/core/utils/date_time_util.dart';

part 'cache.freezed.dart';
part 'cache.g.dart';

@freezed
class Cache with _$Cache {
  const factory Cache({
    required String title,
    required String content,
    @JsonKey(includeIfNull: false) int? id,
    @JsonKey(includeToJson: false) String? owner,
    @DateTimeConverter()
    @JsonKey(name: 'created_at', includeToJson: false)
    DateTime? createdAt,
    @JsonKey(name: 'is_public', includeToJson: true)
    @Default(false)
    bool isPublic,
  }) = _Cache;

  factory Cache.fromJson(Map<String, dynamic> json) => _$CacheFromJson(json);
}

class DateTimeConverter implements JsonConverter<DateTime?, String> {
  const DateTimeConverter();
  @override
  DateTime fromJson(String json) {
    return DateTimeUtil.getFormatedDateTime(json);
  }

  @override
  String toJson(DateTime? object) {
    return '';
  }
}
