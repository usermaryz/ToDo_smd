import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/feature/domain/repositories/hive_task_repository.dart';
import '/feature/presentation/bloc/task_bloc.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/data/services/rest_client.dart';

class TaskProvider extends InheritedWidget {
  final TaskBloc bloc;

  TaskProvider({
    super.key,
    required Box<TaskEntity> taskBox,
    required RestClient client,
    required super.child,
  }) : bloc = TaskBloc(HiveTaskRepository(taskBox, client));

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TaskBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<TaskProvider>())!.bloc;
  }
}
