import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/feature/domain/repositories/hive_task_repository.dart';
import '/feature/presentation/bloc/task_bloc.dart';
import '/feature/domain/entities/task_entity.dart';

class TaskProvider extends InheritedWidget {
  final TaskBloc bloc;

  TaskProvider(
      {super.key, required Box<TaskEntity> taskBox, required super.child})
      : bloc = TaskBloc(HiveTaskRepository(taskBox));

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TaskBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<TaskProvider>())!.bloc;
  }
}
