import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:todo_usermary/feature/domain/entities/task_entity.dart';
import 'package:todo_usermary/feature/domain/repositories/hive_task_repository.dart';
import 'package:todo_usermary/feature/data/services/rest_client.dart';

class MockBox extends Mock implements Box<TaskEntity> {}

class MockRestClient extends Mock implements RestClient {}

void main() {
  group('HiveTaskRepository deleteTask Tests', () {
    late HiveTaskRepository repository;
    late MockBox mockBox;
    late MockRestClient mockRestClient;

    setUp(() {
      mockBox = MockBox();
      mockRestClient = MockRestClient();
      repository = HiveTaskRepository(mockBox, mockRestClient);
    });

    test('deleteTask removes task from Hive and server', () async {
      const taskId = '11f3ad34-254f-4f56-986a-0bc9cb7de9d1';

      await repository.deleteTask(taskId);

      verify(mockBox.delete(taskId)).called(1);
      verify(mockRestClient.deleteTask(taskId)).called(1);
    });
  });
}
