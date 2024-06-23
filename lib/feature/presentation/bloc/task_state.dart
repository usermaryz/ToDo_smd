import 'package:equatable/equatable.dart';
import '/feature/domain/entities/task_entity.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoadInProgress extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<TaskEntity> tasks;

  const TaskLoadSuccess([this.tasks = const []]);

  @override
  List<Object> get props => [tasks];
}

class TaskLoadFailure extends TaskState {}
