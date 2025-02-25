import 'api_service.dart';
import 'dio_client.dart';
import '/feature/domain/entities/task_entity.dart';

class RestClient {
  final ApiService apiService;

  RestClient(DioClient dioClient) : apiService = ApiService(dioClient);

  Future<List<TaskEntity>> getTasks() => apiService.getList();

  Future<void> updateTasks(List<TaskEntity> tasks) =>
      apiService.updateList(tasks);

  Future<TaskEntity> getTask(String id) => apiService.getTaskById(id);

  Future<TaskEntity> addTask(TaskEntity task) => apiService.addTask(task);

  Future<TaskEntity> updateTask(TaskEntity task) => apiService.updateTask(task);

  Future<TaskEntity> deleteTask(String id) => apiService.deleteTask(id);
}
