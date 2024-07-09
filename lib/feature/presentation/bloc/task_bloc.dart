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
      repository.addTask(event.task, event.revision);
      emit(repository.getTasks());
    });

    on<UpdateTask>((event, emit) {
      repository.updateTask(event.task, event.revision);
      emit(repository.getTasks());
    });

    on<DeleteTask>((event, emit) {
      repository.deleteTask(event.taskId, event.revision);
      emit(repository.getTasks());
    });

    on<DoneTask>((event, emit) {
      repository.doneTask(event.task, event.revision);
      emit(repository.getTasks());
    });

    on<DoneList>((event, emit) {
      repository.doneList(event.task, event.revision);
      emit(repository.getTasks());
    });
  }
}
