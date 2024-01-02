import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/shared_prefs.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        final token = SharedPrefs.getToken();
        if (token != null) {
          context.go('/caches');
        } else {
          context.go('/login');
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
