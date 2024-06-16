import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Task extends Equatable {
  final int id;
  final String description;
  final int importance;
  final bool isDone;
  final int? date;

  Task({
    required this.id,
    required this.description,
    required this.importance,
    required this.isDone,
    this.date,
  });

  @override
  List<Object?> get props => [id, description, importance, isDone, date];
}
