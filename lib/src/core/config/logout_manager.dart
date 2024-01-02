import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/routes/app_router.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';

class LogoutManager {
  factory LogoutManager() => LogoutManager._internal();
  LogoutManager._internal();

  static Future<void> performLogout() async {
    final authBloc = getIt<AuthBloc>();
    authBloc.add(AuthLogoutRequested());
    final navigatorKeyContext =
        AppRouter().router.routerDelegate.navigatorKey.currentContext;

    if (navigatorKeyContext != null) {
      Navigator.of(navigatorKeyContext, rootNavigator: true).popUntil(
        (route) => route.isFirst,
      );
      await GoRouter.of(navigatorKeyContext).pushReplacement('/login');
    }
  }
}
