import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TaskEntity extends Equatable {
  final int id;
  String description;
  int importance;
  bool isDone;
  int? date;

  TaskEntity({
    required this.id,
    required this.description,
    required this.importance,
    required this.isDone,
    this.date,
  });

  @override
  List<Object?> get props => [id, description, importance, isDone, date];
}
