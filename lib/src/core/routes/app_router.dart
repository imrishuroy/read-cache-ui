import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/cache/presentation/pages/caches_list_page.dart';
import 'package:read_cache_ui/src/features/splash/splash_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashPage(),
        ),
      ),
      GoRoute(
        path: '/signin',
        pageBuilder: (context, state) => const MaterialPage(
          child: SignInPage(),
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) => const MaterialPage(
          child: SignUpPage(),
        ),
      ),
      GoRoute(
        path: '/create-user/:email',
        pageBuilder: (context, state) => MaterialPage(
          child: CreateUserPage(
            email: state.pathParameters['email'],
          ),
        ),
      ),
      GoRoute(
        path: '/caches',
        pageBuilder: (context, state) => const MaterialPage(
          child: CachesListPage(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => const MaterialPage(
      child: Scaffold(
        body: Center(
          child: Text(
            '404: Not Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
