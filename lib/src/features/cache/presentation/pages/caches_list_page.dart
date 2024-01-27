import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/network/firebase_performance_service.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';
import 'package:read_cache_ui/src/services/services.dart';

class CachesListPage extends StatefulWidget {
  const CachesListPage({super.key});

  static const name = 'CachesListPage';

  @override
  State<CachesListPage> createState() => _CachesListPageState();
}

class _CachesListPageState extends State<CachesListPage> {
  final _authBloc = getIt<AuthBloc>();
  final _cacheBloc = getIt<CacheBloc>();
  final _scrollController = ScrollController();
  late DateTime _starTime;
  late DateTime _endTime;

  @override
  void initState() {
    FirebaseAnalyticsService.logScreenViewEvent(CachesListPage.name);
    _starTime = DateTime.now();
    _cacheBloc.add(
      CacheListLoaded(),
    );
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _endTime = DateTime.now();
      final difference = _endTime.difference(_starTime);
      //debugPrint('page load: ${difference.inMilliseconds}ms');
      FirebasePerformanceService.setPageLoad(
        pageName: 'caches_list',
        value: difference.inMilliseconds,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(
          CreateCachePage.name,
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
              context.goNamed(SignInPage.name);
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
          if (state.status == CacheStatus.success &&
              state.actionStatus == CacheActionStatus.deleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cache Deleted'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == CacheStatus.success) {
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
                          return Dismissible(
                            key: Key('${cache?.id}'),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                if (cache?.id != null) {
                                  _cacheBloc.add(
                                    CacheDeleted(
                                      id: cache!.id!,
                                    ),
                                  );
                                }
                              } else {
                                context.goNamed(
                                  UpdateCachePage.name,
                                  pathParameters: {'id': '${cache?.id}'},
                                  extra: cache,
                                );
                              }
                            },
                            background: const ColoredBox(
                              color: Colors.green,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Icon(Icons.edit),
                                ),
                              ),
                            ),
                            secondaryBackground: ColoredBox(
                              color: Colors.red.shade500,
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            ),
                            child: CacheTile(
                              cache: cache,
                              index: index,
                            ),
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
