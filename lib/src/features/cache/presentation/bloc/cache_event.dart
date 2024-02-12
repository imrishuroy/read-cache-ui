part of 'cache_bloc.dart';

abstract class CacheEvent extends Equatable {
  const CacheEvent();

  @override
  List<Object> get props => [];
}

class CacheListLoaded extends CacheEvent {}

class CacheCreated extends CacheEvent {
  const CacheCreated({
    required this.cache,
    required this.tags,
  });

  final Cache cache;
  final List<int?> tags;

  @override
  List<Object> get props => [cache, tags];
}

class UpdateCacheInitialized extends CacheEvent {
  const UpdateCacheInitialized({
    required this.cache,
  });

  final Cache? cache;
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

class CachePublicToggled extends CacheEvent {}
