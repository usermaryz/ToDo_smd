import 'package:equatable/equatable.dart';
import '/feature/domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskEntity task;

  AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final TaskEntity task;

  UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final int taskId;

  DeleteTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class DoneTask extends TaskEvent {
  final TaskEntity task;

  DoneTask(this.task);

  @override
  List<Object> get props => [task];
}

class DoneList extends TaskEvent {
  final TaskEntity task;

  DoneList(this.task);

  @override
  List<Object> get props => [task];
}
