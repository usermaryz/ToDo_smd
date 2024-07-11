import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_usermary/feature/domain/entities/task_entity.dart';
import 'package:todo_usermary/feature/presentation/bloc/task_bloc.dart';
import 'package:todo_usermary/feature/presentation/bloc/task_event.dart';
import 'package:todo_usermary/feature/domain/repositories/task_repository.dart';

// Моки для зависимостей
class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late TaskBloc taskBloc;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskBloc = TaskBloc(mockTaskRepository);
  });

  final date = DateTime.fromMillisecondsSinceEpoch(1720667382777);
  const uuid = 'f599c979-d7a6-45aa-86d5-290fa1912d33';

  final testTaskEntity = TaskEntity(
    id: uuid,
    text: 'погулять с собакой',
    done: false,
    deadline: null,
    createdAt: date,
    lastUpdatedBy: '123',
    changedAt: date,
    importance: 'basic',
  );

  final testTaskList = [testTaskEntity];

  test('should emit tasks when LoadTasks event is added', () async {
    // Arrange
    when(mockTaskRepository.getTasks()).thenAnswer(
      (_) async => testTaskList,
    );

    // Act
    taskBloc.add(LoadTasks());

    // Assert
    print(taskBloc.stream);
    await expectLater(
      taskBloc.stream,
      emitsInOrder([
        testTaskList,
      ]),
    );
  });

  test('should add a task and emit new tasks list when AddTask event is added',
      () async {
    // Arrange
    when(mockTaskRepository.addTask(testTaskEntity)).thenAnswer(
      (_) async => {},
    );
    when(mockTaskRepository.getTasks()).thenAnswer(
      (_) async => testTaskList,
    );

    // Act
    taskBloc.add(AddTask(testTaskEntity));

    // Assert
    await expectLater(
      taskBloc.stream,
      emitsInOrder([
        testTaskList,
      ]),
    );
  });

  test(
      'should update a task and emit new tasks list when UpdateTask event is added',
      () async {
    // Arrange
    when(mockTaskRepository.updateTask(testTaskEntity)).thenAnswer(
      (_) async => {},
    );
    when(mockTaskRepository.getTasks()).thenAnswer(
      (_) async => testTaskList,
    );

    // Act
    taskBloc.add(UpdateTask(testTaskEntity));

    // Assert
    await expectLater(
      taskBloc.stream,
      emitsInOrder([
        testTaskList,
      ]),
    );
  });

  test(
      'should delete a task and emit new tasks list when DeleteTask event is added',
      () async {
    // Arrange
    when(mockTaskRepository.deleteTask(uuid)).thenAnswer(
      (_) async => {},
    );
    when(mockTaskRepository.getTasks()).thenAnswer(
      (_) async => testTaskList,
    );

    // Act
    taskBloc.add(const DeleteTask(uuid));

    // Assert
    await expectLater(
      taskBloc.stream,
      emitsInOrder([
        testTaskList,
      ]),
    );
  });

  test(
      'should mark a task as done and emit new tasks list when DoneTask event is added',
      () async {
    // Arrange
    when(mockTaskRepository.doneTask(testTaskEntity)).thenAnswer(
      (_) async => {},
    );
    when(mockTaskRepository.getTasks()).thenAnswer(
      (_) async => testTaskList,
    );

    // Act
    taskBloc.add(DoneTask(testTaskEntity));

    // Assert
    await expectLater(
      taskBloc.stream,
      emitsInOrder([
        testTaskList,
      ]),
    );
  });

  test(
      'should mark a task as done in list and emit new tasks list when DoneList event is added',
      () async {
    // Arrange
    when(mockTaskRepository.doneList(testTaskList)).thenAnswer(
      (_) async => {},
    );
    when(mockTaskRepository.getTasks()).thenAnswer(
      (_) async => testTaskList,
    );

    // Act
    taskBloc.add(DoneList(testTaskList));

    // Assert
    await expectLater(
      taskBloc.stream,
      emitsInOrder([
        testTaskList,
      ]),
    );
  });
}
