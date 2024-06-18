import '/feature/domain/entities/task_entity.dart';
import 'package:meta/meta.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required int id,
    required String description,
    int importance = 2,
    bool isDone = false,
    DateTime? date = null,
  }) : super(
            id: id,
            description: description,
            importance: importance,
            isDone: isDone,
            date: date);
}
