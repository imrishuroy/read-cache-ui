import 'package:firebase_performance/firebase_performance.dart';

final _performance = FirebasePerformance.instance;

class FirebasePerformanceService {
  FirebasePerformanceService._();

  static Future<void> setPerformanceCollectionEnabled({
    required bool enabled,
  }) async {
    await _performance.setPerformanceCollectionEnabled(
      enabled,
    );
  }

  static Future<void> setPageLoad({
    required String pageName,
    required int value,
  }) async {
    final trace = _performance.newTrace('page_load');
    await trace.start();
    trace.setMetric(pageName, value);
    await trace.stop();
  }
}
