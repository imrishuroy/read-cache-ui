import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/shared_prefs.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';
import 'package:read_cache_ui/src/services/services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const name = 'SplashPage';
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    FirebaseAnalyticsService.logScreenViewEvent(SplashPage.name);
    Future.delayed(
      const Duration(seconds: 3),
      () {
        final token = SharedPrefs.getToken();
        final appUser = SharedPrefs.getUser();

        if (token != null && appUser != null) {
          context.goNamed(CachesPage.name);
        } else {
          context.goNamed(SignInPage.name);
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularMovingWidget(),
          SizedBox(
            height: 20,
          ),
          Text(
            'Read Cache',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularMovingWidget extends StatefulWidget {
  const CircularMovingWidget({super.key});

  @override
  CircularMovingWidgetState createState() => CircularMovingWidgetState();
}

class CircularMovingWidgetState extends State<CircularMovingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _animationController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: _animationController!.value * 2 * math.pi,
        child: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100 / 2),
              child: Image.asset(
                'assets/images/read-cache.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
