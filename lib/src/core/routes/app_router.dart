import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/shared_prefs.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/splash/splash_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'parent');

class AppRouter {
  GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: SplashPage.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashPage(),
        ),
      ),
      GoRoute(
        path: '/signin',
        name: SignInPage.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignInPage(),
        ),
      ),
      GoRoute(
        path: '/signup',
        name: SignUpPage.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignUpPage(),
        ),
      ),
      GoRoute(
        path: '/create-user/:email',
        name: CreateUserPage.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => MaterialPage(
          child: CreateUserPage(
            email: state.pathParameters['email'],
          ),
        ),
      ),
      GoRoute(
        path: '/caches',
        name: CachesListPage.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const MaterialPage(
          child: CachesListPage(),
        ),
      ),
      GoRoute(
        path: '/cache/:id',
        name: CacheDetailsPage.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => MaterialPage(
          child: CacheDetailsPage(
            cache: state.extra as Cache?,
          ),
        ),
      ),
      GoRoute(
        path: '/create-cache',
        name: CreateCachePage.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const MaterialPage(
          child: CreateCachePage(),
        ),
      ),
      GoRoute(
        path: '/update-cache/:id',
        name: UpdateCachePage.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => MaterialPage(
          child: UpdateCachePage(
            cache: state.extra as Cache?,
          ),
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
    observers: [
      //  GoRouterObserver(),
    ],
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      if (state.path == '/signin') {
        final token = SharedPrefs.getToken();
        if (token != null) {
          return '/caches';
        } else {
          return '/signin';
        }
      }
      return null;
    },
  );
}

// class GoRouterObserver extends NavigatorObserver {
//   @override
//   Future<void> didPush(Route route, Route? previousRoute) async {
//     debugPrint('screen name1 $route');
//     if (route.settings.name != null) {
//       debugPrint('screen name ${route.settings.name}');
//     }

//     if (kReleaseMode) {
//       await FirebaseAnalytics.instance.logEvent(
//         name: 'screen_view',
//         parameters: {
//           'firebase_screen': route.settings.name,
//           'firebase_screen_class': route.settings.name,
//         },
//       );
//     }
//   }
// }
