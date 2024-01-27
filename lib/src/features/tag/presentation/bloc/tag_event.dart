part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();

  @override
  List<Object> get props => [];
}

class InitTagsSelected extends TagEvent {
  const InitTagsSelected({
    required this.cacheId,
  });

  final int cacheId;

  @override
  List<Object> get props => [cacheId];
}

class TagListLoaded extends TagEvent {}

class TagCreated extends TagEvent {
  const TagCreated({required this.tag});

  final Tag tag;

  @override
  List<Object> get props => [tag];
}

class TagSelected extends TagEvent {
  const TagSelected({required this.tag});

  final Tag? tag;
}

class CacheAddedTags extends TagEvent {
  const CacheAddedTags({
    required this.cacheId,
    required this.tags,
    this.isFromCacheEdit = false,
  });

  final int cacheId;
  final List<int?> tags;
  final bool isFromCacheEdit;

  @override
  List<Object> get props => [cacheId, tags, isFromCacheEdit];
}

class CacheTagsLoaded extends TagEvent {
  const CacheTagsLoaded({
    required this.cacheId,
  });

  final int cacheId;

  @override
  List<Object> get props => [cacheId];
}
