import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_cache_ui/src/features/tag/presentation/presentation.dart';

class TagFilterDialog extends StatefulWidget {
  const TagFilterDialog({
    required this.tagBloc,
    super.key,
  });

  final TagBloc tagBloc;

  @override
  State<TagFilterDialog> createState() => _TagFilterDialogState();
}

class _TagFilterDialogState extends State<TagFilterDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      bloc: widget.tagBloc,
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: TagsWrap(
            tagBloc: widget.tagBloc..add(TagListLoaded()),
          ),
        );
      },
    );
  }
}
