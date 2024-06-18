import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/feature/domain/entities/task_entity.dart';

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
              _saveTask();
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

  void _saveTask() {
    final newTask = TaskEntity(
      id: 0,
      description: _taskController.text,
      importance: _importance,
      isDone: false,
    );

    // Действие для сохранения задачи
  }
}
