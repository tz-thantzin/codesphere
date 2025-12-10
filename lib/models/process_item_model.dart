import 'package:equatable/equatable.dart';

class ProcessItemModel extends Equatable {
  final String title;
  final String iconPath;
  final String description;

  ProcessItemModel({
    required this.title,
    required this.iconPath,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'iconPath': iconPath,
    'description': description,
  };

  @override
  List<Object?> get props => [title, iconPath, description];
}
