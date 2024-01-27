import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/features/tag/data/data.dart';
import 'package:read_cache_ui/src/features/tag/domain/domain.dart';

part 'tag_event.dart';
part 'tag_state.dart';

@injectable
class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc({required TagUseCase tagUseCase})
      : _tagUseCase = tagUseCase,
        super(TagState.initial()) {
    on<InitTagsSelected>(_onInitTagsSelected);
    on<TagListLoaded>(_onTagListLoaded);
    on<TagCreated>(_onTagCreated);
    on<TagSelected>(_onTagSelected);
    on<CacheAddedTags>(_onCacheAddedTags);
    on<CacheTagsLoaded>(_onCacheTagsLoaded);
  }

  final TagUseCase _tagUseCase;

  Future<void> _onInitTagsSelected(
    InitTagsSelected event,
    Emitter<TagState> emit,
  ) async {
    final response = await _tagUseCase.listTagsByCacheId(
      cacheId: event.cacheId,
    );

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TagStatus.failure,
            failure: failure,
          ),
        );
      },
      (tags) {
        emit(
          state.copyWith(
            status: TagStatus.success,
            selectedTags: {
              for (final tag in tags)
                if (tag?.tagId != null) tag!.tagId!: tag,
            },
          ),
        );
      },
    );
  }

  Future<void> _onTagListLoaded(
    TagListLoaded event,
    Emitter<TagState> emit,
  ) async {
    final response = await _tagUseCase.getTags();
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TagStatus.failure,
            failure: failure,
          ),
        );
      },
      (tags) {
        emit(
          state.copyWith(
            status: TagStatus.success,
            tags: tags,
          ),
        );
      },
    );
  }

  Future<void> _onTagCreated(
    TagCreated event,
    Emitter<TagState> emit,
  ) async {
    final response = await _tagUseCase.createTag(
      tag: event.tag,
    );
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TagStatus.failure,
            failure: failure,
          ),
        );
      },
      (tag) {
        emit(
          state.copyWith(
            status: TagStatus.success,
            tags: [...state.tags, tag],
          ),
        );
      },
    );
  }

  void _onTagSelected(
    TagSelected event,
    Emitter<TagState> emit,
  ) {
    final tadId = event.tag?.tagId;
    if (tadId == null) return;

    if (state.selectedTags.containsKey(tadId)) {
      final selectedTags = Map<int, Tag?>.from(state.selectedTags);
      emit(
        state.copyWith(
          selectedTags: selectedTags..remove(tadId),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedTags: {
            ...state.selectedTags,
            tadId: event.tag,
          },
        ),
      );
    }
  }

  Future<void> _onCacheAddedTags(
    CacheAddedTags event,
    Emitter<TagState> emit,
  ) async {
    final response = await _tagUseCase.addTagToCache(
      cacheId: event.cacheId,
      cacheAddTagsReq: CacheAddTagsReq(
        tagIds: event.tags,
      ),
    );
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TagStatus.failure,
            failure: failure,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            status: TagStatus.success,
          ),
        );
      },
    );
  }

  Future<void> _onCacheTagsLoaded(
    CacheTagsLoaded event,
    Emitter<TagState> emit,
  ) async {
    final response = await _tagUseCase.listTagsByCacheId(
      cacheId: event.cacheId,
    );
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TagStatus.failure,
            failure: failure,
          ),
        );
      },
      (tags) {
        emit(
          state.copyWith(
            status: TagStatus.success,
            tags: tags,
          ),
        );
      },
    );
  }
}
