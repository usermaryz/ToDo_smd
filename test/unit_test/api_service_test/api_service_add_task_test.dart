import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:todo_usermary/feature/domain/entities/task_entity.dart';
import 'package:todo_usermary/feature/data/services/api_service.dart';
import 'package:todo_usermary/feature/data/services/dio_client.dart';

class MockDioClient extends Mock implements DioClient {
  Dio get dio => throw UnimplementedError();
}

void main() {
  group('ApiService addTask Tests', () {
    late ApiService apiService;
    late MockDioClient mockDioClient;

    setUp(() {
      mockDioClient = MockDioClient();
      apiService = ApiService(mockDioClient);
    });

    test('addTask successfully adds a task', () async {
      final newTask = TaskEntity(
        id: '123',
        text: 'New Task',
        importance: 'high',
        deadline: DateTime.now().add(const Duration(days: 1)),
        done: false,
        color: null,
        createdAt: DateTime.now(),
        changedAt: DateTime.now(),
        lastUpdatedBy: 'user123',
      );

      final response = Response(
        data: {
          'status': 'ok',
          'task': newTask.toJson(),
          'revision': 206,
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDioClient.dio.post('', data: anyNamed('data')))
          .thenAnswer((_) async => response);

      final result = await apiService.addTask(newTask);

      expect(result, isA<TaskEntity>());
      expect(result.id, '123');
      expect(result.text, 'New Task');
    });
  });
}
