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
  final Color importanceColor;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggleCompleted,
    required this.onDelete,
    required this.importanceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      background: Container(
        color: Theme.of(context).textTheme.headlineLarge?.color,
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
        color: Theme.of(context).textTheme.labelMedium?.color,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              Icons.delete,
              color: tdWhite,
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
                    : task.importance == 'important'
                        ? importanceColor
                        : tdGrey,
              ),
              color: task.done
                  ? Theme.of(context).textTheme.headlineLarge?.color
                  : task.importance == 'important'
                      ? importanceColor.withOpacity(0.5)
                      : Theme.of(context).inputDecorationTheme.fillColor,
            ),
            child: task.done
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                    size: 16.0,
                  )
                : const SizedBox(),
          ),
        ),
        title: Row(
          children: [
            if (task.importance == 'important')
              Icon(Icons.priority_high,
                  color: importanceColor,
                  size: 16)
            else if (task.importance == 'low')
              Icon(Icons.arrow_downward,
                  color: Theme.of(context).textTheme.labelSmall?.color,
                  size: 16),
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                task.text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  decoration: task.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Theme.of(context).textTheme.bodySmall?.color,
                  color: task.done
                      ? Theme.of(context).textTheme.bodySmall?.color
                      : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ],
        ),
        subtitle: task.deadline != null
            ? Text(
                '${Messages.doBefore}: ${task.deadline!.day}/${task.deadline!.month}/${task.deadline!.year}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                    ))
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.info),
          color: Theme.of(context).textTheme.labelSmall?.color,
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
