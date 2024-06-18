import '/feature/domain/entities/task_entity.dart';
import 'package:meta/meta.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required id,
    required description,
    importance = 3,
    isDone = false,
    date,
  }) : super(
            id: id,
            description: description,
            importance: importance,
            isDone: isDone,
            date: date);
}
