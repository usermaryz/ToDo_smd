import 'package:flutter/material.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/presentation/bloc/task_event.dart';
import '/feature/presentation/bloc/task_provider.dart';
import '/feature/presentation/bloc/task_bloc.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  late TextEditingController _taskController;
  late int _importance;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _importance = 2;
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskBloc = TaskProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Новая задача"),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _saveTask(taskBloc);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Текст задачи"),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: "Введите задачу",
              ),
            ),
            SizedBox(height: 20),
            Text("Приоритет"),
            DropdownButton<int>(
              value: _importance,
              onChanged: (int? value) {
                setState(() {
                  _importance = value!;
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text("Высокий"),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text("Нет"),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text("Низкий"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveTask(TaskBloc taskBloc) {
    final newTask = TaskEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      description: _taskController.text,
      importance: _importance,
      isDone: false,
    );

    taskBloc.add(AddTask(newTask));
    Navigator.of(context).pop();
  }
}
