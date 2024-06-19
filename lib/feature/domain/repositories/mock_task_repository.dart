import 'task_repository.dart';
import '/feature/domain/entities/task_entity.dart';

class MockTaskRepository implements TaskRepository {
  final List<TaskEntity> _tasks = [
    TaskEntity(id: 0, description: 'Зарядка', importance: 1, isDone: true),
    TaskEntity(id: 1, description: 'Зарядка', importance: 2, isDone: true),
    TaskEntity(
        id: 2, description: 'Поход в магазин', importance: 2, isDone: true),
    TaskEntity(id: 3, description: 'Почта', importance: 3, isDone: false),
    TaskEntity(id: 4, description: 'Созвон', importance: 1, isDone: false),
    TaskEntity(id: 5, description: 'Пары', importance: 2, isDone: false),
    TaskEntity(id: 6, description: 'Спортзал', importance: 1, isDone: false),
    TaskEntity(id: 7, description: 'Почта', importance: 1, isDone: false),
    TaskEntity(id: 8, description: 'Созвон', importance: 1, isDone: false),
    TaskEntity(id: 9, description: 'Пары', importance: 2, isDone: false),
    TaskEntity(id: 10, description: 'Спортзал', importance: 2, isDone: false),
    TaskEntity(id: 11, description: 'Почта', importance: 2, isDone: false),
    TaskEntity(id: 12, description: 'Созвон', importance: 1, isDone: false),
    TaskEntity(id: 13, description: 'Пары', importance: 1, isDone: false),
    TaskEntity(id: 14, description: 'Спортзал', importance: 1, isDone: false),
  ];

  @override
  List<TaskEntity> getTasks() => _tasks;

  @override
  void addTask(TaskEntity task) {
    _tasks.add(task);
  }

  @override
  void updateTask(TaskEntity task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }

  @override
  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
  }
}
