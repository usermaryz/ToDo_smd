import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/presentation/bloc/task_event.dart';
import '/feature/presentation/bloc/task_provider.dart';
import '/feature/presentation/bloc/task_bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import '/constants/strings.dart';
import '/router/app_routes.dart';
import '/router/app_router.dart';

class TodoList extends StatefulWidget {
  final bool showCompletedTasks;

  const TodoList({super.key, required this.showCompletedTasks});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  String importanceColor = "#FF3B30";

  @override
  void initState() {
    super.initState();
    _fetchImportanceColor();
  }

  Future<void> _fetchImportanceColor() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    setState(() {
      importanceColor = remoteConfig.getString('importanceColor');
      print("importance: $importanceColor");
    });

    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      setState(() {
        importanceColor = remoteConfig.getString('importanceColor');
        print("importance: $importanceColor");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskBloc = TaskProvider.of(context);

    return BlocBuilder<TaskBloc, List<TaskEntity>>(
      bloc: taskBloc,
      builder: (context, tasks) {
        final filteredTasks = widget.showCompletedTasks
            ? tasks
            : tasks.where((task) => !task.done).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        task: filteredTasks[index],
                        onToggleCompleted: (bool isCompleted) {
                          taskBloc.add(DoneTask(filteredTasks[index]));
                          setState(() {});
                        },
                        onDelete: () {
                          taskBloc.add(
                              DeleteTask((filteredTasks[index].id).toString()));
                        },
                        importanceColor: Color(int.parse(
                            importanceColor.replaceFirst('#', '0xff'))),
                      );
                    },
                  ),
                  MaterialButton(
                    onPressed: () {
                      final routerDelegate = Router.of(context).routerDelegate
                          as AppRouterDelegate;
                      routerDelegate.handleNavigation(AppRoutes.newTask);
                    },
                    color: Colors.transparent,
                    elevation: 0,
                    minWidth: double.infinity,
                    height: 40,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(Messages.newTask,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
