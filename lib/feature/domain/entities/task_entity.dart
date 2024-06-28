/* import 'package:equatable/equatable.dart';

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
*/

import 'package:hive/hive.dart';
part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final bool isDone;

  @HiveField(3)
  final int importance;

  @HiveField(4)
  final DateTime? date;

  TaskEntity({
    required this.id,
    required this.description,
    required this.isDone,
    required this.importance,
    this.date,
  });

  TaskEntity copyWith({
    int? id,
    String? description,
    bool? isDone,
    int? importance,
    DateTime? date,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      importance: importance ?? this.importance,
      date: date ?? this.date,
    );
  }
}
