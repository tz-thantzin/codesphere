// lib/data/repositories/contact_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart' as fb;
import 'package:logger/logger.dart';

import '../../domain/repositories/contact_repository.dart';
import '../../models/contact.dart';
import '../data_sources/contact_datasource.dart';

class ContactRepositoryImpl implements ContactRepository {
  ContactRepositoryImpl(this._datasource);

  final ContactDatasource _datasource;
  final Logger _logger = Logger();

  @override
  Future<void> sendMessage(Contact contact) async {
    try {
      await _datasource.sendMessage(contact);
    } on fb.FirebaseException catch (e) {
      _logger.e("Firebase error: ${e.message}");
      throw Exception("Failed to send message: ${e.message}");
    } catch (e) {
      _logger.e("Unknown error: $e");
      throw Exception("Something went wrong. Please try again.");
    }
  }
}
