import 'package:dio/dio.dart';
import '/feature/domain/entities/task_entity.dart';
import 'rest_client.dart';
import 'dio_client.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  Future<List<TaskEntity>> getList() async {
    try {
      final response = await _dioClient.dio.get('/list');
      if (response.data['status'] == 'ok') {
        List<TaskEntity> tasks = (response.data['list'] as List)
            .map((task) => TaskEntity.fromJson(task))
            .toList();
        return tasks;
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateList(List<TaskEntity> tasks, int revision) async {
    try {
      final response = await _dioClient.dio.patch(
        '/list',
        data: {'list': tasks.map((task) => task.toJson()).toList()},
        options: Options(headers: {'X-Last-Known-Revision': revision}),
      );
      if (response.data['status'] != 'ok') {
        throw Exception('Failed to update tasks');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> getTaskById(String id) async {
    try {
      final response = await _dioClient.dio.get('/list/$id');
      if (response.data['status'] == 'ok') {
        return TaskEntity.fromJson(response.data['element']);
      } else {
        throw Exception('Failed to load task');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> addTask(TaskEntity task, int revision) async {
    try {
      final response = await _dioClient.dio.post(
        '/list',
        data: task.toJson(),
        options: Options(headers: {'X-Last-Known-Revision': revision}),
      );
      print(response.statusCode);
      if (response.data['status'] == 'ok') {
        return TaskEntity.fromJson(response.data['element']);
      } else {
        throw Exception('Failed to add task');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> updateTask(TaskEntity task, int revision) async {
    try {
      final response = await _dioClient.dio.put(
        '/list/${task.id}',
        data: task.toJson(),
        options: Options(headers: {'X-Last-Known-Revision': revision}),
      );
      if (response.data['status'] == 'ok') {
        return TaskEntity.fromJson(response.data['element']);
      } else {
        throw Exception('Failed to update task');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> deleteTask(String id, int revision) async {
    try {
      final response = await _dioClient.dio.delete(
        '/list/$id',
        options: Options(headers: {'X-Last-Known-Revision': revision}),
      );
      if (response.data['status'] == 'ok') {
        return TaskEntity.fromJson(response.data['element']);
      } else {
        throw Exception('Failed to delete task');
      }
    } catch (e) {
      rethrow;
    }
  }
}
