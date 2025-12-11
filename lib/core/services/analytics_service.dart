import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  Future<void> logButtonClick({
    required String buttonName,
    String? section,
  }) async {
    await _analytics.logEvent(
      name: 'button_click',
      parameters: {
        'button_name': buttonName,
        'section': section ?? 'unknown',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> logContactFormSubmitted() async {
    await _analytics.logEvent(
      name: 'contact_form_submitted',
      parameters: {'timestamp': DateTime.now().toIso8601String()},
    );
  }
}
