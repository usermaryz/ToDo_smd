import 'package:flutter/material.dart';
import 'task_bloc.dart';
import '/feature/domain/repositories/mock_task_repository.dart';

class TaskProvider extends InheritedWidget {
  final TaskBloc bloc;

  TaskProvider({super.key, required super.child})
      : bloc = TaskBloc(MockTaskRepository());

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TaskBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<TaskProvider>())!.bloc;
  }
}
