import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';

class CachesListPage extends StatefulWidget {
  const CachesListPage({super.key});

  @override
  State<CachesListPage> createState() => _CachesListPageState();
}

class _CachesListPageState extends State<CachesListPage> {
  final _authBloc = getIt<AuthBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () async {
          _authBloc.add(AuthSignOutRequested());
          context.go('/login');
        },
      ),
      body: const Center(
        child: Text('Caches'),
      ),
    );
  }
}
