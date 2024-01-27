part of 'tag_bloc.dart';

enum TagStatus { initial, loading, success, failure }

class TagState extends Equatable {
  const TagState({
    required this.status,
    required this.tags,
    required this.selectedTags,
    required this.failure,
  });

  factory TagState.initial() => const TagState(
        status: TagStatus.initial,
        tags: [],
        selectedTags: {},
        failure: null,
      );

  final TagStatus status;
  final List<Tag?> tags;
  final Map<int, Tag?> selectedTags;
  final Failure? failure;

  TagState copyWith({
    TagStatus? status,
    List<Tag?>? tags,
    Map<int, Tag?>? selectedTags,
    Failure? failure,
  }) {
    return TagState(
      status: status ?? this.status,
      tags: tags ?? this.tags,
      selectedTags: selectedTags ?? this.selectedTags,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tags,
        selectedTags,
        failure,
      ];
}
