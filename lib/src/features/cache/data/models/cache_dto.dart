import 'package:read_cache_ui/src/core/utils/date_time_util.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';

class CacheDto extends Cache {
  const CacheDto({
    required super.title,
    required super.link,
    super.id,
    super.owner,
    super.createdAt,
  });

  factory CacheDto.fromJson(Map<String, dynamic> map) {
    return CacheDto(
      id: map['id'] != null ? map['id'] as int : null,
      owner: map['owner'] != null ? map['owner'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      createdAt: map['created_at'] != null
          ? DateTimeUtil.getFormatedDateTime(map['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = <String, dynamic>{
      'title': title,
      'link': link,
    };
    if (id != null) {
      jsonMap['id'] = id;
    }

    return jsonMap;
  }
}
