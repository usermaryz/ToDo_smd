import 'package:hive/hive.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/domain/repositories/task_repository.dart';

class HiveTaskRepository implements TaskRepository {
  final Box<TaskEntity> taskBox;

  HiveTaskRepository(this.taskBox);

  @override
  List<TaskEntity> getTasks() {
    return taskBox.values.toList();
  }

  @override
  void addTask(TaskEntity task) {
    taskBox.add(task);
  }

  @override
  void updateTask(TaskEntity task) {
    final taskKey = taskBox.keys.firstWhere(
        (key) => taskBox.get(key)?.id == task.id,
        orElse: () => null);
    if (taskKey != null) {
      taskBox.put(taskKey, task);
    }
  }

  @override
  void deleteTask(int id) {
    final taskKey = taskBox.keys
        .firstWhere((key) => taskBox.get(key)?.id == id, orElse: () => null);
    if (taskKey != null) {
      taskBox.delete(taskKey);
    }
  }

  @override
  void doneTask(TaskEntity task) {
    final taskKey = taskBox.keys.firstWhere(
        (key) => taskBox.get(key)?.id == task.id,
        orElse: () => null);
    if (taskKey != null) {
      final updatedTask = task.copyWith(isDone: !task.isDone);
      taskBox.put(taskKey, updatedTask);
    }
  }

  @override
  void doneList(TaskEntity doneTask) {
    for (var key in taskBox.keys) {
      final task = taskBox.get(key);
      if (task != null && task.id != doneTask.id) {
        final updatedTask = task.copyWith(isDone: true);
        taskBox.put(key, updatedTask);
      }
    }
  }
}
