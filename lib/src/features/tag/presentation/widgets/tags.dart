import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_cache_ui/src/features/tag/presentation/presentation.dart';

class Tags extends StatefulWidget {
  const Tags({
    required this.tagBloc,
    this.cacheId,
    this.isFromEditCache = false,
    super.key,
  });

  final TagBloc tagBloc;
  final int? cacheId;
  final bool isFromEditCache;

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  @override
  void initState() {
    if (widget.isFromEditCache && widget.cacheId != null) {
      widget.tagBloc.add(
        InitTagsSelected(
          cacheId: widget.cacheId!,
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      bloc: widget.tagBloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Tags',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CreateTagDialog(
                          tagBloc: widget.tagBloc,
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 16,
                  ),
                  label: const Text(
                    'Create Tag',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TagsWrap(
              tagBloc: widget.tagBloc..add(TagListLoaded()),
            ),
          ],
        );
      },
    );
  }
}
