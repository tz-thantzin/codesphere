import 'package:equatable/equatable.dart';

class FeatureModel extends Equatable {
  final String icon;
  final String title;
  final String description;
  final int delay;

  FeatureModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.delay,
  });

  @override
  List<Object?> get props => [icon, title, description, delay];
}
