import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task.dart';
import '/feature/presentation/pages/newTask.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/presentation/bloc/task_event.dart';
import '/feature/presentation/bloc/task_provider.dart';
import '/feature/presentation/bloc/task_bloc.dart';
import '/constants/colors.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskBloc = TaskProvider.of(context);

    return BlocBuilder<TaskBloc, List<TaskEntity>>(
      bloc: taskBloc,
      builder: (context, tasks) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: tdWhite,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(const Radius.circular(8.0)),
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
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        task: tasks[index],
                        onToggleCompleted: (bool isCompleted) {
                          taskBloc.add(
                              UpdateTask(tasks[index]..isDone = isCompleted));
                        },
                        onDelete: () {
                          taskBloc.add(DeleteTask(tasks[index].id));
                        },
                      );
                    },
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewTask(),
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Новое",
                        style: TextStyle(color: labTernitary, fontSize: 16),
                      ),
                    ),
                    color: Colors.transparent,
                    elevation: 0,
                    minWidth: double.infinity,
                    height: 40,
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
