import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/data/data.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:stream_transform/stream_transform.dart';

part 'cache_event.dart';
part 'cache_state.dart';

const _throttleDuration = Duration(milliseconds: 50);
EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CacheBloc extends Bloc<CacheEvent, CacheState> {
  CacheBloc({
    required CacheUseCase cacheUseCase,
  })  : _cacheUseCase = cacheUseCase,
        super(CacheState.initial()) {
    on<CacheListLoaded>(
      _onCacheListLoaded,
      transformer: _throttleDroppable(
        _throttleDuration,
      ),
    );
    on<CacheCreated>(_onCacheCreated);
  }
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
    final response = await _cacheUseCase.createCache(
      cacheDto: CacheDto(
        title: event.title,
        link: event.link,
      ),
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
}
