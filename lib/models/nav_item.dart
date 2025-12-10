import 'package:equatable/equatable.dart';

class NavItem extends Equatable {
  final String label;
  final String hash;
  const NavItem({required this.label, required this.hash});

  @override
  List<Object?> get props => [label, hash];
}
