import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:read_cache_ui/firebase_options.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/network/auth_interceptor.dart';
import 'package:read_cache_ui/src/core/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  getIt<Dio>().interceptors.add(AuthInterceptor());
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
      darkTheme: ThemeData.dark(),
    );
  }
}
