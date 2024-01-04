import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';

class CachesListPage extends StatefulWidget {
  const CachesListPage({super.key});

  @override
  State<CachesListPage> createState() => _CachesListPageState();
}

class _CachesListPageState extends State<CachesListPage> {
  final _authBloc = getIt<AuthBloc>();
  final _cacheBloc = getIt<CacheBloc>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _cacheBloc.add(
      CacheListLoaded(),
    );
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(
          '/create-cache',
        ),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Read Cache'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _authBloc.add(AuthSignOutRequested());
              context.go('/signin');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<CacheBloc, CacheState>(
        bloc: _cacheBloc,
        listener: (context, state) {
          if (state.status == CacheStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.failure?.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == CacheStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final cacheList = state.cacheList;
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
                        return CacheTile(
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
      _cacheBloc.add(
        CacheListLoaded(),
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
