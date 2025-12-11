// lib/domain/repositories/contact_repository.dart
import '../../models/contact_model.dart';

abstract class ContactRepository {
  Future<void> sendMessage(ContactModel contact);
}
