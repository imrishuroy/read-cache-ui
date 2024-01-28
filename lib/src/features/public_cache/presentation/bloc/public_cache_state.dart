part of 'public_cache_bloc.dart';

enum PublicCacheStatus { initial, loading, success, failure }

class PublicCacheState extends Equatable {
  const PublicCacheState({
    required this.status,
    required this.cacheList,
    required this.pageId,
    required this.hasReachedMax,
    required this.failure,
  });

  factory PublicCacheState.initial() {
    return const PublicCacheState(
      status: PublicCacheStatus.initial,
      pageId: 1,
      hasReachedMax: false,
      cacheList: [],
      failure: null,
    );
  }

  final PublicCacheStatus status;
  final List<Cache?> cacheList;
  final int pageId;
  final bool hasReachedMax;
  final Failure? failure;

  PublicCacheState copyWith({
    PublicCacheStatus? status,
    List<Cache?>? cacheList,
    int? pageId,
    bool? hasReachedMax,
    Failure? failure,
  }) {
    return PublicCacheState(
      status: status ?? this.status,
      cacheList: cacheList ?? this.cacheList,
      pageId: pageId ?? this.pageId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        cacheList,
        pageId,
        hasReachedMax,
        failure,
      ];
}
