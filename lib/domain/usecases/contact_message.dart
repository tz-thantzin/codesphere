// lib/domain/usecases/contact_message.dart
import '../../models/contact.dart';
import '../repositories/contact_repository.dart';

class ContactMessage {
  final ContactRepository repository;

  ContactMessage(this.repository);

  Future<void> sendMessage(Contact contact) async {
    return await repository.sendMessage(contact);
  }
}
