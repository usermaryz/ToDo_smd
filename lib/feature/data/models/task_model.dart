import '/feature/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.description,
    super.importance = 2,
    super.isDone = false,
    super.date,
  });
}
