import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_cache_ui/src/features/tag/presentation/presentation.dart';

class TagsWrap extends StatefulWidget {
  const TagsWrap({
    required this.tagBloc,
    super.key,
  });

  final TagBloc tagBloc;

  @override
  State<TagsWrap> createState() => _TagsWrapState();
}

class _TagsWrapState extends State<TagsWrap> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      bloc: widget.tagBloc,
      builder: (context, state) {
        if (state.status == TagStatus.success) {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: state.tags
                .map(
                  (tag) => GestureDetector(
                    onTap: () {
                      widget.tagBloc.add(
                        TagSelected(
                          tag: tag,
                        ),
                      );
                    },
                    child: Chip(
                      backgroundColor:
                          state.selectedTags.containsKey(tag?.tagId)
                              ? Colors.blue
                              : null,
                      label: Text(tag?.tagName ?? 'N/A'),
                    ),
                  ),
                )
                .toList(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
