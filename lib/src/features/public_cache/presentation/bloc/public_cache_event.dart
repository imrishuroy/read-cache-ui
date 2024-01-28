part of 'public_cache_bloc.dart';

abstract class PublicCacheEvent extends Equatable {
  const PublicCacheEvent();

  @override
  List<Object> get props => [];
}

class PublicCacheLoaded extends PublicCacheEvent {
  const PublicCacheLoaded({
    required this.tagIds,
  });

  final List<int> tagIds;

  @override
  List<Object> get props => [
        tagIds,
      ];
}
