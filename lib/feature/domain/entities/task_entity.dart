import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int id;
  String description;
  int importance;
  bool isDone;
  DateTime? date;

  TaskEntity({
    required this.id,
    required this.description,
    required this.importance,
    required this.isDone,
    this.date,
  });

  TaskEntity copyWith(
      {int? id, String? description, bool? isDone, DateTime? date}) {
    return TaskEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      importance: importance,
      isDone: isDone ?? this.isDone,
      date: date,
    );
  }

  @override
  List<Object?> get props => [id, description, importance, isDone, date];
}
