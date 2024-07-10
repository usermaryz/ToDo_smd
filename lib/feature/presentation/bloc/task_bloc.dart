import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/domain/repositories/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, List<TaskEntity>> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super([]) {
    on<LoadTasks>((event, emit) async {
      final tasks = await repository.getTasks();
      emit(tasks);
    });

    on<AddTask>((event, emit) async {
      await repository.addTask(event.task);
      final tasks = await repository.getTasks();
      emit(tasks);
    });

    on<UpdateTask>((event, emit) async {
      await repository.updateTask(event.task);
      final tasks = await repository.getTasks();
      emit(tasks);
    });

    on<DeleteTask>((event, emit) async {
      await repository.deleteTask(event.taskId);
      final tasks = await repository.getTasks();
      emit(tasks);
    });

    on<DoneTask>((event, emit) async {
      await repository.doneTask(event.task);
      final tasks = await repository.getTasks();
      emit(tasks);
    });

    on<DoneList>((event, emit) async {
      await repository.doneList(event.task);
      final tasks = await repository.getTasks();
      emit(tasks);
    });
  }
}
