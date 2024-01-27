import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/tag/presentation/presentation.dart';
import 'package:timeago/timeago.dart' as timeago;

class CacheDetailsPage extends StatelessWidget {
  const CacheDetailsPage({
    super.key,
    this.cache,
  });

  static const name = 'CacheDetailsPage';
  final Cache? cache;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cache Details'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => context.goNamed(
              UpdateCachePage.name,
              pathParameters: {'id': '${cache?.id}'},
              extra: cache,
            ),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
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
            const SizedBox(height: 16),
            if (cache?.id != null) CacheTags(cacheId: cache?.id ?? 0),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                const Spacer(),
                const Text(
                  'Make it public',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Switch.adaptive(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
