import 'package:hive/hive.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/domain/repositories/task_repository.dart';
import '/feature/data/services/rest_client.dart'; // Импортируем RestClient

class HiveTaskRepository implements TaskRepository {
  final Box<TaskEntity> taskBox;
  final RestClient client;

  HiveTaskRepository(this.taskBox, this.client);

  @override
  Future<List<TaskEntity>> getTasks() async {
    return taskBox.values.toList();
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    await taskBox.add(task);
    await client.addTask(task);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final taskKey = taskBox.keys.firstWhere(
      (key) => taskBox.get(key)?.id == task.id,
      orElse: () => null,
    );
    if (taskKey != null) {
      await taskBox.put(taskKey, task);
      await client.updateTask(task);
    } else {
      throw Exception('Task not found');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    final taskKey = taskBox.keys
        .firstWhere((key) => taskBox.get(key)?.id == id, orElse: () => null);
    if (taskKey != null) {
      await taskBox.delete(taskKey);
      await client.deleteTask(id);
    } else {
      throw Exception('Task not found');
    }
  }

  @override
  Future<void> doneTask(TaskEntity task) async {
    final taskKey = taskBox.keys.firstWhere(
        (key) => taskBox.get(key)?.id == task.id,
        orElse: () => null);
    if (taskKey != null) {
      final updatedTask = task.copyWith(done: !task.done);
      await taskBox.put(taskKey, updatedTask);
      await client.updateTask(updatedTask);
    } else {
      throw Exception('Task not found');
    }
  }

  @override
  Future<void> doneList(List<TaskEntity> tasks) async {
    for (var task in tasks) {
      final taskKey = taskBox.keys.firstWhere(
          (key) => taskBox.get(key)?.id == task.id,
          orElse: () => null);
      if (taskKey != null) {
        final updatedTask = task.copyWith(done: true);
        await taskBox.put(taskKey, updatedTask);
        await client.updateTask(updatedTask);
      } else {
        throw Exception('Task not found');
      }
    }
  }
}
