import 'dart:convert';
import 'package:http/http.dart' as http;
import '/feature/domain/entities/task_entity.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<TaskEntity>> getList() async {
    try {
      final response = await dio.get('/list');
      if (response.data['status'] == 'ok') {
        List<TaskEntity> tasks = (response.data['list'] as List).map((task) => TaskEntity.fromJson(task)).toList();
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
      final response = await dio.patch(
        '/list',
        data: {'list': tasks.map((task) => task.toJson()).toList()},
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
      final response = await dio.get('/list/$id');
      if (response.data['status'] == 'ok') {
        return TaskEntity.fromJson(response.data['element']);
      } else {
        throw Exception('Failed to load task');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> addTask(TaskEntity task) async {
    try {
      final response = await dio.post(
        '/list',
        data: task.toJson(),
      );
      if (response.data['status'] == 'ok') {
        return TaskEntity.fromJson(response.data['element']);
      } else {
        throw Exception('Failed to add task');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> updateTask(TaskEntity task) async {
    try {
      final response = await dio.put(
        '/list/${task.id}',
        data: task.toJson(),
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

  Future<TaskEntity> deleteTask(String id) async {
    try {
      final response = await dio.delete('/list/$id');
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