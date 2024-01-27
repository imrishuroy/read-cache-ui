part of 'cache_bloc.dart';

enum CacheStatus {
  initial,
  loading,
  success,
  failure,
}

enum CacheActionStatus {
  initial,
  created,
  updated,
  deleted,
}

class CacheState extends Equatable {
  const CacheState({
    required this.status,
    required this.actionStatus,
    required this.cacheList,
    this.pageId = 1,
    this.hasReachedMax = false,
    this.failure,
  });

  factory CacheState.initial() => const CacheState(
        status: CacheStatus.initial,
        actionStatus: CacheActionStatus.initial,
        cacheList: [],
      );

  final CacheStatus status;
  final CacheActionStatus actionStatus;
  final List<Cache?> cacheList;

  final int pageId;
  final bool hasReachedMax;
  final Failure? failure;

  CacheState copyWith({
    CacheStatus? status,
    CacheActionStatus? actionStatus,
    List<Cache?>? cacheList,
    int? pageId,
    bool? hasReachedMax,
    Failure? failure,
  }) {
    return CacheState(
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
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
        actionStatus,
        cacheList,
        pageId,
        hasReachedMax,
        failure,
      ];
}
