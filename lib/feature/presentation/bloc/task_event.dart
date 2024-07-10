import 'package:equatable/equatable.dart';
import '/feature/domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskEntity task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final TaskEntity task;

  const UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String taskId;

  const DeleteTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class DoneTask extends TaskEvent {
  final TaskEntity task;

  const DoneTask(this.task);

  @override
  List<Object> get props => [task];
}

class DoneList extends TaskEvent {
  final List<TaskEntity> task;

  const DoneList(this.task);

  @override
  List<Object> get props => [task];
}
