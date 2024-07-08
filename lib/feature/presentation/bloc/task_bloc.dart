import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/domain/repositories/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, List<TaskEntity>> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super([]) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<DoneTask>(_onDoneTask);
    on<DoneList>(_onDoneList);

    // Задачи при инициализации
    add(LoadTasks());
  }

  void _onLoadTasks(LoadTasks event, Emitter<List<TaskEntity>> emit) {
    emit(repository.getTasks());
  }

  void _onAddTask(AddTask event, Emitter<List<TaskEntity>> emit) {
    repository.addTask(event.task);
    emit(repository.getTasks());
  }

  void _onUpdateTask(UpdateTask event, Emitter<List<TaskEntity>> emit) {
    repository.updateTask(event.task);
    emit(repository.getTasks());
  }

  void _onDeleteTask(DeleteTask event, Emitter<List<TaskEntity>> emit) {
    repository.deleteTask(event.taskId);
    emit(repository.getTasks());
  }

  void _onDoneTask(DoneTask event, Emitter<List<TaskEntity>> emit) {
    repository.doneTask(event.task);
    emit(repository.getTasks());
  }

  void _onDoneList(DoneList event, Emitter<List<TaskEntity>> emit) {
    repository.doneList(event.task);
    emit(repository.getTasks());
  }
}
