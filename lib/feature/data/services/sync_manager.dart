import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'api_service.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/data/services/rest_client.dart';

class SyncManager {
  final Box<TaskEntity> taskBox;
  final RestClient restClient;

  SyncManager({required this.taskBox, required this.restClient});

  Future<void> syncTasks() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      List<TaskEntity> tasks = taskBox.values.toList();
      try {
        await restClient.updateTasks(tasks);
        taskBox.clear();
      } catch (e) {
        print('Failed to sync tasks: $e');
      }
    }
  }
}
