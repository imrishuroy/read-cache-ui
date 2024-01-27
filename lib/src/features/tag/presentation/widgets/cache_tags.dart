import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/features/tag/presentation/presentation.dart';

class CacheTags extends StatefulWidget {
  const CacheTags({required this.cacheId, super.key});

  final int cacheId;

  @override
  State<CacheTags> createState() => _CacheTagsState();
}

class _CacheTagsState extends State<CacheTags> {
  final _tagBloc = getIt<TagBloc>();

  @override
  void initState() {
    _tagBloc.add(
      CacheTagsLoaded(
        cacheId: widget.cacheId,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      bloc: _tagBloc,
      builder: (context, state) {
        if (state.status == TagStatus.success) {
          final tags = state.tags;
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in tags)
                Chip(
                  label: Text(tag?.tagName ?? ''),
                ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
