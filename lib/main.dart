import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:read_cache_ui/firebase_options.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/config/shared_prefs.dart';
import 'package:read_cache_ui/src/core/network/auth_interceptor.dart';
import 'package:read_cache_ui/src/core/network/firebase_performance_service.dart';
import 'package:read_cache_ui/src/core/routes/app_router.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  getIt<Dio>().interceptors.add(AuthInterceptor());
  await SharedPrefs.init();
  await FirebasePerformanceService.setPerformanceCollectionEnabled(
    enabled: true,
  );
  runApp(const ReadCache());
}

class ReadCache extends StatelessWidget {
  const ReadCache({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Read Cache',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter.router,
      darkTheme: ThemeData.dark(
        useMaterial3: false,
      ),
    );
  }
}
