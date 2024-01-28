import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/features/public_cache/presentation/presentation.dart';

class PublicCachesPage extends StatefulWidget {
  const PublicCachesPage({super.key});

  static const String name = 'Public Caches';

  @override
  State<PublicCachesPage> createState() => _PublicCachesPageState();
}

class _PublicCachesPageState extends State<PublicCachesPage> {
  final _publicCacheBloc = getIt<PublicCacheBloc>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _publicCacheBloc.add(
      const PublicCacheLoaded(
        tagIds: [],
      ),
    );
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Caches'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<PublicCacheBloc, PublicCacheState>(
        bloc: _publicCacheBloc,
        listener: (context, state) {
          if (state.status == PublicCacheStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.failure?.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == PublicCacheStatus.success) {
            final cacheList = state.cacheList;
            if (cacheList.isEmpty) {
              return const Center(
                child: Text('No Cache Found'),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: state.hasReachedMax
                            ? cacheList.length
                            : cacheList.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= cacheList.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }
                          final cache = cacheList[index];
                          return PublicCacheTile(
                            cache: cache,
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) {
      _publicCacheBloc.add(
        const PublicCacheLoaded(
          tagIds: [],
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
