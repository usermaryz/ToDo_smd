import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:todo_usermary/feature/domain/entities/task_entity.dart';
import 'package:todo_usermary/feature/data/services/api_service.dart';
import 'package:todo_usermary/feature/data/services/dio_client.dart';

class MockDioClient extends Mock implements DioClient {
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
        id: 'f599c979-d7a6-45aa-86d5-290fa1912d33',
        text: 'погулять с собакой',
        importance: 'basic',
        deadline: null,
        done: false,
        color: null,
        createdAt: DateTime.fromMillisecondsSinceEpoch(1720667382777),
        changedAt: DateTime.fromMillisecondsSinceEpoch(1720667382777),
        lastUpdatedBy: '123',
      );

      final response = Response(
        data: {
          'status': 'ok',
          'element': newTask.toJson(),
          'revision': 218,
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: '/list'),
      );

      when(mockDioClient.dio.post('/list', data: anyNamed('data')))
          .thenAnswer((_) async => response);

      final result = await apiService.addTask(newTask);

      expect(result, isA<TaskEntity>());
      expect(result.id, 'f599c979-d7a6-45aa-86d5-290fa1912d33');
      expect(result.text, 'погулять с собакой');
    });
  });
}
