import 'package:equatable/equatable.dart';
import '/feature/domain/entities/task_entity.dart';

// Базовый класс для всех событий, который использует Equatable для сравнения объектов
abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Событие для загрузки задач
class LoadTasks extends TaskEvent {}

// Событие для добавления задачи
class AddTask extends TaskEvent {
  final TaskEntity task;

  AddTask(this.task);

  @override
  List<Object> get props => [task];
}

// Событие для обновления задачи
class UpdateTask extends TaskEvent {
  final TaskEntity task;

  UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

// Событие для удаления задачи
class DeleteTask extends TaskEvent {
  final String taskId;

  DeleteTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}

// Событие для отметки задачи как выполненной
class DoneTask extends TaskEvent {
  final TaskEntity task;

  DoneTask(this.task);

  @override
  List<Object> get props => [task];
}

// Событие для отметки всех задач как выполненных, кроме переданной задачи
class DoneList extends TaskEvent {
  final TaskEntity task;

  DoneList(this.task);

  @override
  List<Object> get props => [task];
}
