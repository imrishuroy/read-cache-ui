import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';
import 'package:timeago/timeago.dart' as timeago;

class CacheTile extends StatelessWidget {
  const CacheTile({
    required this.cache,
    required this.index,
    super.key,
  });
  final Cache? cache;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50,
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              onTap: () => context.goNamed(
                CacheDetailsPage.name,
                pathParameters: {'id': '${cache?.id}'},
                extra: cache,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(cache?.title ?? '--'),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: ContentRichText(
                        content: cache?.content ?? '',
                      ),
                    ),
                    trailing: Text(
                      cache?.createdAt != null
                          ? timeago.format(cache!.createdAt!)
                          : '',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
