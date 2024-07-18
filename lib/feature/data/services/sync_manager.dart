import 'package:hive/hive.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/data/services/rest_client.dart';
import '/utils/logger.dart';

class SyncManager {
  final Box<TaskEntity> taskBox;
  final RestClient restClient;

  SyncManager({required this.taskBox, required this.restClient});

  Future<void> syncTasks() async {
    try {
      List<TaskEntity> serverTasks = await restClient.getTasks();
      Set<String> serverTaskIds = serverTasks.map((task) => task.id).toSet();

      for (var task in serverTasks) {
        final existingTaskKey = taskBox.keys.firstWhere(
          (key) => taskBox.get(key)?.id == task.id,
          orElse: () => null,
        );

        if (existingTaskKey == null) {
          taskBox.add(task);
        } else {
          taskBox.put(existingTaskKey, task);
        }
      }

      List<int> keysToDelete = [];
      for (var key in taskBox.keys) {
        if (!serverTaskIds.contains(taskBox.get(key)?.id)) {
          keysToDelete.add(key as int);
        }
      }
      taskBox.deleteAll(keysToDelete);

      await _syncLocalToServer();
    } catch (e) {
      AppLogger.e('Error in syncTasks: $e');
    }
  }


  Future<void> _syncLocalToServer() async {
    List<TaskEntity> localTasks = taskBox.values.toList();

    for (var task in localTasks) {
      if (task.id.isEmpty) {
        try {
          TaskEntity serverTask = await restClient.addTask(task);
          await taskBox.delete(task.key);
        } catch (e) {
          AppLogger.e('Error in _syncLocalToServer: $e');
        }
      }
    }
  }
}
