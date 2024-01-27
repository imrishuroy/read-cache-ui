import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
class Tag with _$Tag {
  const factory Tag({
    @JsonKey(name: 'tag_name') required String tagName,
    @JsonKey(name: 'tag_id', includeIfNull: false) int? tagId,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
