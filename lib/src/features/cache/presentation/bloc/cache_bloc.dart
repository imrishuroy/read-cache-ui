import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/tag/presentation/bloc/tag_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'cache_event.dart';
part 'cache_state.dart';

const _throttleDuration = Duration(milliseconds: 50);
EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

// @injectable
class CacheBloc extends Bloc<CacheEvent, CacheState> {
  CacheBloc({
    required CacheUseCase cacheUseCase,
    required TagBloc tagBloc,
  })  : _tagBloc = tagBloc,
        _cacheUseCase = cacheUseCase,
        super(CacheState.initial()) {
    on<CacheListLoaded>(
      _onCacheListLoaded,
      transformer: _throttleDroppable(
        _throttleDuration,
      ),
    );
    on<CacheCreated>(_onCacheCreated);
    on<UpdateCacheInitialized>(_onUpdateCacheInitialized);
    on<CacheUpdated>(_onCacheUpdated);
    on<CacheDeleted>(_onCacheDeleted);
    on<CachePublicToggled>(_onCachePublicToggled);
  }

  final TagBloc _tagBloc;
  final CacheUseCase _cacheUseCase;

  Future<void> _onCacheListLoaded(
    CacheListLoaded event,
    Emitter<CacheState> emit,
  ) async {
    const pageSize = 10;
    const pageId = 1;
    if (state.status == CacheStatus.initial ||
        state.status == CacheStatus.loading) {
      emit(
        state.copyWith(
          status: CacheStatus.loading,
          pageId: 1,
          hasReachedMax: false,
        ),
      );

      final response = await _cacheUseCase.listCaches(
        pageSize: pageSize,
        pageId: pageId,
      );

      response.fold(
        (failure) {
          emit(
            state.copyWith(
              status: CacheStatus.failure,
              failure: failure,
            ),
          );
        },
        (cacheList) {
          emit(
            state.copyWith(
              cacheList: cacheList,
              hasReachedMax: cacheList.length < pageSize,
              status: CacheStatus.success,
            ),
          );
        },
      );
    } else {
      if (state.hasReachedMax) return;

      final response = await _cacheUseCase.listCaches(
        pageSize: pageSize,
        pageId: state.pageId + 1,
      );

      response.fold(
        (failure) {
          emit(
            state.copyWith(
              status: CacheStatus.failure,
              failure: failure,
            ),
          );
        },
        (cacheList) {
          if (cacheList.isEmpty) {
            return emit(
              state.copyWith(
                hasReachedMax: true,
              ),
            );
          } else {
            emit(
              state.copyWith(
                cacheList: [
                  ...state.cacheList,
                  ...cacheList,
                ],
                hasReachedMax: cacheList.length < pageSize,
                pageId: state.pageId + 1,
                status: CacheStatus.success,
              ),
            );
          }
        },
      );
    }
  }

  Future<void> _onCacheCreated(
    CacheCreated event,
    Emitter<CacheState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CacheStatus.loading,
      ),
    );
    debugPrint('CacheCreated: ${event.cache.toJson()}');
    final response = await _cacheUseCase.createCache(
      cache: event.cache,
    );
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CacheStatus.failure,
            failure: failure,
          ),
        );
      },
      (cache) {
        if (cache?.id == null) return;

        _tagBloc.add(
          CacheAddedTags(
            cacheId: cache!.id!,
            tags: event.tags,
          ),
        );

        emit(
          state.copyWith(
            // cacheList: [
            //   cache,
            //   ...state.cacheList,
            // ],
            status: CacheStatus.success,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateCacheInitialized(
    UpdateCacheInitialized event,
    Emitter<CacheState> emit,
  ) async {
    emit(
      state.copyWith(
        updateCache: event.cache,
      ),
    );
  }

  Future<void> _onCacheUpdated(
    CacheUpdated event,
    Emitter<CacheState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CacheStatus.loading,
      ),
    );

    final cache = event.cache;

    final response = await _cacheUseCase.updateCache(
      cache: cache,
    );

    await response.fold((failure) {
      emit(
        state.copyWith(
          failure: failure,
          status: CacheStatus.failure,
        ),
      );
    }, (cache) async {
      if (cache?.id == null) return;

      await _cacheUseCase.deleteCacheTags(cacheId: cache!.id!);

      _tagBloc.add(
        CacheAddedTags(
          cacheId: cache.id!,
          tags: event.tags,
        ),
      );
      emit(
        state.copyWith(
          status: CacheStatus.success,
        ),
      );
    });
  }

  Future<void> _onCachePublicToggled(
    CachePublicToggled event,
    Emitter<CacheState> emit,
  ) async {
    if (state.updateCache?.isPublic == null) return;
    emit(
      state.copyWith(
        updateCache: state.updateCache?.copyWith(
          isPublic: !state.updateCache!.isPublic,
        ),
      ),
    );
  }

  Future<void> _onCacheDeleted(
    CacheDeleted event,
    Emitter<CacheState> emit,
  ) async {
    final response = await _cacheUseCase.deleteCache(
      id: event.id,
    );

    response.fold((failure) {
      emit(
        state.copyWith(
          failure: failure,
          status: CacheStatus.failure,
        ),
      );
    }, (cache) {
      emit(
        state.copyWith(
          cacheList: [
            ...state.cacheList.where(
              (element) => element?.id != event.id,
            ),
          ],
          actionStatus: CacheActionStatus.deleted,
          status: CacheStatus.success,
        ),
      );
    });
  }
}
