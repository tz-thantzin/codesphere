// lib/models/contact_model.dart
import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String message;

  const ContactModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'message': message,
  };

  @override
  List<Object?> get props => [email, name, phone, message];
}
