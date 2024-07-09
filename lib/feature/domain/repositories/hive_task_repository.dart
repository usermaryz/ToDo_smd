import 'package:hive/hive.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/domain/repositories/task_repository.dart';
import '/feature/data/services/rest_client.dart'; // Импортируем RestClient

class HiveTaskRepository implements TaskRepository {
  final Box<TaskEntity> taskBox;
  final RestClient client;

  HiveTaskRepository(this.taskBox, this.client);

  @override
  List<TaskEntity> getTasks() {
    return taskBox.values.toList();
  }

  @override
  void addTask(TaskEntity task, int revision) {
    taskBox.add(task);
    client.addTask(task, revision);
  }

  @override
  void updateTask(TaskEntity task, int revision) {
    final taskKey = taskBox.keys.firstWhere(
        (key) => taskBox.get(key)?.id == task.id,
        orElse: () => null);
    if (taskKey != null) {
      taskBox.put(taskKey, task);
      client.updateTask(task, revision);
    }
  }

  @override
  void deleteTask(String id, int revision) {
    final taskKey = taskBox.keys
        .firstWhere((key) => taskBox.get(key)?.id == id, orElse: () => null);
    if (taskKey != null) {
      taskBox.delete(taskKey);
      client.deleteTask(id.toString(), revision);
    }
  }

  @override
  void doneTask(TaskEntity task, int revision) {
    final taskKey = taskBox.keys.firstWhere(
        (key) => taskBox.get(key)?.id == task.id,
        orElse: () => null);
    if (taskKey != null) {
      final updatedTask = task.copyWith(done: !task.done);
      taskBox.put(taskKey, updatedTask);
      client.updateTask(updatedTask, revision);
    }
  }

  @override
  void doneList(TaskEntity doneTask, int revision) {
    for (var key in taskBox.keys) {
      final task = taskBox.get(key);
      if (task != null && task.id != doneTask.id) {
        final updatedTask = task.copyWith(done: true);
        taskBox.put(key, updatedTask);
        client.updateTask(updatedTask, revision);
      }
    }
  }
}
