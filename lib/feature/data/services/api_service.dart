import '/feature/domain/entities/task_entity.dart';
import 'http_client.dart';
import 'dart:convert';

class ApiService {
  final HttpClient _httpClient;

  ApiService(this._httpClient);

  Future<List<TaskEntity>> getList() async {
    try {
      final response = await _httpClient.get('/list');
      final data = json.decode(response.body);
      if (data['status'] == 'ok') {
        List<TaskEntity> tasks = (data['list'] as List)
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

  Future<void> updateList(List<TaskEntity> tasks) async {
    try {
      final response = await _httpClient.patch(
        '/list',
        body:
            json.encode({'list': tasks.map((task) => task.toJson()).toList()}),
      );
      final data = json.decode(response.body);
      if (data['status'] != 'ok') {
        throw Exception('Failed to update tasks');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> getTaskById(String id) async {
    try {
      final response = await _httpClient.get('/list/$id');
      final data = json.decode(response.body);
      if (data['status'] == 'ok') {
        return TaskEntity.fromJson(data['element']);
      } else {
        throw Exception('Failed to load task');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> addTask(TaskEntity task) async {
    try {
      final response = await _httpClient.post(
        '/list',
        body: json.encode(task.toJson()),
      );
      final data = json.decode(response.body);
      if (data['status'] == 'ok') {
        return TaskEntity.fromJson(data['element']);
      } else {
        throw Exception('Failed to add task');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> updateTask(TaskEntity task) async {
    try {
      final response = await _httpClient.put(
        '/list/${task.id}',
        body: json.encode(task.toJson()),
      );
      final data = json.decode(response.body);
      if (data['status'] == 'ok') {
        return TaskEntity.fromJson(data['element']);
      } else {
        throw Exception('Failed to update task');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> deleteTask(String id) async {
    try {
      final response = await _httpClient.delete('/list/$id');
      final data = json.decode(response.body);
      if (data['status'] == 'ok') {
        return TaskEntity.fromJson(data['element']);
      } else {
        throw Exception('Failed to delete task');
      }
    } catch (e) {
      rethrow;
    }
  }
}
