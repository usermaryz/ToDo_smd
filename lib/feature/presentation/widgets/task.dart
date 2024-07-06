import 'package:flutter/material.dart';
import '/feature/domain/entities/task_entity.dart';
import '/constants/colors.dart';
import '/constants/strings.dart';
import '/router/app_routes.dart';
import '/router/app_router.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final Function(bool) onToggleCompleted;
  final Function() onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggleCompleted,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      background: Container(
        color: tdGreen,
        child: const Align(
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
        child: const Align(
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
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onToggleCompleted(!task.done);
          return false;
        } else {
          onDelete();
          return true;
        }
      },
      child: ListTile(
        leading: InkWell(
          onTap: () {
            onToggleCompleted(!task.done);
          },
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(
                width: 2,
                color: task.done
                    ? tdGreen
                    : task.importance == 1
                        ? tdRed
                        : tdGrey,
              ),
              color: task.done
                  ? tdGreen
                  : task.importance == 1
                      ? tdRed.withOpacity(0.5)
                      : tdWhite,
            ),
            child: task.done
                ? const Icon(
                    Icons.check,
                    color: tdWhite,
                    size: 16.0,
                  )
                : const SizedBox(),
          ),
        ),
        title: Row(
          children: [
            if (task.importance == 1)
              const Icon(Icons.priority_high, color: tdRed, size: 16)
            else if (task.importance == 3)
              const Icon(Icons.arrow_downward, color: tdGrey, size: 16),
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                task.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  decoration: task.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: labTernitary,
                  color: task.done ? labTernitary : labPrimary,
                ),
              ),
            ),
          ],
        ),
        subtitle: task.deadline != null
            ? Text(
                '${Messages.doBefore}: ${task.deadline!.day}/${task.deadline!.month}/${task.deadline!.year}',
                style: const TextStyle(
                  color: labTernitary,
                  fontSize: 14,
                ),
              )
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.info),
          color: supSeparetor,
          iconSize: 25.0,
          onPressed: () {
            final routerDelegate =
                Router.of(context).routerDelegate as AppRouterDelegate;
            routerDelegate.handleNavigation(AppRoutes.newTask, task: task);
          },
        ),
      ),
    );
  }
}
