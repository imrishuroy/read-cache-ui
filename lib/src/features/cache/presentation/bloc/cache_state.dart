part of 'cache_bloc.dart';

enum CacheStatus {
  initial,
  loading,
  success,
  failure,
}

class CacheState extends Equatable {
  const CacheState({
    required this.status,
    required this.cacheList,
    this.pageId = 1,
    this.hasReachedMax = false,
    this.failure,
  });

  factory CacheState.initial() => const CacheState(
        status: CacheStatus.initial,
        cacheList: [],
      );

  final CacheStatus status;
  final List<Cache?> cacheList;
  final int pageId;
  final bool hasReachedMax;
  final Failure? failure;

  CacheState copyWith({
    CacheStatus? status,
    List<Cache?>? cacheList,
    int? pageId,
    bool? hasReachedMax,
    Failure? failure,
  }) {
    return CacheState(
      status: status ?? this.status,
      cacheList: cacheList ?? this.cacheList,
      pageId: pageId ?? this.pageId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failure: failure ?? this.failure,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        status,
        cacheList,
        pageId,
        hasReachedMax,
        failure,
      ];
}
