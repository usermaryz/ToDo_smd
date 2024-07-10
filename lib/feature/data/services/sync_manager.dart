import 'package:hive/hive.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/data/services/rest_client.dart';

class SyncManager {
  final Box<TaskEntity> taskBox;
  final RestClient restClient;

  SyncManager({required this.taskBox, required this.restClient});

  Future<void> syncTasks() async {
    List<TaskEntity> serverTasks = await restClient.getTasks();
    for (var task in serverTasks) {
      if (!taskBox.values.contains(task)) {
        taskBox.add(task);
      }
    }
  }
}
