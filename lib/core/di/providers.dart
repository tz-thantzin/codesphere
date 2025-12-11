import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_sources/contact_datasource.dart';
import '../../data/repositories/contact_repository_impl.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../domain/usecases/contact_message.dart';
import '../../presentation/viewmodels/contact_viewmodel.dart';
import '../services/analytics_service.dart';
import '../state/contact_state.dart';

final analyticsProvider = Provider<AnalyticsService>(
  (ref) => AnalyticsService(),
);

final contactDatasourceProvider = Provider<ContactDatasource>((ref) {
  return ContactDatasource();
});

final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  final datasource = ref.read(contactDatasourceProvider);
  return ContactRepositoryImpl(datasource);
});

final sendContactMessageProvider = Provider<ContactMessage>((ref) {
  final repo = ref.read(contactRepositoryProvider);
  return ContactMessage(repo);
});

final contactViewModelProvider =
    NotifierProvider<ContactViewModel, ContactState>(() {
      return ContactViewModel();
    });
