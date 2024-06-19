import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/domain/repositories/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, List<TaskEntity>> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super([]) {
    on<LoadTasks>((event, emit) {
      emit(repository.getTasks());
    });

    on<AddTask>((event, emit) {
      repository.addTask(event.task);
      emit(repository.getTasks());
    });

    on<UpdateTask>((event, emit) {
      repository.updateTask(event.task);
      emit(repository.getTasks());
    });

    on<DeleteTask>((event, emit) {
      repository.deleteTask(event.taskId);
      emit(repository.getTasks());
    });
  }
}
