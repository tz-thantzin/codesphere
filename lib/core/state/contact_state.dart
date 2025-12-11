import 'package:equatable/equatable.dart';

class ContactState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const ContactState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  ContactState copyWith({bool? isLoading, String? error, bool? isSuccess}) {
    return ContactState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, isSuccess];
}
