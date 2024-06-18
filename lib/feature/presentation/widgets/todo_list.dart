import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/presentation/widgets/task.dart';
import '/feature/presentation/pages/newTask.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static List<TaskEntity> tasks = [
    TaskEntity(id: 0, description: 'Зарядка', importance: 1, isDone: true),
    TaskEntity(id: 1, description: 'Зарядка', importance: 2, isDone: true),
    TaskEntity(
        id: 2, description: 'Поход в магазин', importance: 2, isDone: true),
    TaskEntity(id: 3, description: 'Почта', importance: 3, isDone: false),
    TaskEntity(id: 4, description: 'Созвон', importance: 1, isDone: false),
    TaskEntity(id: 5, description: 'Пары', importance: 2, isDone: false),
    TaskEntity(id: 6, description: 'Спортзал', importance: 1, isDone: false),
    TaskEntity(id: 7, description: 'Почта', importance: 1, isDone: false),
    TaskEntity(id: 8, description: 'Созвон', importance: 1, isDone: false),
    TaskEntity(id: 9, description: 'Пары', importance: 2, isDone: false),
    TaskEntity(id: 10, description: 'Спортзал', importance: 2, isDone: false),
    TaskEntity(id: 11, description: 'Почта', importance: 2, isDone: false),
    TaskEntity(id: 12, description: 'Созвон', importance: 1, isDone: false),
    TaskEntity(id: 13, description: 'Пары', importance: 1, isDone: false),
    TaskEntity(id: 14, description: 'Спортзал', importance: 1, isDone: false),
  ];

  int doneTasksCount = tasks.where((task) => task.isDone).length;

  @override
  Widget build(BuildContext context) {
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
                ]),
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
                              setState(() {
                                tasks[index].isDone = isCompleted;
                              });
                            },
                            onDelete: () {
                              setState(() {
                                tasks.removeAt(index);
                              });
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
                    ]))));
  }
}
