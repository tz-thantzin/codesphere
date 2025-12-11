import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../core/services/analytics_service.dart';
import '../../core/state/contact_state.dart';
import '../../domain/usecases/contact_message.dart';
import '../../models/contact_model.dart';

class ContactViewModel extends Notifier<ContactState> {
  late final ContactMessage contactMessage;
  late final AnalyticsService analytics;

  @override
  ContactState build() {
    contactMessage = ref.read(sendContactMessageProvider);
    analytics = ref.read(analyticsProvider);
    return const ContactState();
  }

  Future<void> submitContact({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      state = state.copyWith(error: "Please fill all required fields");
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final contact = ContactModel(
        name: name,
        email: email,
        phone: phone,
        message: message,
      );

      await contactMessage.sendMessage(contact);
      await analytics.logContactFormSubmitted();

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = const ContactState();
  }
}
