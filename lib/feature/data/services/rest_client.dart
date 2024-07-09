import 'api_service.dart';
import 'dio_client.dart';
import '/feature/domain/entities/task_entity.dart';

class RestClient {
  final ApiService apiService;

  RestClient(String baseUrl, String token)
      : apiService = ApiService(DioClient(baseUrl, token));

  Future<List<TaskEntity>> getTasks() => apiService.getList();

  Future<void> updateTasks(List<TaskEntity> tasks, int revision) =>
      apiService.updateList(tasks, revision);

  Future<TaskEntity> getTask(String id) => apiService.getTaskById(id);

  Future<TaskEntity> addTask(TaskEntity task, int revision) =>
      apiService.addTask(task, revision);

  Future<TaskEntity> updateTask(TaskEntity task, int revision) =>
      apiService.updateTask(task, revision);

  Future<TaskEntity> deleteTask(String id, int revision) =>
      apiService.deleteTask(id, revision);
}
