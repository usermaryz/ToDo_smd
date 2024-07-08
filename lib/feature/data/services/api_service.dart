import 'dart:convert';
import 'package:http/http.dart' as http;
import '/feature/domain/entities/task_entity.dart';

class ApiService {
  final http.Client client;
  final String baseUrl;
  final String token;

  ApiService(this.client, this.baseUrl, this.token);

  Future<List<TaskEntity>> getList() async {
    final response = await client.get(
      Uri.parse('$baseUrl/list'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'ok') {
        List<TaskEntity> tasks = (data['list'] as List)
            .map((task) => TaskEntity.fromJson(task))
            .toList();
        return tasks;
      } else {
        throw Exception('Failed to load tasks');
      }
    } else {
      throw Exception('Failed to load tasks: ${response.statusCode}');
    }
  }

  Future<void> updateList(List<TaskEntity> tasks) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/list'),
      headers: {'Authorization': 'Bearer $token'},
      body: jsonEncode({'list': tasks.map((task) => task.toJson()).toList()}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update tasks: ${response.statusCode}');
    }
  }

  Future<TaskEntity> getTaskById(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/list/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'ok') {
        return TaskEntity.fromJson(data['element']);
      } else {
        throw Exception('Failed to load task');
      }
    } else {
      throw Exception('Failed to load task: ${response.statusCode}');
    }
  }

  Future<TaskEntity> addTask(TaskEntity task) async {
    final response = await client.post(
      Uri.parse('$baseUrl/list'),
      headers: {'Authorization': 'Bearer $token'},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'ok') {
        return TaskEntity.fromJson(data['element']);
      } else {
        throw Exception('Failed to add task');
      }
    } else {
      throw Exception('Failed to add task: ${response.statusCode}');
    }
  }

  Future<TaskEntity> updateTask(TaskEntity task) async {
    final response = await client.put(
      Uri.parse('$baseUrl/list/${task.id}'),
      headers: {'Authorization': 'Bearer $token'},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'ok') {
        return TaskEntity.fromJson(data['element']);
      } else {
        throw Exception('Failed to update task');
      }
    } else {
      throw Exception('Failed to update task: ${response.statusCode}');
    }
  }

  Future<TaskEntity> deleteTask(String id) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/list/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'ok') {
        return TaskEntity.fromJson(data['element']);
      } else {
        throw Exception('Failed to delete task');
      }
    } else {
      throw Exception('Failed to delete task: ${response.statusCode}');
    }
  }
}
