import 'package:equatable/equatable.dart';
import '/feature/domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskEntity task;
  final int revision;

  AddTask(this.task, this.revision);

  @override
  List<Object> get props => [task, revision];
}

class UpdateTask extends TaskEvent {
  final TaskEntity task;
  final int revision;

  UpdateTask(this.task, this.revision);

  @override
  List<Object> get props => [task, revision];
}

class DeleteTask extends TaskEvent {
  final String taskId;
  final int revision;

  DeleteTask(this.taskId, this.revision);

  @override
  List<Object> get props => [taskId, revision];
}

class DoneTask extends TaskEvent {
  final TaskEntity task;
  final int revision;

  DoneTask(this.task, this.revision);

  @override
  List<Object> get props => [task, revision];
}

class DoneList extends TaskEvent {
  final TaskEntity task;
  final int revision;

  DoneList(this.task, this.revision);

  @override
  List<Object> get props => [task, revision];
}
