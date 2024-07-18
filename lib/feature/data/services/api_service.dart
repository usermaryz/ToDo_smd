import 'package:dio/dio.dart';
import '/feature/domain/entities/task_entity.dart';
import 'dio_client.dart';
import '/utils/logger.dart';

class ApiService {
  final DioClient _dioClient;
  int _revision = 0;

  void _updateRevision(int newRevision) {
    _revision = newRevision;
  }

  ApiService(this._dioClient);

  Future<List<TaskEntity>> getList() async {
    try {
      final response = await _dioClient.dio.get('/list');
      if (response.data['status'] == 'ok') {
        _updateRevision(response.data['revision']);
        List<TaskEntity> tasks = (response.data['list'] as List)
            .map((task) => TaskEntity.fromJson(task))
            .toList();
        return tasks;
      } else {
        throw Exception('Failed to load tasks');
      }
    } on DioException catch (e) {
      AppLogger.e('Error in getList: $e');
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('No internet connection');
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateList(List<TaskEntity> tasks) async {
    try {
      final response = await _dioClient.dio.patch(
        '/list',
        data: {'list': tasks.map((task) => task.toJson()).toList()},
        options: Options(headers: {'X-Last-Known-Revision': _revision}),
      );
      if (response.data['status'] != 'ok') {
        throw Exception('Failed to update tasks');
      }
      _updateRevision(response.data['revision']);
    } on DioException catch (e) {
      AppLogger.e('Error in updateList: $e');
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('No internet connection');
      }
      rethrow;
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
    } on DioException catch (e) {
      AppLogger.e('Error in getTaskById: $e');
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('No internet connection');
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> addTask(TaskEntity task) async {
    try {
      final response = await _dioClient.dio.post(
        '/list',
        data: {'element': task.toJson()},
        options: Options(headers: {'X-Last-Known-Revision': _revision}),
      );
      if (response.data['status'] == 'ok') {
        _updateRevision(response.data['revision']);
        return TaskEntity.fromJson(response.data['element']);
      } else {
        throw Exception('Failed to add task');
      }
    } on DioException catch (e) {
      AppLogger.e('Error in addTask: $e');
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('No internet connection');
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> updateTask(TaskEntity task) async {
    try {
      final response = await _dioClient.dio.put(
        '/list/${task.id}',
        data: {'element': task.toJson()},
        options: Options(headers: {'X-Last-Known-Revision': _revision}),
      );

      if (response.statusCode != 200 || response.data['status'] != 'ok') {
        throw Exception(response.statusCode);
      }

      final newTask = TaskEntity.fromJson(response.data['element']);
      _updateRevision(response.data['revision']);

      return newTask;
    } on DioException catch (e) {
      AppLogger.e('Error in updateTask: $e');
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('No internet connection');
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskEntity> deleteTask(String id) async {
    try {
      final response = await _dioClient.dio.delete(
        '/list/$id',
        options: Options(headers: {'X-Last-Known-Revision': _revision}),
      );
      if (response.data['status'] == 'ok') {
        _updateRevision(response.data['revision']);
        return TaskEntity.fromJson(response.data['element']);
      } else {
        throw Exception('Failed to delete task');
      }
    } on DioException catch (e) {
      AppLogger.e('Error in deleteTask: $e');
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('No internet connection');
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
