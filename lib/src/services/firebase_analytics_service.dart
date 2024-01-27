import 'package:firebase_analytics/firebase_analytics.dart';

final _analytics = FirebaseAnalytics.instance;

class FirebaseAnalyticsService {
  factory FirebaseAnalyticsService() => FirebaseAnalyticsService._internal();
  FirebaseAnalyticsService._internal();

  static Future<void> logScreenViewEvent(
    String screenName,
  ) async {
    await _analytics.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': screenName,
        'firebase_screen_class': screenName,
      },
    );

    // firebaseAnalytics.logEvent(
    //   name: 'screen_view',
    //   parameters: {
    //     'screen_name': screenName,
    //   },
    // );
  }

  static Future<void> logCustomEvent({
    required String eventName,
    Map<String, dynamic>? parameters,
  }) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  // FirebaseAnalyticsObserver get observer =>
  //     FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);
}
