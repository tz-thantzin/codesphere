// lib/domain/usecases/contact_message.dart
import '../../models/contact_model.dart';
import '../repositories/contact_repository.dart';

class ContactMessage {
  final ContactRepository repository;

  ContactMessage(this.repository);

  Future<void> sendMessage(ContactModel contact) async {
    return await repository.sendMessage(contact);
  }
}
