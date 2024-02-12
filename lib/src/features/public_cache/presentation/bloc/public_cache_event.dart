part of 'public_cache_bloc.dart';

abstract class PublicCacheEvent extends Equatable {
  const PublicCacheEvent();

  @override
  List<Object> get props => [];
}

class PublicCacheLoaded extends PublicCacheEvent {
  const PublicCacheLoaded({
    required this.tagIds,
    this.pageSize,
    this.pageId,
  });

  final int? pageSize;
  final int? pageId;
  final List<int> tagIds;
}

class TagsSelected extends PublicCacheEvent {
  const TagsSelected({
    required this.selectedTags,
  });

  final List<Tag?> selectedTags;

  @override
  List<Object> get props => [
        selectedTags,
      ];
}
