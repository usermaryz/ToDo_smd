import 'package:hive/hive.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/domain/repositories/task_repository.dart';
import '/feature/data/services/rest_client.dart';
import '/utils/logger.dart';

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
    try {
      await client.addTask(task);
    } catch (e) {
      AppLogger.e('Error in addTask: $e');
      await taskBox.delete(task.id);
      rethrow;
    }
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final taskKey = taskBox.keys.firstWhere(
      (key) => taskBox.get(key)?.id == task.id,
      orElse: () => null,
    );
    if (taskKey != null) {
      await taskBox.put(taskKey, task);
      try {
        await client.updateTask(task);
      } catch (e) {
        AppLogger.e('Error in updateTask: $e');
        rethrow;
      }
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
      try {
        await client.deleteTask(id);
      } catch (e) {
        AppLogger.e('Error in deleteTask: $e');
        rethrow;
      }
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
      try {
        await client.updateTask(updatedTask);
      } catch (e) {
        AppLogger.e('Error in doneTask: $e');
        rethrow;
      }
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
        try {
          await client.updateTask(updatedTask);
        } catch (e) {
          AppLogger.e('Error in doneList: $e');
          rethrow;
        }
      } else {
        throw Exception('Task not found');
      }
    }
  }
}
