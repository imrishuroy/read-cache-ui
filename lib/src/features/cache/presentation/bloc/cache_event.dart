part of 'cache_bloc.dart';

abstract class CacheEvent extends Equatable {
  const CacheEvent();

  @override
  List<Object> get props => [];
}

class CacheListLoaded extends CacheEvent {}

class CacheCreated extends CacheEvent {
  const CacheCreated({
    required this.title,
    required this.content,
    required this.tags,
  });

  final String title;
  final String content;
  final List<int?> tags;

  @override
  List<Object> get props => [title, content, tags];
}

class CacheUpdated extends CacheEvent {
  const CacheUpdated({
    required this.cache,
    required this.tags,
  });

  final Cache cache;
  final List<int?> tags;

  @override
  List<Object> get props => [cache, tags];
}

class CacheDeleted extends CacheEvent {
  const CacheDeleted({
    required this.id,
  });

  final int id;
}
