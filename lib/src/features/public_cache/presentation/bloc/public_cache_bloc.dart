import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/public_cache/domain/domain.dart';

part 'public_cache_event.dart';
part 'public_cache_state.dart';

@injectable
class PublicCacheBloc extends Bloc<PublicCacheEvent, PublicCacheState> {
  PublicCacheBloc({
    required PublicCacheUseCase publicCacheUseCase,
  })  : _publicCacheUseCase = publicCacheUseCase,
        super(PublicCacheState.initial()) {
    on<PublicCacheLoaded>(_onPublicCacheLoaded);
  }
  final PublicCacheUseCase _publicCacheUseCase;

  Future<void> _onPublicCacheLoaded(
    PublicCacheLoaded event,
    Emitter<PublicCacheState> emit,
  ) async {
    const pageSize = 10;
    const pageId = 1;
    if (state.status == PublicCacheStatus.initial ||
        state.status == PublicCacheStatus.loading) {
      emit(
        state.copyWith(
          status: PublicCacheStatus.loading,
          pageId: 1,
          hasReachedMax: false,
        ),
      );

      final response = await _publicCacheUseCase.listPublicCaches(
        pageSize: pageSize,
        pageId: pageId,
        tagIds: event.tagIds,
      );

      response.fold(
        (failure) {
          emit(
            state.copyWith(
              status: PublicCacheStatus.failure,
              failure: failure,
            ),
          );
        },
        (cacheList) {
          emit(
            state.copyWith(
              cacheList: cacheList,
              hasReachedMax: cacheList.length < pageSize,
              status: PublicCacheStatus.success,
            ),
          );
        },
      );
    } else {
      if (state.hasReachedMax) return;

      final response = await _publicCacheUseCase.listPublicCaches(
        pageSize: pageSize,
        pageId: state.pageId + 1,
        tagIds: event.tagIds,
      );

      response.fold(
        (failure) {
          emit(
            state.copyWith(
              status: PublicCacheStatus.failure,
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
                status: PublicCacheStatus.success,
              ),
            );
          }
        },
      );
    }
  }
}
