// lib/data/data_sources/contact_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../models/contact.dart';

class ContactDatasource {
  final FirebaseFirestore _firestore;
  final Logger _logger = Logger();

  ContactDatasource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> sendMessage(Contact contact) async {
    try {
      await _firestore
          .collection("message")
          .doc(contact.email)
          .collection("user_messages")
          .add({
            ...contact.toJson(),
            'createdAt': FieldValue.serverTimestamp(),
          });
      _logger.i("Contact message saved successfully");
    } catch (ex) {
      _logger.e("Failed to save contact: $ex");
      rethrow;
    }
  }
}
