class CacheAddTagsReq {
  CacheAddTagsReq({
    required this.tagIds,
  });
  final List<int?> tagIds;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tag_ids': tagIds,
    };
  }

  @override
  String toString() => 'CacheAddTagsReq(tagIds: $tagIds)';
}
