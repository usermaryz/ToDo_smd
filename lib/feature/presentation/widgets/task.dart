import 'dart:ffi';

import 'package:flutter/material.dart';
import '/feature/domain/entities/task_entity.dart';
import '/constants/colors.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final Function(bool) onToggleCompleted;
  final Function() onDelete;

  TaskItem({
    required this.task,
    required this.onToggleCompleted,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: tdGreen,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              Icons.check,
              color: tdWhite,
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: tdRed,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onToggleCompleted(!task.isDone);
        } else {
          onDelete();
        }
      },
      child: ListTile(
        leading: InkWell(
          onTap: () {
            onToggleCompleted(!task.isDone);
          },
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(
                width: 2,
                color: task.isDone
                    ? tdGreen
                    : task.importance == 1
                        ? tdRed
                        : tdGrey,
              ),
              color: task.isDone
                  ? tdGreen
                  : task.importance == 1
                      ? tdRed.withOpacity(0.5)
                      : tdWhite,
            ),
            child: task.isDone
                ? Icon(
                    Icons.check,
                    color: tdWhite,
                    size: 16.0,
                  )
                : SizedBox(),
          ),
        ),
        title: Row(children: [
          task.importance == 1
              ? Icon(Icons.priority_high, color: tdRed, size: 16)
              : task.importance == 3
                  ? Icon(Icons.arrow_downward, color: tdGrey, size: 16)
                  : SizedBox(), // Важность
          SizedBox(width: 2), // Пробел между значком важности и текстом
          Text(
            task.description,
            style: TextStyle(
              fontSize: 16,
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              decorationColor: labTernitary,
              color: task.isDone ? labTernitary : labPrimary,
            ),
          )
        ]),
        trailing: Icon(
          Icons.info,
          color: supSeparetor,
          size: 25.0,
        ),
      ),
    );
  }
}
