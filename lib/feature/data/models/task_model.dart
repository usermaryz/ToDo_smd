import 'package:hive/hive.dart';
import '/feature/domain/entities/task_entity.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends TaskEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final int importance;

  @HiveField(3)
  final bool isDone;

  @HiveField(4)
  final DateTime? date;

  TaskModel({
    required this.id,
    required this.description,
    required this.importance,
    required this.isDone,
    this.date,
  }) : super(
          id: id,
          description: description,
          importance: importance,
          isDone: isDone,
          date: date,
        );

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      description: entity.description,
      importance: entity.importance,
      isDone: entity.isDone,
      date: entity.date,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      description: description,
      importance: importance,
      isDone: isDone,
      date: date,
    );
  }
}
