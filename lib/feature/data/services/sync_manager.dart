import 'package:hive/hive.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/data/services/rest_client.dart';

class SyncManager {
  final Box<TaskEntity> taskBox;
  final RestClient restClient;

  SyncManager({required this.taskBox, required this.restClient});

  Future<void> syncTasks() async {
    // Сначала получаем задачи с сервера
    List<TaskEntity> serverTasks = await restClient.getTasks();

    // Создаем множество с идентификаторами задач на сервере
    Set<String> serverTaskIds = serverTasks.map((task) => task.id).toSet();

    // Обновляем или добавляем задачи из сервера в локальную базу данных
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

    // Удаляем локальные задачи, которых нет на сервере
    List<int> keysToDelete = [];
    for (var key in taskBox.keys) {
      if (!serverTaskIds.contains(taskBox.get(key)?.id)) {
        keysToDelete.add(key as int);
      }
    }
    taskBox.deleteAll(keysToDelete);

    // Синхронизируем локальные задачи с сервером
    await _syncLocalToServer();
  }

  Future<void> _syncLocalToServer() async {
    // Получаем все локальные задачи
    List<TaskEntity> localTasks = taskBox.values.toList();

    for (var task in localTasks) {
      // Если задача не была отправлена на сервер, отправляем её и удаляем из локальной базы данных
      if (task.id.isEmpty) {
        TaskEntity serverTask = await restClient.addTask(task);
        await taskBox.delete(task.key);
      }
    }
  }
}
